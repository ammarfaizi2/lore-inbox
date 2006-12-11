Return-Path: <linux-kernel-owner+w=401wt.eu-S1763067AbWLKUKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763067AbWLKUKZ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 15:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763068AbWLKUKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 15:10:25 -0500
Received: from smtp.osdl.org ([65.172.181.25]:60195 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763066AbWLKUKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 15:10:24 -0500
Date: Mon, 11 Dec 2006 12:09:26 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Olaf Hering <olaf@aepfle.de>
cc: Andy Whitcroft <apw@shadowen.org>, Herbert Poetzl <herbert@13thfloor.at>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-git13: uts banner changes break SLES9 (at least)
In-Reply-To: <Pine.LNX.4.64.0612111204010.12500@woody.osdl.org>
Message-ID: <Pine.LNX.4.64.0612111206090.12500@woody.osdl.org>
References: <457D750C.9060807@shadowen.org> <20061211163333.GA17947@aepfle.de>
 <Pine.LNX.4.64.0612110840240.12500@woody.osdl.org>
 <Pine.LNX.4.64.0612110852010.12500@woody.osdl.org> <20061211180414.GA18833@aepfle.de>
 <20061211181813.GB18963@aepfle.de> <Pine.LNX.4.64.0612111022140.12500@woody.osdl.org>
 <20061211182908.GC7256@MAIL.13thfloor.at> <Pine.LNX.4.64.0612111040160.12500@woody.osdl.org>
 <457DAF99.4050106@shadowen.org> <20061211195628.GA19889@aepfle.de>
 <Pine.LNX.4.64.0612111204010.12500@woody.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Dec 2006, Linus Torvalds wrote:
> 
> So I would suggest SLES now show that support by fixing THEIR BUG.

Btw, if you still want to use "get_kernel_version" or whatever the broken 
program was, I'd suggest:

 - extend the check to verify that the version number that follows looks 
   valid. It had better be something like a number with dots and perhaps a 
   "v" in front of it or something.

 - extend the check to check that it has parenthesis and a date there 
   somewhere too.

In other words, make the string grep really REALLY anal. Rather than grep 
for something totally trivial like "Linux version " that is so common that 
I could easily see it finding that particular string sequence in any 
random binary, not just the Linux kernel (eg some internal thing that says 
"tested with Linux version 2.6")

		Linus

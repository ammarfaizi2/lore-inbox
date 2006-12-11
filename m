Return-Path: <linux-kernel-owner+w=401wt.eu-S937021AbWLKStU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937021AbWLKStU (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 13:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937470AbWLKStU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 13:49:20 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:37456 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937021AbWLKStT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 13:49:19 -0500
Date: Mon, 11 Dec 2006 19:49:29 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andy Whitcroft <apw@shadowen.org>, Herbert Poetzl <herbert@13thfloor.at>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-git13: uts banner changes break SLES9 (at least)
Message-ID: <20061211184929.GA19262@aepfle.de>
References: <457D750C.9060807@shadowen.org> <20061211163333.GA17947@aepfle.de> <Pine.LNX.4.64.0612110840240.12500@woody.osdl.org> <Pine.LNX.4.64.0612110852010.12500@woody.osdl.org> <20061211180414.GA18833@aepfle.de> <20061211181813.GB18963@aepfle.de> <Pine.LNX.4.64.0612111022140.12500@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612111022140.12500@woody.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, Linus Torvalds wrote:

> 
> 
> On Mon, 11 Dec 2006, Olaf Hering wrote:
> > 
> > Hmm, even moving this to linux_banner doesnt work, just because
> > __initdata is in a different section.
> 
> Heh. Let's just change the "version_read_proc" string to not trigger.
> 
> Something like this instead (which replaces the "Linux" with "%s" in 
> /proc, and just takes it from "utsname()->sysname" instead. So now you can 
> lie and call yourself "OS X" in your virtual partition if you want to ;)

Yes, that works. Thanks.

And if I'm really bored, I will dig up the reason why the very same
binary has to identify itself with different kernelreleases.

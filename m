Return-Path: <linux-kernel-owner+w=401wt.eu-S937469AbWLKS5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937469AbWLKS5E (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 13:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763020AbWLKS5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 13:57:04 -0500
Received: from smtp.osdl.org ([65.172.181.25]:54063 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763009AbWLKS5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 13:57:03 -0500
Date: Mon, 11 Dec 2006 10:43:13 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Herbert Poetzl <herbert@13thfloor.at>
cc: Olaf Hering <olaf@aepfle.de>, Andy Whitcroft <apw@shadowen.org>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-git13: uts banner changes break SLES9 (at least)
In-Reply-To: <20061211182908.GC7256@MAIL.13thfloor.at>
Message-ID: <Pine.LNX.4.64.0612111040160.12500@woody.osdl.org>
References: <457D750C.9060807@shadowen.org> <20061211163333.GA17947@aepfle.de>
 <Pine.LNX.4.64.0612110840240.12500@woody.osdl.org>
 <Pine.LNX.4.64.0612110852010.12500@woody.osdl.org> <20061211180414.GA18833@aepfle.de>
 <20061211181813.GB18963@aepfle.de> <Pine.LNX.4.64.0612111022140.12500@woody.osdl.org>
 <20061211182908.GC7256@MAIL.13thfloor.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Dec 2006, Herbert Poetzl wrote:
> 
> cool!
> 
> should definitely work for all 'known' cases

No it doesn't.

Do a

	git grep '".*Linux version .*"'

on the kernel, and see just how CRAP that "get_kernel_version" test is, 
and has always been.

But let's hope that CIFS is never compiled into a SLES kernel. Because 
this isn't worth fixing at that point, and the SLES people should just fix 
their piece of crap initrd script.

And next time somebody says "random vmlinux binary" to me, I'll blacklist 
their email address. You shouldn't do initrd for "random binaries". Just 
pass the release name somewhere (maybe in the name of the binary, for 
example, and if the name doesn't have a version in it, tough titties).

		Linus

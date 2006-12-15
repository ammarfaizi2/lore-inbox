Return-Path: <linux-kernel-owner+w=401wt.eu-S1030697AbWLPHuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030697AbWLPHuF (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 02:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030694AbWLPHuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 02:50:04 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4412 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030697AbWLPHuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 02:50:03 -0500
Date: Fri, 15 Dec 2006 12:53:35 +0000
From: Pavel Machek <pavel@suse.cz>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       LKML Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Mach-O binary format support and Darwin syscall personality [Was: uts banner changes]
Message-ID: <20061215125335.GB4551@ucw.cz>
References: <457D750C.9060807@shadowen.org> <20061211163333.GA17947@aepfle.de> <Pine.LNX.4.64.0612110840240.12500@woody.osdl.org> <Pine.LNX.4.64.0612110852010.12500@woody.osdl.org> <20061211180414.GA18833@aepfle.de> <20061211181813.GB18963@aepfle.de> <Pine.LNX.4.64.0612111022140.12500@woody.osdl.org> <320BD259-74D6-411F-82A4-4BF3CB15012F@mac.com> <Pine.LNX.4.64.0612120815550.6452@woody.osdl.org> <D571C4CB-3D52-446C-802E-024C4C333562@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D571C4CB-3D52-446C-802E-024C4C333562@mac.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> So I guess all I have to do is:
>   (A)  Write a bunch of new syscall handlers taking 
>   arguments of the  same types as the Darwin syscall 
> handlers,
>   (B)  Figure out how to switch tables depending on the 
>   "syscall  personality" of "current"
>   (C)  Figure out how to set the "syscall personality" 
>   of "current"  from my Mach-O binary format module.
> 
> (A) seems fairly straightforward, if unusually tedious 
> and error- prone, but I'm totally in the dark for (B) 
> and (C).  Any help would  be much appreciated.

try strace osx_binary. If syscall interface is similar enough, perhaps
it is possible to do it with ptrace() :-).
							Pavel
-- 
Thanks for all the (sleeping) penguins.

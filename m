Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137062AbREKHFF>; Fri, 11 May 2001 03:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137061AbREKHEy>; Fri, 11 May 2001 03:04:54 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:2564 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S137060AbREKHEo>;
	Fri, 11 May 2001 03:04:44 -0400
Date: Mon, 7 May 2001 19:03:22 +0000
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Kai Henningsen <kaih@khms.westfalen.de>, linux-kernel@vger.kernel.org
Subject: vsyscalls [was Re: X15 alpha release: as fast as TUX but in user space (fwd)]
Message-ID: <20010507190320.A45@(none)>
In-Reply-To: <80BTbB7Hw-B@khms.westfalen.de> <E14vFXu-0005FC-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E14vFXu-0005FC-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, May 03, 2001 at 10:37:12AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > PS: Hmm, how do you do timewarp for just one userland appliation with
> > > this installed?
> > 
> > 1. What on earth for?
> 
> Y2K testing was one previous example.
> 
> > 2. How do you do it today, and why wouldn't that work?
> 
> LD_PRELOAD and providing its still using a lib call it would. I dont see the
> original posters problem

LD_PRELOAD is not reliable: application may do syscall itself and find
out true time. But ptrace works currently and *is* reliable.

Problem is that vsyscalls ay take ability to use ptrace to fool apps away.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.


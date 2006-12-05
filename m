Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968055AbWLEDiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968055AbWLEDiG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 22:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968058AbWLEDiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 22:38:06 -0500
Received: from smtp.osdl.org ([65.172.181.25]:42455 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968055AbWLEDiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 22:38:03 -0500
Date: Mon, 4 Dec 2006 19:37:43 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
cc: art@usfltd.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ben Collins <ben.collins@ubuntu.com>,
       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: 2.6.19 git compile error - "current_is_keventd" [drivers/net/phy/libphy.ko]
 undefined 
In-Reply-To: <200612050129.kB51TBaC027403@laptop13.inf.utfsm.cl>
Message-ID: <Pine.LNX.4.64.0612041934270.3476@woody.osdl.org>
References: <200612050129.kB51TBaC027403@laptop13.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 4 Dec 2006, Horst H. von Brand wrote:

> art@usfltd.com wrote:
> > 2006/12/04/18:00 CST
> > 
> >   Building modules, stage 2.
> > Kernel: arch/x86_64/boot/bzImage is ready  (#2)
> >   MODPOST 1256 modules
> > WARNING: "current_is_keventd" [drivers/net/phy/libphy.ko] undefined!
> > make[1]: *** [__modpost] Error 1
> > make: *** [modules] Error 2
> 
> Also i686, sparc64. At drivers/net/phy/phy.c:590 is the lone reference to
> current_is_keventd in that directory.  Still present as of ff51a9...

Yeah, I'm waiting for this whole mess to be either explained or reverted. 
There are apparently bigegr issues with it than just the butt-ugly 
"current_is_keventd()" crud.

		Linus

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316213AbSHUP5g>; Wed, 21 Aug 2002 11:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318169AbSHUP5g>; Wed, 21 Aug 2002 11:57:36 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:36335 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316213AbSHUP5f>; Wed, 21 Aug 2002 11:57:35 -0400
Subject: Re: [patch] IPMI driver for Linux
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Corey Minyard <minyard@acm.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D63B612.8020706@acm.org>
References: <3D63B612.8020706@acm.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 21 Aug 2002 17:02:44 +0100
Message-Id: <1029945764.26845.93.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-21 at 16:47, Corey Minyard wrote:
> I have been working on an IPMI driver for Linux for MontaVista, and I 
> think it's ready to see the light of day :-).  I would like to see this 
> included in the mainstream kernel eventually.   You can get it at 
> http://home.attbi.com/~minyard.  It should work on any kernel version, 
> although you will have to fix up the Config.in and Makefile, and the 
> Configure.help stuff may not work (it's currently in the 2.4 location).
> 
> The web page has documentation on the driver, and documentation is 
> included in the patch, too.  This is a fairly full-featured driver with 
> a watchdog, panic event generation, full kernel and userland access to 
> the driver, multi-user/multi-interface support, and emulators for other 
> IPMI device drivers.

Comments in general.

It touches user space with spinlocks held -> bad idea
It doesnt check copy_*_user returns instead commenting that some other
driver didnt so it wont - bad idea too
It seems to be allocating a major - can you have > 1 ipmi per host, can
it use misc devices, can it get one registered properly with lanana

Otherwise its way way way nicer than the hideous thing a certain chip
vendor sent me.


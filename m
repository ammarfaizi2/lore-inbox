Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261508AbTCGLDF>; Fri, 7 Mar 2003 06:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261499AbTCGLB2>; Fri, 7 Mar 2003 06:01:28 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:41373 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261521AbTCGLBQ>; Fri, 7 Mar 2003 06:01:16 -0500
Message-Id: <4.3.2.7.2.20030307115500.00b72610@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Fri, 07 Mar 2003 12:12:50 +0100
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: Re: [RFC] i386-arch fixes/enhancements
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Nice to see somebody is pushing this. I am getting fed up wtih
	applying these to every 2.4.xx.
	Note that with GCC >= 3.x(Not sure about "x", definitely 3.2), the P4 
compile option correctly
	generates add/sub instructions instead of the "P4 killer" inc/dec.
	Of course, in include/asm-i386, we still have incs/decs in
	processor.h, atomic.h, rwsem.h, semaphore.h uaccess.h, system.h,
	string.h, spinlock.h and smplock.h.
	With the patches and changing the includes, I can get a 5-10% improvement
	with a hefty DB app on a UP P4 which isn't to be sneezed at.
	And perhaps somebody should take a squint at the "copy_xxx_user".
	IMHO, this really should be inlined.
	Try running a DB app which bounces semaphores at a terrific rate and what
	do you see at the top of readprofile ? Yep, you guessed it.

	Margit


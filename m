Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136267AbRDVS6S>; Sun, 22 Apr 2001 14:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136265AbRDVS6I>; Sun, 22 Apr 2001 14:58:08 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:13841 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136267AbRDVS56>; Sun, 22 Apr 2001 14:57:58 -0400
Subject: Re: BUG: Global FPU corruption in 2.2
To: dek_ml@konerding.com (David Konerding)
Date: Sun, 22 Apr 2001 19:59:15 +0100 (BST)
Cc: drepper@cygnus.com (Ulrich Drepper), root@chaos.analogic.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <3AE3255F.61D40FDE@konerding.com> from "David Konerding" at Apr 22, 2001 11:39:27 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14rP4o-0006NP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> OK, regardless of how the linux kernel actually manages the FPU for user-space
> 
> programs, does anybody have any comments on the original bugreport?

Complete mystification.

> >of pi begins to look wrong.  Then kill everything and run pi by itself
> >again.  It will no longer produce good results.  We find that the FPU
> >persistently gives bad results until we reboot.
> 
> I tried this on my dual PIII-600 runnng 2.2.19 and got exactly the behavior
> described.

This is the most odd bit of all. The processor state for the FPU is per task
private and each task initializes its own FPU state. In terms of FPU state
itself I don't currently see what there is that can be left behind


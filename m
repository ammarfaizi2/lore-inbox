Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262116AbRFLQEg>; Tue, 12 Jun 2001 12:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262120AbRFLQEQ>; Tue, 12 Jun 2001 12:04:16 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:4106 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262116AbRFLQEJ>; Tue, 12 Jun 2001 12:04:09 -0400
Subject: Re: PC keyboard rate/delay
To: __gsr@mail.ru
Date: Tue, 12 Jun 2001 17:02:39 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <19562259.20010612181949@mail.ru> from "Sergey Tursanov" at Jun 12, 2001 06:19:49 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E159qcp-0001XE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In file include/linux/kd.h was declared KDKBDREP ioctl number
> to tune up keyboard rate/delay with struct kbd_repeat.
> But in 2.4.x kernel there is only m68k version for that.
> I wrote some code for implement this feature on x86 machines.
> Gzipped and uuencoded patch for kernel 2.4.5 is attached.
> To setup keyboard rate/delay on x86 you should use code like that:
> 
> struct kbd_repeat kbd_rep={
>        1000,      /* delay in ms */
>        30         /* repeat rate in cps */
> };
> ioctl(0,KDKBDREP,&kbd_rep);
> 
> After that ioctl kbd_rep is filled with previous values.
> I hope it will be useful for someone.

You must have been reading my mind. Yesterday I traced at least one X11
hang down to the kernel and X server both frobbing with the port at the same
time and crashing the microcontroller on my PC110.

Alan


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135283AbRDLTmG>; Thu, 12 Apr 2001 15:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135278AbRDLTjq>; Thu, 12 Apr 2001 15:39:46 -0400
Received: from dystopia.lab43.org ([209.217.122.210]:31422 "EHLO
	dystopia.lab43.org") by vger.kernel.org with ESMTP
	id <S135271AbRDLTjO>; Thu, 12 Apr 2001 15:39:14 -0400
Date: Thu, 12 Apr 2001 15:37:11 -0400 (EDT)
From: Rod Stewart <stewart@dystopia.lab43.org>
To: Andrew Morton <andrewm@uow.edu.au>
cc: <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: 8139too: defunct threads
In-Reply-To: <3AD5F9FE.9A49374D@uow.edu.au>
Message-ID: <Pine.LNX.4.33.0104121530470.31525-100000@dystopia.lab43.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 12 Apr 2001, Andrew Morton wrote:
> Rod Stewart wrote:
> >
> > Hello,
> >
> > Using the 8139too driver, 0.9.15c, we have noticed that we get a defunct
> > thread for each device we have; if the driver is built into the kernel.
> > If the driver is built as a module, no defunct threads appear.
>
> What is the parent PID for the defunct tasks?  zero?

According to ps, 1

[root@stewart-nw34 networking]# ps alexw
  F   UID PID  PPID PRI  NI   VSZ  RSS WCHAN  STAT TTY TIME  COMMAND
044     0  14     1   9   0     0    0 do_exi Z    ?  0:00 [eth0 <defunct>]
044     0  15     1   9   0     0    0 do_exi Z    ?  0:00 [eth1 <defunct>]
044     0  16     1   9   0     0    0 do_exi Z    ?  0:00 [eth2 <defunct>]
040     0 240     1   9   0     0    0 rtl813 SW   ?  0:00 [eth0]

-Rms


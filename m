Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317148AbSGCSci>; Wed, 3 Jul 2002 14:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317152AbSGCSch>; Wed, 3 Jul 2002 14:32:37 -0400
Received: from chaos.analogic.com ([204.178.40.224]:14976 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S317148AbSGCScg>; Wed, 3 Jul 2002 14:32:36 -0400
Date: Wed, 3 Jul 2002 14:35:54 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Xinwen - Fu <xinwenfu@cs.tamu.edu>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel timers vs network card interrupt
In-Reply-To: <Pine.SOL.4.10.10207031302500.29084-100000@dogbert>
Message-ID: <Pine.LNX.3.95.1020703143207.1862A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jul 2002, Xinwen - Fu wrote:

> Hi, all,
> 	I'm curious that if a network card interrupt happens at the same
> time as the kernel timer expires, what will happen?
> 
> 	It's said the kernel timer is guaranteed accurate. But if
> interrupts are not masked off, the network interrupt also should get
> response when a kernel timer expires. So I don't know who will preempt
> who.
> 
> 	Thanks for information!
> 
> Xinwen Fu

The highest priority interrupt will get serviced first. It's the timer.
Interrupts are serviced in priority-order. Hardware "remembers" which
ones are pending so none are lost if some driver doesn't do something
stupid.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.


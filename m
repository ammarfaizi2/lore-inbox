Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268938AbRG0TaI>; Fri, 27 Jul 2001 15:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268939AbRG0T36>; Fri, 27 Jul 2001 15:29:58 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:58123 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268938AbRG0T3s>; Fri, 27 Jul 2001 15:29:48 -0400
Subject: Re: Linux 2.4.7-ac1 PNP Oops on shutdown
To: reality@delusion.de (Udo A. Steinberg)
Date: Fri, 27 Jul 2001 20:31:09 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <no.id> from "Udo A. Steinberg" at Jul 27, 2001 08:49:19 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15QDKH-0006KQ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> 2.4.7-ac1 oopses reproduceably during every shutdown. As far as I can tell,
> 2.4.6-ac5 didn't exhibit this behaviour.

>From the trace that looks what I would expect

> >>EIP; c0112b5d <complete+1d/a0>   <=====
> Trace; c011792d <complete_and_exit+d/20>
> Trace; c01dde51 <pnp_dock_thread+d1/e0>
> Trace; c01054c8 <kernel_thread+28/40>
> Code;  c0112b5d <complete+1d/a0>
> 00000000 <_EIP>:
> Code;  c0112b5d <complete+1d/a0>   <=====
>    0:   8b 03                     mov    (%ebx),%eax   <=====

Its oopsing in the complete_and_exit changes killing the PnP docking thread.

A quick look over the code and I have to admit I don't see why that happened
I'll ponder it later


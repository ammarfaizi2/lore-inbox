Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270495AbRHYTKY>; Sat, 25 Aug 2001 15:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270593AbRHYTKO>; Sat, 25 Aug 2001 15:10:14 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:26891 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270495AbRHYTKG>; Sat, 25 Aug 2001 15:10:06 -0400
Subject: Re: Oops when loading floppy.o
To: marcelo.magallon@bigfoot.com (Marcelo E. Magallon)
Date: Sat, 25 Aug 2001 20:13:25 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010825191113.A373@ysabell.wh.vaih> from "Marcelo E. Magallon" at Aug 25, 2001 07:11:13 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ais1-00081T-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  someone told me this is a known problem but not 100% reproduceable.
>  Attached are the ksymoops and dmesg output.  The machine where this
>  happens doesn't have floppy drive and has the floppy controller
>  disabled at the BIOS level.  Please mail me if you need more
>  information and keep me on the Cc: line.

I can reproduce it to order. The floppy driver has done this since before
2.4.0 in this specific case I think. It actual stops installs working on
the problem box I have

> >>EIP; c0117602 <__run_task_queue+12/60>   <=====
> Trace; c011a2f6 <immediate_bh+16/20>
> Trace; c011756a <bh_action+1a/50>

Thats the important bit I think, its not killing off all the stuff it set up
when it exits. Its not an XFS triggered bug, so the trace is useful

Alan

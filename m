Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266543AbUHBOvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266543AbUHBOvW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 10:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266574AbUHBOs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 10:48:29 -0400
Received: from chaos.analogic.com ([204.178.40.224]:62342 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S266565AbUHBOrh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 10:47:37 -0400
Date: Mon, 2 Aug 2004 10:46:59 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Zwane Mwaikambo <zwane@linuxpower.ca>
cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: finding out the boot cpu number from userspace
In-Reply-To: <Pine.LNX.4.58.0408021028010.4095@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.53.0408021038550.19226@chaos>
References: <20040802121635.GE14477@devserv.devel.redhat.com>
 <Pine.LNX.4.58.0408021028010.4095@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Aug 2004, Zwane Mwaikambo wrote:

> On Mon, 2 Aug 2004, Arjan van de Ven wrote:
>
> > assuming cpu 0 is the boot cpu sounds fragile/incorrect, but for irqbalanced
> > I'd like to find out which cpu is the boot cpu, is there a good way of doing
> > so ?
> >
> > The reason for needing this is that some firmware only likes running on the
> > boot cpu so I need to bind firmware-related irq's to that cpu ideally.
>
> How about something like mptable which will give you the BSP flag from the
> MP table? I believe this gropes around /dev/mem.

Once CPUs other than 0 are enabled, they take part in the boot
process. They don't spin forever so I don't understand the notion
of 'boot CPU'.

Also firmware has no clue about what CPU is tickling it. There is no
possible way for it to find out, or even care. If some hardware
engineer claimed differently, he/she/it is pulling your chain (or
needs to learn how busses, CPUs and FPGAs work)! There is a
Virtual Wire specification that guarantees that no firmware
can possibly care.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129186AbQKPN6m>; Thu, 16 Nov 2000 08:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130139AbQKPN6c>; Thu, 16 Nov 2000 08:58:32 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:35120 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129186AbQKPN6U>; Thu, 16 Nov 2000 08:58:20 -0500
Subject: Re: [PATCH] pcmcia event thread. (fwd)
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Thu, 16 Nov 2000 13:28:26 +0000 (GMT)
Cc: dwmw2@infradead.org (David Woodhouse), linux-kernel@vger.kernel.org
In-Reply-To: <3A0FF138.A510B45@mandrakesoft.com> from "Jeff Garzik" at Nov 13, 2000 08:48:40 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13wP5a-0007nk-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> it looks like the loop can be simplified to
> 
> while (1) {
> 	mb();
> 	active = tq_pcmcia;
> 	if (!active)
> 		interruptible_sleep_on(&event_thread_wq);
> 	if (signal_pending(current)
> 		break;
> 	run_task_queue(&tq_pcmcia);
> }

Not if you want it to work

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

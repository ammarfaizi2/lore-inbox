Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130119AbRAUXOe>; Sun, 21 Jan 2001 18:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130521AbRAUXOZ>; Sun, 21 Jan 2001 18:14:25 -0500
Received: from cnq0-9.cablevision.qc.ca ([24.212.0.9]:46086 "EHLO
	cnqnt02.Cablevision.qc.ca") by vger.kernel.org with ESMTP
	id <S130119AbRAUXOR>; Sun, 21 Jan 2001 18:14:17 -0500
Message-ID: <3A6B6D63.5673EC41@nwb.qc.ca>
Date: Sun, 21 Jan 2001 18:14:43 -0500
From: Keven Belanger <kevenb@nwb.qc.ca>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.3.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problems with sound card and NIC
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, I got a problem: since several version of the kernel we can't
choose the io, irq, dma, etc... for the oss 100% compatible sound
blaster sound card, my sound card should be set on irq 5.  In kernel
version 2.3.42 my sound card is irq 5 and my net card is irq 10, but
when I try to build a kernel newer than 2.3.42 (I think that 2.3.42 is
the last one where we can choose the settings of the sound card) I got a

problem: the kernel put irq 5 on my network card and didn't detect my
sound blaster card (SB32).

How can I tell to the kernel (2.4.0) that my nic (AcerLAN ALN-101) is
irq 5 ?
I use the NE2000 driver for this one...
And how can I tell to the kernel to use irq 5 for my sb32 card ?

This is a snippet of "procinfo" for kernel version 2.3.42 and 2.4.0
Please help my cause I really need another kernel version that the old
2.3.42...
Note: 2.2.16 and 2.2.17 don't work too cause again we can't choose the
irq, dma, etc...

2.3.42:
irq  0:      5559 timer                 irq 10:        12 NE2000
irq  1:       152 keyboard           irq 11:        65 fdomain
irq  2:         0 cascade [4]         irq 12:         0 PS/2 Mouse
irq  5:         1 soundblaster       irq 13:         1 fpu
irq  6:         3                              irq 14:     49418 ide0

2.4.0:
irq  0:    579821 timer                 irq  6:         3
irq  1:      6043 keyboard            irq 11:        65 fdomain
irq  2:         0 cascade [4]           irq 12:      1220 PS/2 Mouse
irq  5:         0 NE2000                 irq 14:     77770 ide0

Thank you so much !!!

-Keven-

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130612AbQKVA1A>; Tue, 21 Nov 2000 19:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131326AbQKVA0v>; Tue, 21 Nov 2000 19:26:51 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:62292 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130612AbQKVA0n>; Tue, 21 Nov 2000 19:26:43 -0500
Subject: Re: linux-2.2.18-pre19 asm/delay.h problem?
To: jpranevich@lycos-inc.com
Date: Tue, 21 Nov 2000 23:57:02 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <0525699E.00832462.00@SMTPNotes1.ma.lycos.com> from "jpranevich@lycos-inc.com" at Nov 21, 2000 06:51:39 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13yNHb-0005O4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> module that is pulling the definition of udelay() from asm/delay.h, it's
> referencing __bad_udelay(). However, I can't seem to find the __bad_udelay()
> function actually defined anyplace. (Although it could be somewhere in the
> kernel source that my grep missed.)

Its intentionally missing

> Would this be a bug in the module that I'm compiling? Or a real forgotten and

You got it. The module is doing an overlarge delay

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

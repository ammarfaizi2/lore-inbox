Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129708AbQKGVse>; Tue, 7 Nov 2000 16:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129722AbQKGVsZ>; Tue, 7 Nov 2000 16:48:25 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:1298 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129708AbQKGVsN>; Tue, 7 Nov 2000 16:48:13 -0500
Subject: Re: Pentium 4 and 2.4/2.5
To: x_coder@hotmail.com (Lyle Coder)
Date: Tue, 7 Nov 2000 21:48:40 +0000 (GMT)
Cc: andre@linux-ide.org (Andre Hedrick), alan@lxorguk.ukuu.org.uk (Alan Cox),
        fdavis112@juno.com (Frank Davis), linux-kernel@vger.kernel.org
In-Reply-To: <OE59dY2pjID9Lv40q2H00001e2c@hotmail.com> from "Lyle Coder" at Nov 07, 2000 01:06:11 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13tGbg-0007oC-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> are you saying that rep;nop is not needed in the spinlocks? (because they
> are for P4)

rep;nop is a magic instruction on the PIV and possibly some PIII series CPUs
[not sure]. As far as I can make out it naps momentarily or until bus
activity thus saving power on spinlocks.

The problem is 'rep nop' is not defined on other cpus so we can only really use
it on the PIII/PIV kernel builds

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

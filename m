Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280919AbRKLSIT>; Mon, 12 Nov 2001 13:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280917AbRKLSIK>; Mon, 12 Nov 2001 13:08:10 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:43023 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280911AbRKLSHv>; Mon, 12 Nov 2001 13:07:51 -0500
Subject: Re: IDE SiS730 / SiS5513 incorrect defaults kernel 2.4.9
To: rramstad@alum.mit.edu (Bob Ramstad)
Date: Mon, 12 Nov 2001 18:14:56 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200111121747.JAA11329@jerry-garcia.accessgroupinc.com> from "Bob Ramstad" at Nov 12, 2001 09:47:42 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E163Lbk-0006eA-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Oct 22 12:46:12 accessgroupinc kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> Oct 22 12:46:12 accessgroupinc kernel: hdc: dma_intr: error=0x84 { DriveStatusError BadCRC }

Cable error. At least thats what the drive saw and the checksum is
computed controller<->drive without our involvement

> My primary concern is that the IDE driver seems to be making different
> choices in 2.4.9-13 for this chipset, and earlier kernels are making
> better choices -- or possibly failing silently?  In any case, I

It may be the new kernel is smart enough to enable UDMA 100 and the cables
are marginal. The CRC error is a corruption that is then retried. Multiple
retries cause the kernel to drop to a lower UDMA speed

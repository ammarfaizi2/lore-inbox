Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130892AbRA3M0b>; Tue, 30 Jan 2001 07:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130889AbRA3M0Y>; Tue, 30 Jan 2001 07:26:24 -0500
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:6416 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id <S130643AbRA3M0O>; Tue, 30 Jan 2001 07:26:14 -0500
From: Norbert Preining <preining@logic.at>
Date: Tue, 30 Jan 2001 13:26:07 +0100
To: linux-kernel@vger.kernel.org
Subject: [BUG?] lost interrupt with 2.4.1-pre10
Message-ID: <20010130132607.J29001@alpha.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

With 2.4.1-pre10 I sometime get problems with my hda disk:
kernel: hda: timeout waiting for DMA
kernel: ide_dmaproc: chipset supported ide_dma_timeout func only: 14
kernel: hda: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
kernel: hda: DMA disabled

Now I disable dma at boot up -wth hdparm -d 0 /dev/hda

The real problem is that today I got:
kernel: hda: lost interrupt
And no chance to do anyting which needs access (lilo, even ps -ax)

My configuration:
MoBo: asus p5a-b with ALi 1533 chipset.
linux-2.4.1-test10

Best wishes

Norbert

-- 
ciao
norb

+-------------------------------------------------------------------+
| Norbert Preining              http://www.logic.at/people/preining |
| University of Technology Vienna, Austria        preining@logic.at |
| DSA: 0x09C5B094 (RSA: 0xCF1FA165) mail subject: get [DSA|RSA]-key |
+-------------------------------------------------------------------+
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

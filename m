Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267191AbSK3AVK>; Fri, 29 Nov 2002 19:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267192AbSK3AVJ>; Fri, 29 Nov 2002 19:21:09 -0500
Received: from smtp-02.inode.at ([62.99.194.4]:53434 "EHLO smtp.inode.at")
	by vger.kernel.org with ESMTP id <S267191AbSK3AVI> convert rfc822-to-8bit;
	Fri, 29 Nov 2002 19:21:08 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Patrick Petermair <black666@inode.at>
Reply-To: black666@inode.at
To: linux-kernel@vger.kernel.org
Subject: Problem with via82cxxx and vt8235
Date: Sat, 30 Nov 2002 01:29:32 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211300129.32580.black666@inode.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have a MSI KT3Ultra2 Motherboard with a VT8235 southbridge. I'm currently 
running kernel 2.4.19 - unfortunately it doesn't detect the southbridge, 
so I cannot enable dma.
I tried the patch from Vojtech Pavlik (via82cxxx), but then it hangs at 
boot:

hdc: status timeout: status=0xd0 { Busy }
hdc: status timeout: error=0x00
hdc: drive not ready for command
hdc: ATAPI reset timed-out, status=0x80
hdd: DMA disabled
ide1: reset: success
hdc: status timeout: status=0x80 { Busy }
hdc: status timeout: error=0x01IllegalLengthIndication
hdc: drive not ready for command
hdc: ATAPI reset timed-out, status=0x80
ide1: reset: success
hdc: status timeout: status=0x80 { Busy }
hdc: status timeout: error=0x01IllegalLengthIndication
end_request: I/O error, dev hdc, sector 0
hdc: drive not ready for command

I tried the last 2.5.x kernels and today the 2.4.20, everytime the same 
problem. 2.4.19 boots just fine, but without dma :-(

Btw: hdc ist my dvd drive:
starbase:/# cat proc/ide/hdc/model
TOSHIBA DVD-ROM SD-M1302
starbase:/#

Any hints? It's a real pain to work without dma....

Thanks,
Patrick


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280978AbRLAF3G>; Sat, 1 Dec 2001 00:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283931AbRLAF24>; Sat, 1 Dec 2001 00:28:56 -0500
Received: from mail6.speakeasy.net ([216.254.0.206]:51647 "EHLO
	mail6.speakeasy.net") by vger.kernel.org with ESMTP
	id <S280978AbRLAF2l>; Sat, 1 Dec 2001 00:28:41 -0500
Subject: 2.4.17-pre2 having dma problems with atapi devices
From: safemode <safemode@speakeasy.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 01 Dec 2001 00:28:39 -0500
Message-Id: <1007184520.408.0.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to write to a cd at 8x, which i could do in prior kernels
(2.4.15-prex and before), but now i'm getting cdrecord errors and
sometimes dma timeouts.  Seems that data is being corrupted somewhere
again.  I got this kind of performance when i had it on the promise
controller and when i moved it back to my via controller it worked
perfectly.  

Ide controller:  
 VIA vt82c686a (rev 22) IDE UDMA66 controller

CDR : CREATIVE CD-RW RW8438E, ATAPI CD/DVD-ROM drive 
(set as master and DMA set by kernel)

setting to a lower write speed allows successful writes.  


cdrecord error:
/usr/bin/cdrecord: Input/output error. send opc: scsi sendcmd: no error
CDB:  54 01 00 00 00 00 00 00 00 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 03 00 00 00 00 0A 00 00 00 00 73 03 00 00
Sense Key: 0x3 Medium Error, Segment 0
Sense Code: 0x73 Qual 0x03 (power calibration area error) Fru 0x0
Sense flags: Blk 0 (not valid) 
cmd finished after 17.724s timeout 60s
/usr/bin/cdrecord: Resource temporarily unavailable. OPC failed.
/usr/bin/cdrecord: fifo had 64 puts and 0 gets.
/usr/bin/cdrecord: fifo was 0 times empty and 0 times full, min fill was
100%.

The dma errors weren't very special,  same old dma timeout and reset
messages.    The cds are perfectly fine, i use the same one that errored
at 4x and it reads fine after burn.   




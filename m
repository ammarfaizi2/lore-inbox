Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265114AbSKJT1y>; Sun, 10 Nov 2002 14:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265117AbSKJT1x>; Sun, 10 Nov 2002 14:27:53 -0500
Received: from gemini.nr.no ([156.116.2.76]:62880 "EHLO gemini.nr.no")
	by vger.kernel.org with ESMTP id <S265114AbSKJT1w>;
	Sun, 10 Nov 2002 14:27:52 -0500
Date: Sun, 10 Nov 2002 20:34:35 +0100
Message-Id: <200211101934.gAAJYZt09539@triumph.nr.no>
To: linux-kernel@vger.kernel.org
Subject: Problem with VT8235 + DMA patch + PlexWriter W2410
From: Thor Kristoffersen <Thor.Kristoffersen@nr.no>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18Axqu-0003NF-00*88W4OLACFpY*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have tried, without success, to get a PlexWriter PX-W2410A (IDE/ATAPI CD
burner) to work with an MSI KT3 Ultra2 (KT333/VT8235) and Vojtech Pavlik's
DMA patch.  Any attempt to access the CD burner produces lots of messages
like these:

hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdc: drive not ready for command
hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdc: drive not ready for command
hdc: status error: status=0x59 { DriveReady SeekComplete DataRequest Error }
hdc: status error: error=0x54
hdc: drive not ready for command

The problem seems to be largely independent of the kernel version.  I have
tried 2.4.19, 2.4.20-preXX, and 2.5.46, with the same results.

Simply turning off DMA for the CD burner does not make it work: the
problem persists as long as the patch is present.  On the other hand, a
different CD burner (Sony CRX-140E) works just fine with the same
mainboard, with the patch present.


Thor

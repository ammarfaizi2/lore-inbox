Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261914AbSKUF1n>; Thu, 21 Nov 2002 00:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263256AbSKUF1n>; Thu, 21 Nov 2002 00:27:43 -0500
Received: from ns.cinet.co.jp ([210.166.75.130]:56839 "EHLO multi.cinet.co.jp")
	by vger.kernel.org with ESMTP id <S261914AbSKUF1m>;
	Thu, 21 Nov 2002 00:27:42 -0500
Message-ID: <E6D19EE98F00AB4DB465A44FCF3FA46903A318@ns.cinet.co.jp>
From: Osamu Tomita <tomita@cinet.co.jp>
To: "'LKML '" <linux-kernel@vger.kernel.org>
Cc: "'Alan Cox '" <alan@lxorguk.ukuu.org.uk>
Subject: 2.5.47-ac6 IDE test result
Date: Thu, 21 Nov 2002 14:34:44 +0900
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.
I've tested IDE HDD performance on 2.5.47-ac6.
Using old pentium-classic PC-9800 box, it has no DMA mode.

 1. "hdparm -t /dev/hda3" results (PIO mode)
  2.5.47-ac6 with Task file IO:    2.86MB/s
  2.5.47-ac6 without Task file IO: 2.90MB/s
  2.4.19 without Task file IO:     2.93MB/s

 2. Heavy usage test
  "cp -pr /usr/src /tmp/foo" (in same HDD)
  about 92000files/total size 2.3GB
  I had always "lost interrupt" message and FS corruption
   by this test at 2.5.20 days.
  2.5.47-ac6 works fine. (takes about 30 minutes.)

Thanks,
Osamu Tomita

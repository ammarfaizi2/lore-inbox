Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290083AbSAKT73>; Fri, 11 Jan 2002 14:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290077AbSAKT7W>; Fri, 11 Jan 2002 14:59:22 -0500
Received: from dark.pcgames.pl ([195.205.62.2]:16106 "EHLO dark.pcgames.pl")
	by vger.kernel.org with ESMTP id <S290081AbSAKT7M>;
	Fri, 11 Jan 2002 14:59:12 -0500
Date: Fri, 11 Jan 2002 20:58:43 +0100 (CET)
From: Krzysztof Oledzki <ole@ans.pl>
X-X-Sender: <ole@dark.pcgames.pl>
To: <linux-kernel@vger.kernel.org>
cc: <vojtech@suse.cz>, <andre@linux-ide.org>, <alan@lxorguk.ukuu.org.uk>
Subject: ide.2.2.21.05042001-Ole.patch.gz
Message-ID: <Pine.LNX.4.33.0201112043340.14442-100000@dark.pcgames.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have just modified Andre Hedrick's ide.2.2.19.05042001 patch. You can
find it at "http://www.ans.pl/ide/ide.2.2.21.05042001-Ole.patch.gz". It
should patch 2.2.21pre2 kernel without any warnings/errors. I also
bacported new VIA driver from 2.4.x kernel - this one uses correct IO port
as via_base so values displayed in /proc/ide/via file are now properly
calculated. Check the "BM-DMA base" value :)

Hopefully, devices which work in DMA mode, have DMA/UDMA value instead of
PIO in "Transfer Mode" now. It also should works better with some new
chipsets. If I found time I can also try to backport new Intel, Promise
and HPT drivers if no no one else is working on it. I believe I have
required hardware to test it.

I also have one question about IDE support in 2.4.x kernel. Why, with VIA
MVP3 chipset on my FIC 503+ board, with UDMA33/66/100 HDDs using 2.4.x
kernels I have only 13 MB/sec (tested with hdparm -t). With 2.2.x kernels
hdparm shows 17 MB/sec but with IDE support bacported from 2.4.x kernels
(2.2.19/2.2.20+original Andre Hedrick's patch) it is also 13 MB/sec.


Best regards,

                        Krzysztof Oledzki



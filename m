Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261523AbSKRGRC>; Mon, 18 Nov 2002 01:17:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261524AbSKRGRB>; Mon, 18 Nov 2002 01:17:01 -0500
Received: from pop.gmx.de ([213.165.64.20]:20812 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S261523AbSKRGRB>;
	Mon, 18 Nov 2002 01:17:01 -0500
Message-Id: <5.1.1.6.2.20021118070215.00cb8f98@wen-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Mon, 18 Nov 2002 07:20:58 +0100
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Mike Galbraith <efault@gmx.de>
Subject: 2.5.47 scheduler problems?
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

For testing swap throughput, I like to run make -j30 bzImage on my 500Mhz 
PIII w. 128Mb ram.  For testing interactivity, I fire up KDE, start a 
smaller make -j, grab a window, and wave it around.

With 2.4.20rc2+rc1aa1, running a -j10 build (not swapping) is very very 
bad.  However, if I set all tasks in the system to SCHED_FIFO or SCHED_RR 
prior to this light make -j, I have a ~pretty smooth system.

If I do the same in 2.5.47, I have no control of my box.  Setting all tasks 
to SCHED_FIFO or SCHED_RR prior to starting make -j10 bzImage, I can regain 
control, but interactivity under load is basically not present.

I used to be able to wave a window poorly at make -j25 (swapping heftily), 
fairly smoothly at make -j20, and smoothly at make -j15 or below.  This 
with no SCHED_RR/SCHED_FIFO.  (I haven't done much testing like this in 
quite a while though)

	-Mike


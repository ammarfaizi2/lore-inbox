Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263429AbUERO0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263429AbUERO0i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 10:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263366AbUERO0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 10:26:37 -0400
Received: from mns.spb.ru ([195.131.16.6]:19600 "EHLO mail.mns.spb.ru")
	by vger.kernel.org with ESMTP id S263435AbUERO0f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 10:26:35 -0400
From: Kirill Smelkov <kirr@mns.spb.ru>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [watchdog]: problem with wafer5823wdt
Date: Tue, 18 May 2004 18:26:31 +0400
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405181826.31080.kirr@mns.spb.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a problem with hardware watchdog doesn't working properly.
The watchdog seems to be equal to that on ICP Wafer 5823 motherboard.

---

My motherboard is PCISA-C800EV (integrated MB with VIA C3 processor).The 
watchdog hardware description seems to be exactly the same as in ICP Wafer 
5823, i.e.

there are 2 io ports:
0x443	(w/r)   to start the watchdog (w) and to 'touch' it (r)
0x843	(r)     to stop the watchdog

although writing to 0x443 starts the watchdog (with say for example 60 seconds 
timeout), it can't be updated, i.e. the system reboots no matter has the 
0x443 port been read or not.
The watchdog cannot be disabled (reading 0x843 has no effect) either.

According to MB documentation wafer5823wdt.c is ok for my hardware, but 
watchdog behaviour is very strange.

Any thoughts?

-- 
Kirill.

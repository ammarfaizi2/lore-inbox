Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267324AbUHSTn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267324AbUHSTn0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 15:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267323AbUHSTnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 15:43:07 -0400
Received: from tomts31-srv.bellnexxia.net ([209.226.175.105]:33022 "EHLO
	tomts31-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S267311AbUHSTmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 15:42:52 -0400
Reply-To: <ivan.kalatchev@esg.ca>
From: "Ivan Kalatchev" <ivan.kalatchev@esg.ca>
To: <linux-kernel@vger.kernel.org>
Subject: System time slowdown after upgrading from 2.4 to 2.6
Date: Thu, 19 Aug 2004 15:42:41 -0400
Message-ID: <000501c48624$b1ac72f0$2e646434@ivans>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

We have a project that uses PC-104 (ZFx86 100 MHz CPU) Linux box to acquire
some seismological signals. System resides on a M-Systems DiskOnChip 2000.
We have an ISA acquisition card that acquires data into FIFO buffer and
triggers interrupt as soon as 341 points were acquired (then this data is
read out in interrupt handler routine). System worked perfectly well when we
used 2.4.18 kernel. When I printk-ed system time (do_gettimeofday)  in
interrupt routine, at 1kHz sampling frequency interrupts were reported every
341 msec as they should do.
But after I've switched to 2.6 kernel (2.6.7 - preempted, then I tried
2.6.8 - non-preempted) time between successive interrupts at 1kHz became 335
msec, losing 6 msec at each interrupt. What is interesting, when sampling
frequency is 10 kHz, with 2.4.18 kernel interrupts are reported every 34
msec, which is right, but with 2.6 kernels interrupts are coming at 28 msec
interval, again losing same 6 msec!

Any ideas why this might happen?

Please, CC me all answers/comments posted to the list in response to this
posting.
Regards,

Ivan Kalatchev

Senior Software Developer
Engineering Seismology Group Canada Inc.
ISO 9001-2000
1 Hyperion Court, Kingston,
Ontarion, Canada K7K 7G3
phone: (613) 548-8287 ext.247
fax:     (613) 548-8917



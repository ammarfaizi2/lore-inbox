Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261814AbTD2MKq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 08:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbTD2MKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 08:10:46 -0400
Received: from [203.124.139.208] ([203.124.139.208]:61612 "EHLO
	pcsbom.patni.com") by vger.kernel.org with ESMTP id S261814AbTD2MKp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 08:10:45 -0400
Reply-To: <chandrasekhar.nagaraj@patni.com>
From: "Chandrasekhar" <chandrasekhar.nagaraj@patni.com>
To: <linux-kernel@vger.kernel.org>
Subject: Stack Trace dump in do_IRQ
Date: Tue, 29 Apr 2003 18:04:28 +0530
Message-ID: <NHBBIPBFKBJLCPPIPIBCCEAICAAA.chandrasekhar.nagaraj@patni.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
We have a custom driver which runs on Red Hat Advanced Server 2.1(kernel
version 2.4.9-e.3).
On loading  the driver (using insmod) and running our configuration program,
we got folowing warning message "do_IRQ: stack overflow: 1786" and along
with the stack trace.

The configuration program, however, ran successfully.

On going through the do_IRQ code in arch/i386/kernel/irq.c we found that is
is used for debugging check for stack overflow i.e if the stack size is less
than 2KB free.
There is no similar debugging check in other kernels like 2.4.7-10,2.4.18-3
and 2.4.18-14.
What is the significance of this debugging information and why other kernels
dont have the same check? Also, if the stack overflow can cause future
problems, then
how can we increase the stack size? Thanks in advance for any information on
this.

Thanks and Regards
Chandrasekhar


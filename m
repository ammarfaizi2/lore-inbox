Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbUG0Jg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbUG0Jg6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 05:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbUG0Jg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 05:36:58 -0400
Received: from [202.125.86.130] ([202.125.86.130]:40175 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S261763AbUG0JfA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 05:35:00 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: SuSE 9.1 NON SMP Linux box and SMP Linux box
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Date: Tue, 27 Jul 2004 15:05:47 +0530
Message-ID: <4EE0CBA31942E547B99B3D4BFAB34811067825@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: SuSE 9.1 NON SMP Linux box and SMP Linux box
Thread-Index: AcRzvCrbcnOdfFEkTuSdzfbvCjGh7g==
From: "Srinivas G." <srinivasg@esntechnologies.co.in>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We developed a device driver for PCI card under SuSe 9.1 with kernel
version 2.6.5-7.71. It was working fine in the NON SMP environment. It
was compiled and running fine under NON SMP environment(non SMP linux
box).

We tried to compile it on SMP Linux box with the same SuSe 9.1 having
the same kernel version 2.6.5-7.71. We got the following compilation
errors.

line 897: warning: passing arg 1 of  '_raw_spin_lock' from imcompatible
pointer type line 1051: error: Invalid type arguement of 'unary *'

We have gone through the code at that particular line numbers. In both
the places we found the spin lock related information only. The lines
were showed below.

line 897:
spin_lock_irqsave(&tiDev->genFM[uiSocket].blkqueue->queue_lock,flags);
line 1051:  spin_lock_init(gDisk->qlock);

What was the mistake? Any help greatly appreciated. Thanks in advance.

Regards,

Srinivas G


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261200AbVCaKYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbVCaKYP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 05:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbVCaKXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 05:23:07 -0500
Received: from general.keba.co.at ([193.154.24.243]:26805 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S261200AbVCaKWu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 05:22:50 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-25
Date: Thu, 31 Mar 2005 12:22:44 +0200
Message-ID: <AAD6DA242BC63C488511C611BD51F3673231CD@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-25
Thread-Index: AcU1z6jVlcblmR5PTUex12iC/pwQpgACw+xQ
From: "kus Kusche Klaus" <kus@keba.com>
To: "Ingo Molnar" <mingo@elte.hu>, <linux-kernel@vger.kernel.org>
Cc: "Lee Revell" <rlrevell@joe-job.com>, "Rui Nuno Capela" <rncbc@rncbc.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i have released the -V0.7.41-25 Real-Time Preemption patch, 
> which can be 
> downloaded from the usual place:

1. Does not compile without RT_DEADLOCK_DETECT:
kernel/rt.c: In function `change_owner':
kernel/rt.c:556: error: structure has no member named `debug'
kernel/rt.c: In function `pi_setprio':
kernel/rt.c:576: error: structure has no member named `debug'
kernel/rt.c: In function `task_blocks_on_lock':
kernel/rt.c:677: error: structure has no member named `debug'
kernel/rt.c:687: error: structure has no member named `debug'
kernel/rt.c: In function `__up_mutex':
kernel/rt.c:1223: error: structure has no member named `debug'

2. My problem (see my LKML mails yesterday) is not yet solved:
The latency tracer shows latencies of at most 40 microseconds,
but my test program at rtprio 99 sometimes did not get any CPU 
for milliseconds...

-- 
Klaus Kusche
Entwicklung Software - Steuerung
Software Development - Control

KEBA AG
A-4041 Linz
Gewerbepark Urfahr
Tel +43 / 732 / 7090-3120
Fax +43 / 732 / 7090-8919
E-Mail: kus@keba.com
www.keba.com

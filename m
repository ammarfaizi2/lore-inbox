Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263638AbUAOE6Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 23:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263661AbUAOE6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 23:58:24 -0500
Received: from fmr05.intel.com ([134.134.136.6]:43159 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S263638AbUAOE6X convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 23:58:23 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [RFC/PATCH] FUSYN Realtime & Robust mutexes for Linux try 2.1
Date: Wed, 14 Jan 2004 20:58:11 -0800
Message-ID: <A20D5638D741DD4DBAAB80A95012C0AE0169EE82@orsmsx409.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC/PATCH] FUSYN Realtime & Robust mutexes for Linux try 2.1
Thread-Index: AcPbBKW6TLPi4vvMRMq8zvyxPRVevQAH0AIg
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Bernhard Kuhn" <bkuhn@metrowerks.com>
Cc: <linux-kernel@vger.kernel.org>, <robustmutexes@lists.osdl.org>
X-OriginalArrivalTime: 15 Jan 2004 04:58:12.0151 (UTC) FILETIME=[2D481470:01C3DB24]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Bernhard Kuhn [mailto:bkuhn@metrowerks.com]

> > This code proposes an implementation of kernel based mutexes,
> 
> Pretty interessting stuff! I will inspect if i could combine
> it with the "real-time interrupts" i recently described
> (http://www.linuxdevices.com/articles/AT6105045931.html).

I saw it, nice trick!

> Currently i'm protecting critical areas with "prioritized
> spinlocks" that don't provide a priority inversion aviodance
> scheme. Having "real" mutexes with priority inheritence
> should be pretty helpfull to make the kernel hard real time
> aware.

Scratch, scratch. Well, the mutexes (fulocks) are implemented
using spinlocks; I mean, the spinlock protects the fulock
structure that describes the mutex (wait list, owner, etc),
so I am afraid we'd be chasing our tail.

What's special about the prioritized spinlocks? I don't remember
having read about that in the article.

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own (and my fault)

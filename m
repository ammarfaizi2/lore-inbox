Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbTKLE06 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 23:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbTKLE06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 23:26:58 -0500
Received: from fmr06.intel.com ([134.134.136.7]:39567 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S261345AbTKLE05 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 23:26:57 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: pthread condition variables question
Date: Tue, 11 Nov 2003 20:26:53 -0800
Message-ID: <A20D5638D741DD4DBAAB80A95012C0AED791DD@orsmsx409.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: pthread condition variables question
Thread-Index: AcOnvzaOBRGPYyxdTgqg056bgh7MTQBFbR9Q
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "sankar" <san_madhav@hotmail.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 12 Nov 2003 04:26:53.0667 (UTC) FILETIME=[332E2B30:01C3A8D5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: sankar

> How is pthread condition variables implemented on linux. Specifically I want
> to know how pthread_cond_signal() wakes the waiting thread. Does it send any
> specific signal to the waiting thread or is there any other means??

Using futexes (wait queues); http://people.redhat.com/drepper/futex.pdf.

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own (and my fault)

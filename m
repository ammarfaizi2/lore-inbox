Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbVLHSx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbVLHSx2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 13:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbVLHSx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 13:53:28 -0500
Received: from fmr22.intel.com ([143.183.121.14]:34967 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S932158AbVLHSx1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 13:53:27 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="GB2312"
Content-Transfer-Encoding: 8BIT
Subject: RE: [BUG] Variable stopmachine_state should be volatile
Date: Thu, 8 Dec 2005 10:53:14 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F0526C57B@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BUG] Variable stopmachine_state should be volatile
Thread-Index: AcX3FyKnyRKZ1LJdR+WciiNOD370YgEf3qogACRx4pA=
From: "Luck, Tony" <tony.luck@intel.com>
To: "Zhang, Yanmin" <yanmin.zhang@intel.com>,
       "Arjan van de Ven" <arjan@infradead.org>, "Pavel Machek" <pavel@ucw.cz>
Cc: <linux-kernel@vger.kernel.org>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       "Shah, Rajesh" <rajesh.shah@intel.com>, <linux-ia64@vger.kernel.org>
X-OriginalArrivalTime: 08 Dec 2005 18:53:15.0230 (UTC) FILETIME=[A54FF7E0:01C5FC28]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The right approach is to define ia64_hint to ia64_barrier in file
> include/asm-ia64/intel_intrin.h. I tested the new approach and it
> does work.

Does that get you a "hint@pause" instruction inside the loop?  If not, then
it isn't all the way to the "right" approach.

-Tony

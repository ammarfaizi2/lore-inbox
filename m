Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263230AbUJ2BqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263230AbUJ2BqT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 21:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263240AbUJ2Bmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 21:42:42 -0400
Received: from fmr05.intel.com ([134.134.136.6]:23171 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S263241AbUJ2BlK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 21:41:10 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Fixing MTRR smp breakage and suspending sysdevs.
Date: Fri, 29 Oct 2004 09:41:03 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD305756F2F71@pdsmsx402.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Fixing MTRR smp breakage and suspending sysdevs.
Thread-Index: AcS9Jd0NPWHoQJJuTLKE+/yqudzjzgAMWpDw
From: "Li, Shaohua" <shaohua.li@intel.com>
To: "Pavel Machek" <pavel@ucw.cz>
Cc: <ncunningham@linuxmail.org>, "Patrick Mochel" <mochel@digitalimplant.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 29 Oct 2004 01:41:05.0299 (UTC) FILETIME=[5AE5AE30:01C4BD58]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >> Is the problem MTRR resume must be with IRQ enabled, right? Could
we
>> >> implement a method sysdev resume with IRQ enabled? MTRR driver
isn't
>> >> the
>> >
>> >MTRR does not deserve to be sysdev. It is not essential for the
>> >system, it only makes it slow.
>> It's a CPU driver, cpufreq driver is the same.
>
>Well, it drives part of cpu. Fortunately that part of cpu is not
required
>for
>other drivers. cpufreq definitely should not be sysdev. If mtrr is not
>needed for drivers (I think it is not), it should not be a sysdev.
mtrr can not be a sysdev, but this is current cpufreq driver model. I
guess you need convince Dominik.

Thanks,
Shaohua

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262787AbTJYTxg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 15:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262788AbTJYTxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 15:53:36 -0400
Received: from fmr05.intel.com ([134.134.136.6]:19680 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S262787AbTJYTxe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 15:53:34 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: [PATCHSET] 0/3 A dynamic cpufreq governor
Date: Sat, 25 Oct 2003 12:53:30 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB6007796A@scsmsx403.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCHSET] 0/3 A dynamic cpufreq governor
Thread-Index: AcObMaTOHRrdB+XRROCZ7eRARGCE3A==
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: <linux-kernel@vger.kernel.org>, <cpufreq@www.linux.org.uk>,
       "Linus Torvalds" <torvalds@osdl.org>, <akpm@osdl.org>
Cc: "Pavel Machek" <pavel@ucw.cz>, "Dominik Brodowski" <linux@brodo.de>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
X-OriginalArrivalTime: 25 Oct 2003 19:53:30.0919 (UTC) FILETIME=[AA4A1370:01C39B31]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

This is the "new and improved" version of the patch  
that was sent out earlier this week. Thanks for all the 
feedback/suggestions.
(lkml subject line reference for previous thread -
"Dynamic cpufreq governor and updates to ACPI P-state driver")

The changes from the previous version:
1) dynamic cpufreq governor changes completely separated 
  from the updates to acpi P-state driver. These patches only 
  deal with dynamic cpufreq governor. Separate patch will be 
  sent out later to cover acpi updates.
2) New name for this cpufreq driver "cpufreq_ondemand"
  (Thanks to Pavel for the name)
3) Miscellaneous bugfixes and changes based on the review comments
4) And introduction of tuning knobs, where advanced user can tune
  the cpufreq_ondemand behaviour. 
  (Thanks to Dominik for helping me with this)
  Sampling_rate, down_threshold, up_threshold are currently exported.
  More advanced user who wants to change the algorithm itself, can 
  take the base infrastructure from this driver and come up with a 
  new/optimized frequency switching algorithm, as this driver is GPLed
:).

Patch contents (patches against 2.6.0-test8):
ondemand1.patch - 'unit' related bugfixes in drivers. 

ondemand2.patch - basic cpufreq_ondemand governor, with some changes 
since the last time.

ondemand3.patch - Adding sysfs interface for cpufreq_ondemand 
tunables and making sysfs access by cpufreq governors safe against 
removal of the underlying module (from Dominik). 


Thanks,
-Venkatesh


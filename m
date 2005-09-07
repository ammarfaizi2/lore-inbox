Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbVIGUK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbVIGUK0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 16:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbVIGUK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 16:10:26 -0400
Received: from fmr14.intel.com ([192.55.52.68]:3771 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751294AbVIGUKZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 16:10:25 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: battery status events (RE: Kernel 2.6.13 repeated ACPI events?)
Date: Wed, 7 Sep 2005 16:10:07 -0400
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B30048646E9@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: battery status events (RE: Kernel 2.6.13 repeated ACPI events?)
Thread-Index: AcWyHGFIAA7ZO+/ITQaBtO7Axf+85gByqPBw
From: "Brown, Len" <len.brown@intel.com>
To: "Jan De Luyck" <lkml@kcore.org>
Cc: <acpi-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
       "Lebedev, Vladimir P" <vladimir.p.lebedev@intel.com>,
       "Yu, Luming" <luming.yu@intel.com>
X-OriginalArrivalTime: 07 Sep 2005 20:10:13.0604 (UTC) FILETIME=[2812EA40:01C5B3E8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Jan De Luyck
>Sent: Monday, September 05, 2005 9:17 AM
>To: linux-kernel@vger.kernel.org
>Subject: Re: Kernel 2.6.13 repeated ACPI events?
>
>I'm seeing repeated ACPI events too, but of the battery kind:
>
>[Mon Sep  5 15:13:52 2005] received event "battery BAT2 
>00000080 00000001"
>[Mon Sep  5 15:13:52 2005] completed event "battery BAT2 
>00000080 00000001"
>[Mon Sep  5 15:14:53 2005] received event "battery BAT1 
>00000080 00000001"
>[Mon Sep  5 15:14:53 2005] completed event "battery BAT1 
>00000080 00000001"
>[Mon Sep  5 15:14:53 2005] received event "battery BAT2 
>00000080 00000001"
>[Mon Sep  5 15:14:53 2005] completed event "battery BAT2 
>00000080 00000001"
>[Mon Sep  5 15:15:55 2005] received event "battery BAT1 
>00000080 00000001"
>[Mon Sep  5 15:15:55 2005] completed event "battery BAT1 
>00000080 00000001"
>[Mon Sep  5 15:15:55 2005] received event "battery BAT2 
>00000080 00000001"
>[Mon Sep  5 15:15:55 2005] completed event "battery BAT2 
>00000080 00000001"
>
>going on forever and ever...
>
>Jan

The kernel doesn't created these messages -- presumably
they're from acpid or some other user-level daemon
that is monitoring /proc/acpi/event.  Unlikely that
logging these events is necessary...

Event 0x80 on the battery device is a "Battery Status Changed"
which you'd expect to see when plugging/charging/discharging
a battery.  How frequent they are depends on the rate,
the battery and the firmware that is talking to it.

Is there a GUI or something reading the battery status files?
Do these events stop when running in text mode?

Did this not happen on this box with earlier kernels?

Do the /proc/acpi/battery* files look sane --
is the status really changing?

thanks,
-Len

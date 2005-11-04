Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030596AbVKDEFO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030596AbVKDEFO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 23:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030597AbVKDEFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 23:05:14 -0500
Received: from fmr22.intel.com ([143.183.121.14]:41429 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1030596AbVKDEFM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 23:05:12 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: processor module locks up hyperthreading enabled machine
Date: Thu, 3 Nov 2005 20:05:08 -0800
Message-ID: <88056F38E9E48644A0F562A38C64FB6006380C8D@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: processor module locks up hyperthreading enabled machine
Thread-Index: AcXf48yPd5/h5R8qSFKjf6r8IOI/yQBEJGZw
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Reinhard Nissl" <rnissl@gmx.de>
Cc: <linux-kernel@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>
X-OriginalArrivalTime: 04 Nov 2005 04:05:09.0568 (UTC) FILETIME=[F289B400:01C5E0F4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: Reinhard Nissl [mailto:rnissl@gmx.de] 
>Sent: Wednesday, November 02, 2005 11:30 AM
>To: Pallipadi, Venkatesh
>Cc: linux-kernel@vger.kernel.org; Brown, Len
>Subject: Re: processor module locks up hyperthreading enabled machine
>
>Hi,
>
>Pallipadi, Venkatesh wrote:
>
>> Hmmmmm.... Please try the latest patch here
>> http://bugme.osdl.org/show_bug.cgi?id=5452
>
>Your patch fixed the freeze. Tested with kernel 2.6.14.
>
>I should have mentioned, that my system is equiped with a 
>Fujitsu-Siemens Mainboard D1562-A2, most recent BIOS V4.06 R1.09.
>
>I'll try to get this bug fixed in the BIOS, but chances are not that 
>good as the board is already "quite old".
>
>Would you please be so kind and drop a few lines about the 
>drawbacks of 
>this BIOS bug? What kind of functionality is lost by "ignoring" the 
>second CPU at this particular code section?
>

It will basically disable ACPI Processor Power Management features. 
P-state (speedstep or dynamic change of frequency to save power) and
C-states beyond C1 and T-states. 
>From dmesg, I know that on your system C2 and beyond is not supported.
T-states are kind of unimportantish. Only other difference will be
P-state. Not sure whether your processor supports speedstep and dynamic
change of cpufreq. If it doesn't, then you won't loose anything by this
workaround.

Thanks,
Venki

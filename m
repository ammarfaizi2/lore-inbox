Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263153AbTJVBmK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 21:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263295AbTJVBmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 21:42:10 -0400
Received: from fmr06.intel.com ([134.134.136.7]:12961 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S263153AbTJVBmH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 21:42:07 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [PATCHSET] 0/3 Dynamic cpufreq governor and updates to ACPI P-state driver
Date: Tue, 21 Oct 2003 18:42:03 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB60077929@scsmsx403.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCHSET] 0/3 Dynamic cpufreq governor and updates to ACPI P-state driver
Thread-Index: AcOXrTiWyr2S+aWBRwa9EOZ5/dlxSAAjpmrA
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
       <linux-kernel@vger.kernel.org>
Cc: <cpufreq@www.linux.org.uk>
X-OriginalArrivalTime: 22 Oct 2003 01:42:04.0000 (UTC) FILETIME=[B1CDFE00:01C3983D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Måns Rullgård
> 
> So, how does this work?  I'd like to be able to set minimum and
> maximum clock frequencies to allow, and CPU utilization thresholds at
> which to switch frequencies.  Is that possible, or is it work yet to
> be done?  Adjustable polling interval would also be nice.
> 

Yes. You can set the maximum and minimum allowed frequencies using 
the standard cpufreq interface. Something like:
echo 800000 >  /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq

However, other interfaces to tune this particular governor is not 
there yet. Other tunables that will be exported to user in future are 
Polling interval and CPU utilization thresholds.

> > The patches will work on all laptops with EST technology 
> > (Centrino) and also on any other system that supports low 
> > latency frequency change. 
> 
> Does Pentium 4 M work?

AFAIK, P4M does not support EST. You can double check with 
/proc/cpuinfo and look out for EST flag.


Thanks,
-Venkatesh

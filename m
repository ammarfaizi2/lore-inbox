Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752972AbWKQT6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752972AbWKQT6O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 14:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752942AbWKQT6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 14:58:13 -0500
Received: from mga01.intel.com ([192.55.52.88]:56153 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1752929AbWKQT6L convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 14:58:11 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,435,1157353200"; 
   d="scan'208"; a="147936947:sNHT19636568"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: cpufreq userspace governor does not reflect changes
Date: Fri, 17 Nov 2006 11:57:08 -0800
Message-ID: <EB12A50964762B4D8111D55B764A8454E763D2@scsmsx413.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: cpufreq userspace governor does not reflect changes
Thread-Index: AccKgWhNArWWSxXHQkC4K7MWqBKJqAAAPzuA
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Dhaval Giani" <dhaval.giani@gmail.com>
Cc: <davej@codemonkey.org.uk>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 17 Nov 2006 19:57:08.0776 (UTC) FILETIME=[9062AA80:01C70A82]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: Dhaval Giani [mailto:dhaval.giani@gmail.com] 
>Sent: Friday, November 17, 2006 11:48 AM
>To: Pallipadi, Venkatesh
>Cc: davej@codemonkey.org.uk; linux-kernel@vger.kernel.org
>Subject: Re: cpufreq userspace governor does not reflect changes
>
>Hey,
>
>On 11/18/06, Pallipadi, Venkatesh 
><venkatesh.pallipadi@intel.com> wrote:
>>
>> /sys/devices/....../cpuX/cpufreq/scaling_cur_freq
>> Gives you the information about last frequency that Linux 
>tried to set
>> on this CPU
>>
>> /sys/devices/....../cpuX/cpufreq/cpuinfo_cur_freq
>> (When supported) Gives you the information about actual 
>frequency that
>> the CPU is running at.
>>
>> Zero frequency value below is certainly a bug in the driver. 
>What is the
>> kernel you are using?
>
>Ooops! sorry missed that one. Its the 2.6.19-rc5-mm2. Its having the
>same .config which i posted on the bugzilla. Do you want the acpidump
>again?

Not really. There were couple of fixes that went in recently. I can send
pointers to those to you.

>
>> On the particular CPU you have here, all cores in a package 
>indeed share
>> the frequency. But, it does not really show up in 
>affected_cpus as OS is
>> not coordinating the shared-ness of P-state across cores. 
>That means, OS
>> programs each core individually based on CPU utilization and hardware
>> will pick the highest frequency among the two and run both 
>cores at that
>> frequency.
>>
>
>Hold on, so let me get it right. When i do an echo 1596000 >
>/sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed, the cpu cores
>will still be running at 1.86 Ghz since the other core is at that
>frequency? In this situation how do I then change the frequency?
>

Yes. You just have to change the frequency on both the cores.

-Venki

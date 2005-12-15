Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030265AbVLOBjX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030265AbVLOBjX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 20:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030279AbVLOBjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 20:39:23 -0500
Received: from fmr21.intel.com ([143.183.121.13]:42192 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1030265AbVLOBjW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 20:39:22 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [discuss] [PATCH] Export cpu topology for IA32 and x86_64 by sysfs
Date: Wed, 14 Dec 2005 17:39:14 -0800
Message-ID: <88056F38E9E48644A0F562A38C64FB6006A22399@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [discuss] [PATCH] Export cpu topology for IA32 and x86_64 by sysfs
Thread-Index: AcYAYaKj/4A5V9I9S8+/vQ3gKlyBAQAtarzA
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Andi Kleen" <ak@suse.de>, "Zhang, Yanmin" <yanmin.zhang@intel.com>
Cc: <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>,
       "Nathan Lynch" <ntl@pobox.com>
X-OriginalArrivalTime: 15 Dec 2005 01:39:15.0836 (UTC) FILETIME=[5BD7F3C0:01C60118]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: Andi Kleen [mailto:ak@suse.de] 
>Sent: Tuesday, December 13, 2005 7:51 PM
>To: Zhang, Yanmin
>Cc: linux-kernel@vger.kernel.org; discuss@x86-64.org; 
>Pallipadi, Venkatesh
>Subject: Re: [discuss] [PATCH] Export cpu topology for IA32 
>and x86_64 by sysfs
>
>On Wed, Dec 14, 2005 at 11:11:00AM +0800, Zhang, Yanmin wrote:
>> The patch exports the cpu topology info through sysfs on ia32/x86_64
>> machines. The info is similar to /proc/cpuinfo.
>> 
>> The exported items are:
>> 
>/sys/devices/system/cpu/cpuX/topology/physical_package_id(representing
>> the physical package id of  cpu X)
>> /sys/devices/system/cpu/cpuX/topology/core_id (representing 
>the cpu core
>> id  to cpu X)
>> /sys/devices/system/cpu/cpuX/topology/thread_siblings 
>(representing the
>> thread siblings to cpu X)
>> /sys/devices/system/cpu/cpuX/topology/core_siblings (represeting the
>> core siblings to cpu X)
>
>Hmm, I'm not sure it is that useful. Did someone decide to move
>all information from cpuinfo into sysfs? 
>

Not really. The current display in /proc/cpuinfo, though useful for
human reader,
is not very friendly to scripts. And if one wants to find out which
logical CPUs belong
to the same core, there will have to be some amount of code in userlevel
to parse
the /proc/cpuinfo and get this info. So, we thought that it may be
useful to 
export the masks to the user directly in a genric way. And, while doing
that
thinking was adding new fields in /sysfs rather than /proc/ was better.

Having said that, I feel Nathan's suggestion of doing it in more
architecturally-neutral way should be better than this. We will have a
relook at this one now.

And this needs some documentation changes as well.

Thanks for feedback.
Venki

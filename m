Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbWJTMZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbWJTMZH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 08:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbWJTMZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 08:25:06 -0400
Received: from mga03.intel.com ([143.182.124.21]:28430 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S964797AbWJTMZE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 08:25:04 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,333,1157353200"; 
   d="scan'208"; a="133668929:sNHT98152103"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: speedstep-centrino: ENODEV
Date: Fri, 20 Oct 2006 05:25:00 -0700
Message-ID: <EB12A50964762B4D8111D55B764A8454C1A976@scsmsx413.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: speedstep-centrino: ENODEV
Thread-Index: Acb0QJvPX5tK5650SrKvrJybl75C4QAAbgcw
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: =?iso-8859-1?Q?Sune_M=F8lgaard?= <sune@molgaard.org>
Cc: "Jiri Slaby" <jirislaby@gmail.com>,
       "Linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       <linux-acpi@vger.kernel.org>
X-OriginalArrivalTime: 20 Oct 2006 12:25:00.0801 (UTC) FILETIME=[C3492F10:01C6F442]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: Sune Mølgaard [mailto:sune@molgaard.org] 
>Sent: Friday, October 20, 2006 5:09 AM
>To: Pallipadi, Venkatesh
>Cc: Jiri Slaby; Linux kernel mailing list; linux-acpi@vger.kernel.org
>Subject: Re: speedstep-centrino: ENODEV
>
>Pallipadi, Venkatesh wrote:
>> 
>> Hmm... You must have CPU_FREQ_DENUG enabled in CONFIG 
>already. Can you pass cpufreq.debug=3 in boot option and send 
>me the output of dmesg after that.
>> 
>> Thanks,
>> Venki
>
>I am currently on 2.6.17.13 ubuntu version, that includes a lot of 
>2.6.18 code.
>
>It seems it tries to load acpi-cpufreq which complains about 
>cpu_online_map, bu I also tried explicitly to load speedstep-centrino, 
>which resulted in
>
>sune@tommelise:~$ sudo modprobe speedstep-centrino
>Password:
>FATAL: Error inserting speedstep_centrino 
>(/lib/modules/2.6.17.13-ubuntu1-pentium4m-1/kernel/arch/i386/ke
rnel/cpu/cpufreq/speedstep-centrino.ko): 
>No such device
>sune@tommelise:~$
>
>But nothing in dmesg, which is attached.
>

Puzzling.. 
Just to make sure, do you have CPU_FREQ_DEBUG enabled in your config and boot parameter? There are a bunch of dprintk debug messages in speedstep_centrino that should get printed in this case..
Do you have est flag displayed in your /proc/cpuinfo under flags?

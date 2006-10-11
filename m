Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161256AbWJKTAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161256AbWJKTAT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 15:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161261AbWJKTAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 15:00:19 -0400
Received: from mga03.intel.com ([143.182.124.21]:5558 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1161256AbWJKTAQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 15:00:16 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,295,1157353200"; 
   d="scan'208"; a="129748365:sNHT198815554"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-9"
Content-Transfer-Encoding: 8BIT
Subject: RE: Ondemand/Conservative not working with 2.6.18
Date: Wed, 11 Oct 2006 12:00:03 -0700
Message-ID: <EB12A50964762B4D8111D55B764A8454B6C08C@scsmsx413.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Ondemand/Conservative not working with 2.6.18
Thread-Index: Acbsrlv0L+uXU6G6QaaQJUFxqGKG7AAuEwIQ
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: <caglar@pardus.org.tr>
Cc: "Dave Jones" <davej@redhat.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 11 Oct 2006 19:00:09.0274 (UTC) FILETIME=[78EB51A0:01C6ED67]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: S.Çaglar Onur [mailto:caglar@pardus.org.tr] 
>Sent: Tuesday, October 10, 2006 1:55 PM
>To: Pallipadi, Venkatesh
>Cc: Dave Jones; linux-kernel@vger.kernel.org
>Subject: Re: Ondemand/Conservative not working with 2.6.18
>
>10 Eki 2006 Sal 02:35 tarihinde, Pallipadi, Venkatesh þunlarý 
>yazmýþtý: 
>> What CPU is this? Pentium M?
>
>Yes it is.
>
>
>zangetsu cpu0 # cd cpufreq/
>zangetsu cpufreq # echo "ondemand" > scaling_governor
>zangetsu cpufreq # cat scaling_governor
>ondemand
>zangetsu cpufreq # cat scaling_available_frequencies
>1733000 1333000 1067000 800000
>zangetsu cpufreq # cat scaling_cur_freq
>1733000
>
>But frequency never changes and stays at 1.73ghz
>
>zangetsu cpufreq # echo "powersave" > scaling_governor
>zangetsu cpufreq # cat scaling_cur_freq
>800000
>zangetsu cpufreq # echo "performance" > scaling_governor
>zangetsu cpufreq # cat scaling_cur_freq
>1733000
>

I guess I misunderstood the original issue. You have available_frequencies showing all the values and after you load ondemand, frequency remains at the highest, even though CPUs are idle. Is this correct?

And everything above used to work fine with 2.6.16?

Can you configure with CPU_FREQ_DEBUG and do "echo 5 > /sys/module/cpufreq/parameter/debug" before switching the governor to ondemand and see whether you see any messages in dmesg?

Thanks,
Venki

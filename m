Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262439AbVAUSEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbVAUSEf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 13:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262445AbVAUSB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 13:01:27 -0500
Received: from fmr13.intel.com ([192.55.52.67]:53133 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S262442AbVAUR7r convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 12:59:47 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [BUG?]: cpufreqency scaling - wrong frequency detected
Date: Fri, 21 Jan 2005 09:58:33 -0800
Message-ID: <88056F38E9E48644A0F562A38C64FB6003D1BB0C@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BUG?]: cpufreqency scaling - wrong frequency detected
Thread-Index: AcT/31oq9pFovPNkTEeQuUvL5JBrMwAAzumA
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Matthias-Christian Ott" <matthias.christian@tiscali.de>
Cc: <linux-kernel@vger.kernel.org>, <linux@brodo.de>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Zou, Nanhai" <nanhai.zou@intel.com>
X-OriginalArrivalTime: 21 Jan 2005 17:58:34.0929 (UTC) FILETIME=[D3800210:01C4FFE2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: Matthias-Christian Ott [mailto:matthias.christian@tiscali.de] 
>Sent: Friday, January 21, 2005 9:34 AM
>To: Matthias-Christian Ott
>Cc: Pallipadi, Venkatesh; linux-kernel@vger.kernel.org; 
>linux@brodo.de; Nakajima, Jun; Zou, Nanhai
>Subject: Re: [BUG?]: cpufreqency scaling - wrong frequency detected
>
>Matthias-Christian Ott wrote:
>
>>>  
>>>
>> Hi!
>> Cpufreq (with enabled debugging (not CONFIG_DEBUG_KERNEL)) doesn't 
>> display any additional messages. I'll compile it with 
>> CONFIG_DEBUG_KERNEL.
>>
>> Matthias-Christian Ott
>> -
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>Hi!
>CONFIG_DEBUG_KERNEL doesn't display any additional messages. What do I 
>have activate to get such debugging messages:
>dprintk("P4 - MSR_EBC_FREQUENCY_ID: 0x%x 0x%x\n", msr_lo, msr_hi);
>
>Matthias-Christian Ott
>

Enable CPU_FREQ_DEBUG and activate it.
Thanks,
Venki

config CPU_FREQ_DEBUG
        bool "Enable CPUfreq debugging"
        depends on CPU_FREQ
        help
          Say Y here to enable CPUfreq subsystem (including drivers)
          debugging. You will need to activate it via the kernel
          command line by passing
             cpufreq.debug=<value>

          To get <value>, add
               1 to activate CPUfreq core debugging,
               2 to activate CPUfreq drivers debugging, and
               4 to activate CPUfreq governor debugging



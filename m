Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265878AbUA1Wil (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 17:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266176AbUA1Wil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 17:38:41 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:48351 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S265878AbUA1Wif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 17:38:35 -0500
Message-ID: <40183860.7040503@oracle.com>
Date: Wed, 28 Jan 2004 23:32:00 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20040107
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Domsch <Matt_Domsch@dell.com>
CC: Dmitry Torokhov <dtor_core@ameritech.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-acpi@intel.com
Subject: Re: 2.6.2-rc2-bk1 oopses on boot (ACPI patch)
References: <40171B5B.4020601@oracle.com> <20040127184228.3a0b8a86.akpm@osdl.org> <200401272337.55676.dtor_core@ameritech.net> <20040128073737.A29748@lists.us.dell.com>
In-Reply-To: <20040128073737.A29748@lists.us.dell.com>
Content-Type: multipart/mixed;
 boundary="------------050406040909040709070806"
X-Brightmail-Tracker: AAAAAQAAAAI=
X-White-List-Member: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050406040909040709070806
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Matt Domsch wrote:
> On Tue, Jan 27, 2004 at 11:37:55PM -0500, Dmitry Torokhov wrote:
> 
>>>Divide by zero.  Looks like ACPI is now passing bad values into the
>>>frequency change notifier.
>>
>>It is a common problem with Dell's DSDT implementation which does not
>>follow ACPI spec and it's been going on for ages. From the original
>>report:
>>
>>cpufreq: CPU0 - ACPI performance management activated
>> cpufreq: *P0: 1Mhz, 0 mW, 0 uS
>> cpufreq: P1: 0Mhz, 0 mW, 0 uS
>> divide error: 0000 [#1]
>>
>>As you can see all data is bogus... Patching DSDT cures it for sure,
>>sometimes CONFIG_ACPI_RELAXED_AML helps as well.
> 
> 
> Please send me your DSDT and output of dmidecode, and ideally what a
> proper DSDT should show in this case (I'm not familiar enough with
> what all the various ACPI tables should contain), and I'll take it up
> with the BIOS programmers for that platform.

While appreciating your offer, I'd like to remind that this works
  perfectly prior to the 20031203 ACPI patch. Indeed, this is what
  2.6.1 vanilla says in that area:

cpufreq: CPU0 - ACPI performance management activated.
cpufreq: *P0: 1800 MHz, 0 mW, 250 uS
cpufreq:  P1: 1200 MHz, 0 mW, 250 uS

Attaching the gzipped dmesg for my 2.6.1 boot - let me know if
  you want anyway dmidecode output and DSDT; for this latter I'll
  have to ask for instructions (or is the output of a simple
  'cat /proc/acpi/dsdt' enough ?).

--alessandro

  "Two rivers run too deep
   The seasons change and so do I"
       (U2, "Indian Summer Sky")

--------------050406040909040709070806
Content-Type: application/x-gzip;
 name="dmesg.out.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="dmesg.out.gz"

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
od6+RCoAAA==
--------------050406040909040709070806--


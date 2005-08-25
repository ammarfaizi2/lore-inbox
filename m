Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbVHYRGL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbVHYRGL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 13:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbVHYRGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 13:06:11 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:26631 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1750832AbVHYRGK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 13:06:10 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <BAY14-F20DDBBC08EC1461957F455BAAB0@phx.gbl>
References: <BAY14-F20DDBBC08EC1461957F455BAAB0@phx.gbl>
X-OriginalArrivalTime: 25 Aug 2005 17:06:02.0562 (UTC) FILETIME=[45C4FA20:01C5A997]
Content-class: urn:content-classes:message
Subject: Re: Building the kernel with Cygwin
Date: Thu, 25 Aug 2005 13:05:24 -0400
Message-ID: <Pine.LNX.4.61.0508251258330.4160@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Building the kernel with Cygwin
Thread-Index: AcWpl0XOMLChMEDVSvmX27b64o5wxA==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Chris du Quesnay" <duquesnay@hotmail.com>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 25 Aug 2005, Chris du Quesnay wrote:

> Hi Dick.  Thanks for your suggestion.
>
> I tried it, however, and attempted the make again, and got the same error.
>
> The scripts/basic directory contains a fixdep.exe after the make is run.
> There is
> no fixdep file.  I tried renaming the fixdep.exe to fixdep, but that also
> resulted in
> the same make error.
>
> Any further suggestions?
> Thx,
> Chris.
>

Ah yes! The Makefile will not execute 'fixdep.exe` it executes
'fixdep' --hard coded. I don't know how well cygwin emulates
a Unix environment, but maybe you can use an alias???
.. Like...
alias fixdep='fixdep.exe'

If that doesn't work, you will probably find other problems
also, like the "*.o" files become "*.obj", etc. It might be
a lost cause. If it was my system, I'd get another hard-disk,
have a "regular" distribution install Linux on it, and set up
to dual-boot.

>
>> From: "linux-os (Dick Johnson)" <linux-os@analogic.com>
>> Reply-To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
>> To: "Chris du Quesnay" <duquesnay@hotmail.com>
>> CC: <linux-kernel@vger.kernel.org>
>> Subject: Re: Building the kernel with Cygwin
>> Date: Thu, 25 Aug 2005 11:42:46 -0400
>>
>>
>> On Thu, 25 Aug 2005, Chris du Quesnay wrote:
>>
>>> Hi.  I am newbie at GNU/linux.
>>>
>>> I am trying to build a kernel (2.6.12)  for a powerpc target using
>> cygwin on
>>> my i686 machine.  I have
>>> Windows 2000 as my operating system.
>>>
>>> I have recent versions of cygwin (with GNU make 3.80), binutils for the
>>> powerpc (gcc v 3.3.1, ld v 2.14)
>>>
>>> I set
>>> ARCH=ppc
>>> CROSS_COMPILE= powerpc-ibm-eabi-
>>>
>>> and I add the cross compiler/build directory to my path.
>>>
>>> After untaring the kernel, I issue the
>>> make mrproper, which appears to work.
>>>
>>> Then I issue
>>> make menuconfig
>>>
>>> and I get the following error, which I can't seem to get around:
>>>
>>> HOSTCC   scripts/basic/fixdep
>>> fixdep: no such file or directory
>>> make[1]:*** [scripts/basic/fixdep] Error 2
>>> make[1] Leaving directory /cygdrive/c/Linux_amcc/linux-2.6.12
>>>
>>>
>>> Can you suggest what the problem might be?  Should I be able to build
>> the
>>> kernel
>>> with cygwin?
>>>
>>
>> Try this temporary work-around:
>>
>> cd /cygdrive/c/Linux_amcc/linux-2.6.12/scripts/basic
>> gcc -O2 -o fixdep fixdep.c
>>
>> You may also have to do the same thing for docproc, i.e.,
>> gcc -O2 -o docproc docproc.c
>>
>> Others may tell you what's wrong, but at least this should get
>> you started.
>>
>>
>> Cheers,
>> Dick Johnson
>> Penguin : Linux version 2.6.12.5 on an i686 machine (5537.79 BogoMips).
>> Warning : 98.36% of all statistics are fiction.
>> .
>> I apologize for the following. I tried to kill it with the above dot :
>>
>> ****************************************************************
>> The information transmitted in this message is confidential and may be
>> privileged.  Any review, retransmission, dissemination, or other use of
>> this information by persons or entities other than the intended recipient
>> is prohibited.  If you are not the intended recipient, please notify
>> Analogic Corporation immediately - by replying to this message or by
>> sending an email to DeliveryErrors@analogic.com - and destroy all copies of
>> this information, including any attachments, without reading or disclosing
>> them.
>>
>> Thank you.
>
> _________________________________________________________________
> Take advantage of powerful junk e-mail filters built on patented Microsoft®
> SmartScreen Technology.
> http://join.msn.com/?pgmarket=en-ca&page=byoa/prem&xAPID=1994&DI=1034&SU=http://hotmail.com/enca&HL=Market_MSNIS_Taglines
>  Start enjoying all the benefits of MSN® Premium right now and get the
> first two months FREE*.
>
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12.5 on an i686 machine (5537.79 BogoMips).
Warning : 98.36% of all statistics are fiction.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.

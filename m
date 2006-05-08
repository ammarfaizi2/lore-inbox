Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbWEHPoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbWEHPoI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 11:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbWEHPoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 11:44:08 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:33540 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932116AbWEHPoH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 11:44:07 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <6bffcb0e0605080815t483955b3yf357175abb9a1a46@mail.gmail.com>
X-OriginalArrivalTime: 08 May 2006 15:44:06.0426 (UTC) FILETIME=[3D4627A0:01C672B6]
Content-class: urn:content-classes:message
Subject: Re: How to read BIOS information
Date: Mon, 8 May 2006 11:43:56 -0400
Message-ID: <Pine.LNX.4.61.0605081131100.22905@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: How to read BIOS information
Thread-Index: AcZytj1NKCdP7oX2RIa057yYmo1y4A==
References: <445F5228.7060006@wipro.com> <1147099994.2888.32.camel@laptopd505.fenrus.org> <445F5DF1.3020606@wipro.com> <6bffcb0e0605080815t483955b3yf357175abb9a1a46@mail.gmail.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Cc: "Madhukar Mythri" <madhukar.mythri@wipro.com>,
       "Arjan van de Ven" <arjan@infradead.org>,
       <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 8 May 2006, Michal Piotrowski wrote:

> Hi,
>
> On 08/05/06, Madhukar Mythri <madhukar.mythri@wipro.com> wrote:
> [snip]
>> "proc/cpuinfo" says only HT support is their or not but, it will not say
>> whether HT is Enalbled/Disabled..
>> How to read ACPI tables ? Can  you give little info on this...
>> even from Driver program, if its possible please tell me...
>>
>
> How about  comparing /sys/devices/system/cpu/cpu0/topology/core_id and
> /sys/devices/system/cpu/cpu1/topology/core_id values?
>
> On my northwood ht (single core) cpu0/topology/core_id and
> cpu1/topology/core_id contain "0". For dual core system should be
> something like
>
> cpu0/topology/core_id = 0
> cpu1/topology/core_id = 0
> cpu2/topology/core_id = 1
> cpu3/topology/core_id = 1
>
> Regards,
> Michal
>

The problem is that if the BIOS didn't turn them on, there might
be only /proc/sys/devices/system/cpu/cpu0, nothing else... and
you get bad information as well. This machine has a dual-core
CPU that *was* a hyper-threaded, two core device until I
changed the motherboard. Now it's just a single core, non
HT device even though the HT flag is set. There isn't any
way to turn it ON and the motherboard vendor, CompUSA, claims
that there is "no such thing" as HT. FYI, the board was made
by Intel and I think they invented HT. Nevertheless, the
consumer ends up with the crap that the vendors supply and
that's that! My only recourse was to just return the board
and get my money back. I needed the board because the previous
one from Tyan didn't work at all!

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) Pentium(R) 4 CPU 2.80GHz
stepping	: 7
cpu MHz		: 2793.171
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
  cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
                                                       ^__ HT ready
bogomips	: 5592.89


Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.89 BogoMips).
New book: http://www.lymanschool.com
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.

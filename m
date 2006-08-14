Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbWHNOvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbWHNOvw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 10:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbWHNOvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 10:51:52 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:27657 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S932311AbWHNOvv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 10:51:51 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 14 Aug 2006 14:51:47.0958 (UTC) FILETIME=[2B157160:01C6BFB1]
Content-class: urn:content-classes:message
Subject: Re: HT not active
Date: Mon, 14 Aug 2006 10:51:47 -0400
Message-ID: <Pine.LNX.4.61.0608141035240.21276@chaos.analogic.com>
In-Reply-To: <44E08769.7010000@shaw.ca>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: HT not active
thread-index: Aca/sSsclH03PokxTOi+OQ1/BsRiHg==
References: <fa.YLv8m2Uw0It/GRKxQHnEfBS+Dao@ifi.uio.no> <44E08769.7010000@shaw.ca>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Robert Hancock" <hancockr@shaw.ca>
Cc: "Jan Engelhardt" <jengelh@linux01.gwdg.de>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 14 Aug 2006, Robert Hancock wrote:

> Jan Engelhardt wrote:
>> I cannot get HT to be used on some machine:
>>
>> w04a# cat /proc/cpuinfo
>> processor       : 0
>> vendor_id       : GenuineIntel
>> cpu family      : 15
>> model           : 0
>> model name      : Intel(R) Pentium(R) 4 CPU 1700MHz
>> stepping        : 10
>> cpu MHz         : 1694.890
>> cache size      : 256 KB
>> fdiv_bug        : no
>> hlt_bug         : no
>> f00f_bug        : no
>> coma_bug        : no
>> fpu             : yes
>> fpu_exception   : yes
>> cpuid level     : 2
>> wp              : yes
>> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
>> cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm up
>> bogomips        : 3393.46
>>
>> 'ht' indicates:
>> #define X86_FEATURE_HT          (0*32+28) /* Hyper-Threading */
>
> Most P4s that I have seen have the HT flag but only some of them
> actually support it (and have it enabled in the BIOS). I don't think any
> 1.7GHz models did.
>
> --
> Robert Hancock      Saskatoon, SK, Canada
> To email, remove "nospam" from hancockr@nospamshaw.ca
> Home Page: http://www.roberthancock.com/

It's mostly a motherboard issue. This board is an Intel motherboard.
However, Intel decided to not allow HT (strange). I tried to
bring the MB back to CompUSA, but they declared; "The board is
not defective. Windows doesn't use hyper threading, and this is
a windows-only board...." They claim no board is compatible with
Linux. They were perfectly willing to give me back my money, but
they would not guarantee that any of their motherboards were
"compatible" with Linux. With an attitude like that, one can
quickly learn where not to buy motherboards.

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) Pentium(R) 4 CPU 2.80GHz
stepping	: 7
cpu MHz		: 2794.381
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
bogomips	: 5592.62

The solution may be, in the future, to bring a bootable CR/ROM with you
when buying motherboards or CPUs.... and get stuff off the net that's
guaranteed to do what you want. This exact same software, exact same
configuration ".config" file, produces this on another machine:

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) Xeon(TM) CPU 2.40GHz
stepping	: 9
cpu MHz		: 2399.779
cache size	: 512 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 1
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
bogomips	: 4804.62

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) Xeon(TM) CPU 2.40GHz
stepping	: 9
cpu MHz		: 2399.779
cache size	: 512 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 1
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
bogomips	: 4798.06

processor	: 2
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) Xeon(TM) CPU 2.40GHz
stepping	: 9
cpu MHz		: 2399.779
cache size	: 512 KB
physical id	: 3
siblings	: 2
core id		: 0
cpu cores	: 1
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
bogomips	: 4798.06

processor	: 3
vendor_id	: GenuineIntel
cpu family	: 15
model		: 2
model name	: Intel(R) Xeon(TM) CPU 2.40GHz
stepping	: 9
cpu MHz		: 2399.779
cache size	: 512 KB
physical id	: 3
siblings	: 2
core id		: 0
cpu cores	: 1
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid xtpr
bogomips	: 4798.09

... so you can see that SMP and hyper-threading are enabled.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.62 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.

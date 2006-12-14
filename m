Return-Path: <linux-kernel-owner+w=401wt.eu-S932676AbWLNMHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932676AbWLNMHR (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 07:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932683AbWLNMHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 07:07:16 -0500
Received: from ultra1.univ-paris12.fr ([193.51.100.100]:38230 "EHLO
	ultra1.univ-paris12.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932676AbWLNMHP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 07:07:15 -0500
Message-ID: <45813E67.80709@univ-paris12.fr>
Date: Thu, 14 Dec 2006 13:07:03 +0100
From: Franck Pommereau <pommereau@univ-paris12.fr>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Executability of the stack
References: <458118BB.5050308@univ-paris12.fr> <1166090244.27217.978.camel@laptopd505.fenrus.org>
In-Reply-To: <1166090244.27217.978.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> # grep maps /proc/self/maps
>> bfce8000-bfcfe000 rw-p bfce8000 00:00 0          [stack]
> 
> this shows that the *intent* is to have it non-executable. 
> Not all x86 processors can enforce this. All modern ones do.

Mine is quite recent:

# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 15
model name      : Intel(R) Core(TM)2 CPU         T7200  @ 2.00GHz
stepping        : 6
cpu MHz         : 1000.000
cache size      : 4096 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 10
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm
constant_tsc up pni monitor ds_cpl vmx est tm2 cx16 xtpr lahf_lm
bogomips        : 3996.23

> the alternative (showing effective permission) is equally confusing;
> apps would see permissions they didn't set...

Indeed, both are confusing (the other way is having permission that you
do not see). But which one is the most dangerous from a security point
of view? For me it is believing that you're protected while you're not.

>> Maybe it comes from sharing source code for 64 bits and 32 bits
>> architectures but if so, it should be possible (and highly desirable) to
>> treat 32 bits differently.
> 
> it's not a "32 bit" thing, it's an "older processors don't, newer ones
> do" thing.

I've read that 64 bit processors have an execute bit at the page level
while 32 bit ones do not (only at the segment level). I didn't know that
newer 31 bit CPUs did have this bit.

> Can you paste your /proc/cpuinfo file here ? Maybe you have a processor
> with the capability but just haven't enabled it (either in the bios or
> in the kernel config)

I'd be happy to know how to enable it.

Thanks for your help.
Franck

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261600AbVDEIFM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbVDEIFM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 04:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbVDEIB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 04:01:27 -0400
Received: from bernache.ens-lyon.fr ([140.77.167.10]:57826 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261626AbVDEH76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 03:59:58 -0400
Message-ID: <42524576.8040007@ens-lyon.org>
Date: Tue, 05 Apr 2005 09:59:50 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050116)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm1
References: <20050405000524.592fc125.akpm@osdl.org>	<425240C5.1050706@ens-lyon.org> <20050405004519.4be75785.akpm@osdl.org>
In-Reply-To: <20050405004519.4be75785.akpm@osdl.org>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Report: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton a écrit :
> Brice Goglin <Brice.Goglin@ens-lyon.org> wrote:
> 
>>Andrew Morton a écrit :
>> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc2/2.6.12-rc2-mm1/
>>
>> Hi Andrew,
>>
>> printk timing seems broken.
>> It always shows [ 0.000000] on my Compaq Evo N600c.
> 
> 
> What sort of CPU does that thing have?  Please share the /proc/cpuinfo
> output.

It's a Mobile Pentium 3:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 11
model name      : Intel(R) Pentium(R) III Mobile CPU      1000MHz
stepping        : 1
cpu MHz         : 996.763
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca 
cmov pat pse36 mmx fxsr sse
bogomips        : 1977.25

> Does reverting
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc2/2.6.12-rc2-mm1/broken-out/sched-x86-sched_clock-to-use-tsc-on-config_hpet-or-config_numa-systems.patch
> fix it?

Yes!

Brice

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261490AbSJPXQU>; Wed, 16 Oct 2002 19:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261491AbSJPXQU>; Wed, 16 Oct 2002 19:16:20 -0400
Received: from s383.jpl.nasa.gov ([137.78.170.215]:29664 "EHLO
	s383.jpl.nasa.gov") by vger.kernel.org with ESMTP
	id <S261490AbSJPXQR>; Wed, 16 Oct 2002 19:16:17 -0400
Message-ID: <3DADF488.1080204@jpl.nasa.gov>
Date: Wed, 16 Oct 2002 16:21:44 -0700
From: Bryan Whitehead <driver@jpl.nasa.gov>
Organization: Jet Propulsion Laboratory
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en, zh, zh-cn, zh-hk, zh
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Mark Cuss <mcuss@cdlsystems.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel reports 4 CPUS instead of 2...
References: <Pine.LNX.3.95.1021016133227.139A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My /proc/cpuinfo says I have ht CPU's... but i only see 2 CPU's... (Yet 
I have 2 1.7Ghz XEONs in the box so shouldn't I see 4?)

It's a Dell Precisions 530 workstation.

Does intel have ht CPU's that are messed up? and I'm one of the "lucky 
ones". ?

Building a kernel myself did not help... Any idea's?

[driver@mulan ~]$ cat /proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 1
model name	: Intel(R) Xeon(TM) CPU 1.70GHz
stepping	: 2
cpu MHz		: 1694.863
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips	: 3381.65

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 15
model		: 1
model name	: Intel(R) Xeon(TM) CPU 1.70GHz
stepping	: 2
cpu MHz		: 1694.863
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips	: 3381.65


Richard B. Johnson wrote:
> On Wed, 16 Oct 2002, Mark Cuss wrote:
> 
> 
>>Hello all
>>
>>I'm working with a new Dell Poweredge 4600 Server with Dual CPUs.  However,
>>Linux reports that it sees 4 CPUs...  I have opened the thing to see if Dell
>>gave me 2 extras for free, but no luck:  Attached is /proc/cpuinfo.
>>
>>I've tried the RedHat 8.0 stock kernel, as well as a freshly compiled 2.4.19
>>but both exhibit the same behavior.
>>
>>The specifics on the machine:
>>
>>Dual Xeon 2.2 GHz CPUs (512 k L2 cache)
>>2 Gigs DDR RAM
>>The chipset is a ServerWorks CMIC-HE (see attached lspci for complete
>>listing).
>>
>>Has anyone else seen this behavior?  The only other SMP machine I have is an
>>older Dell server with Dual 1 GHz coppermines, and it reports 2 CPUs...
>>
>>Any information or advice is greatly appreciated...
>>
>>Thanks in Advance,
>>
>>Mark
>>
> 
> 
> This has become a FAQ. The processors are capable of so-called
> "hyperthreading". They have two execution units, therefore seem
> like two CPUs.
> 
> This is the correct behavior. If you don't like this, you can
> swap motherboards with me ;) Otherwise, grin and bear it!
> 
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
> The US military has given us many words, FUBAR, SNAFU, now ENRON.
> Yes, top management were graduates of West Point and Annapolis.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
Bryan Whitehead
SysAdmin - JPL - Interferometry Systems and Technology
Phone: 818 354 2903
driver@jpl.nasa.gov


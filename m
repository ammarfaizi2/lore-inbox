Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268117AbUJHISf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268117AbUJHISf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 04:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268155AbUJHISf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 04:18:35 -0400
Received: from sicdec1.epfl.ch ([128.178.50.33]:12486 "EHLO sicdec1.epfl.ch")
	by vger.kernel.org with ESMTP id S268117AbUJHIRu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 04:17:50 -0400
Message-ID: <1097223461.41664d258d907@imapwww.epfl.ch>
X-Imap-User: michel.mengis@epfl.ch
Date: Fri,  8 Oct 2004 10:17:41 +0200
From: michel.mengis@epfl.ch
To: linux-kernel@vger.kernel.org
Cc: Dominik Brodowski <linux@dominikbrodowski.de>
Subject: Re: Kernel 2.6.8 and DELL's DOTHAN Processor B0
References: <20041008073837.GA7413@dominikbrodowski.de>
In-Reply-To: <20041008073837.GA7413@dominikbrodowski.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.6
X-Originating-IP: 128.178.9.34
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dominik,

here the outputs:
::::::::::::::
/proc/acpi/processor/CPU0/info
::::::::::::::
processor id:            0
acpi id:                 0
bus mastering control:   yes
power management:        yes
throttling control:      yes
limit interface:         yes
::::::::::::::
/proc/acpi/processor/CPU0/limit
::::::::::::::
active limit:            P0:T0
user limit:              P0:T0
thermal limit:           P0:T0
::::::::::::::
/proc/acpi/processor/CPU0/power
::::::::::::::
active state:            C2
default state:           C1
bus master activity:     ffffffff
states:
    C1:                  promotion[C2] demotion[--] latency[000] usage[00011180]
   *C2:                  promotion[C3] demotion[C1] latency[050] usage[00390021]
    C3:                  promotion[--] demotion[C2] latency[050] usage[00004735]
::::::::::::::
/proc/acpi/processor/CPU0/throttling
::::::::::::::
state count:             8
active state:            T0
states:
   *T0:                  00%
    T1:                  12%
    T2:                  25%
    T3:                  37%
    T4:                  50%
    T5:                  62%
    T6:                  75%
    T7:                  87%::::::::::::::
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq
::::::::::::::
600000
::::::::::::::
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq
::::::::::::::
1700000
::::::::::::::
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq
::::::::::::::
600000
::::::::::::::
/sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies
::::::::::::::
1700000 1700000 1700000 1400000 1200000 1000000 800000 600000
::::::::::::::
/sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors
::::::::::::::
userspace
::::::::::::::
/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq
::::::::::::::
600000
::::::::::::::
/sys/devices/system/cpu/cpu0/cpufreq/scaling_driver
::::::::::::::
centrino
::::::::::::::
/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
::::::::::::::
userspace
::::::::::::::
/sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
::::::::::::::
600000
::::::::::::::
/sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
::::::::::::::
600000
::::::::::::::
/sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
::::::::::::::
600000


scaling_min_freq, scaling_max_freq, scaling_governor and scaling_setseed are rw.
but I can write what I want in these files, nothing change.

michel.


and,




Quoting Dominik Brodowski <linux@dominikbrodowski.de>:

> Hi,
>
> Can you send me the output of
>
> cat /acpi/processor/*/performance
>
> and
>
> cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
> cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq
>
>
> Also, is this happening while on AC power or while on battery?
>
>
> Thirdly, can you disassemble the DSDT and, if it exists, the SSDT, and check
> for the _PPC method? How to disassemble the DSDT is noted at
> http://acpi.sourceforge.net , for the SSDT check gspr's post on Sep. 20th,
> 12:53 at
> http://forums.gentoo.org/viewtopic.php?t=223411&highlight=ssdt+acpidmp
>
> 	Dominik
>



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130220AbRBZOeS>; Mon, 26 Feb 2001 09:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130277AbRBZOco>; Mon, 26 Feb 2001 09:32:44 -0500
Received: from zeus.kernel.org ([209.10.41.242]:53191 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130265AbRBZO3q>;
	Mon, 26 Feb 2001 09:29:46 -0500
Content-Type: text/plain; charset=US-ASCII
From: Dennis Noordsij <dennis.noordsij@wiral.com>
To: linux-kernel@vger.kernel.org
Subject: Dell Inspiron 5000e Speedstep Oops 
Date: Mon, 26 Feb 2001 12:58:42 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01022612584200.00452@dennis>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear list,

I have a problem with an otherwise wonderful Dell 5000e Inspiron laptop, 
which didn't exist prior to kernel 2.4.0 (I used 2.4.0-pre10 for a long time, 
no problems).

The CPU is a Coppermine P3 with speedstep, switching to 550MHz when running 
on battery only, and 700MHz when connected to mains.

When I initially got this laptop I read some older posts on this list saying 
that the speedstep thing is not a problem (anymore). However, lately, when 
either pulling out the power (for example when I am packing up, the system is 
running shutdown scripts, I pull out the mouse, network, and then power) the 
system suddenly starts oopsing, scrolling them across the screen as fast as 
it can. It also happens when I am for example running on battery and the Dell 
beeps to indicate low battery power and I plug in the power.

The symptoms are Oopses scrolling across the screen, no way to stop, freeze, 
SysRq, copy or log them, apart from probably a serial console.

I would love to ksymoops the output for everyone, but perhaps it is a known 
issue and it is not necessary. If this is really not supposed to happen, I 
can try the setup with a serial console and log the Oopses. (just a bit of 
hassle because I am at work :-) 

Btw, the originally installed W2K not only detects the speed change, but also 
allows you to override the thing and run 700MHz on battery, or 550MHz on 
mains. I seem to remember from the older posts on this list though that it is 
difficult to detect this change (would require an ineffecient polling 
behaviour). Is this possible under Linux?

Below is some system information,
Thanks for any help,
Dennis Noordsij

PS - Occasionally (I think when using the network, Tulip Cardbus using kernel 
drivers) I get a hard freeze, screen freezes, mouse freezes, SysRq doesn't 
work, only way out is to pull out the power and battery. Nothing in the logs 
afterwards. What can cause that? I would love to help out and debug Oopses 
and whatnot, but how do you debug something like that?


/proc/version:
 
Linux version 2.4.2 (root@dennis) (gcc version 2.95.2 20000220 (Debian 
GNU/Linux)) #2 Mon Feb 26 16:35:35 EET 2001


/proc/cpuinfo: 

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 696.977
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov 
pat pse36 mmx fxsr sse
bogomips        : 1389.36

NOTE: When the system is booted while running on battery only, the speed is 
reported as something like 549.xxxxx MHz, with about 1000 bogomips.



/proc/meminfo:

        total:    used:    free:  shared: buffers:  cached:
Mem:  129736704 94064640 35672064        0  4128768 43266048
Swap: 255459328        0 255459328
MemTotal:       126696 kB
MemFree:         34836 kB
MemShared:           0 kB
Buffers:          4032 kB
Cached:          42252 kB
Active:          18080 kB
Inact_dirty:     28204 kB
Inact_clean:         0 kB
Inact_target:       44 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       126696 kB
LowFree:         34836 kB
SwapTotal:      249472 kB
SwapFree:       249472 kB


CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
CONFIG_APM_CPU_IDLE=y
# CONFIG_APM_DISPLAY_BLANK is not set
CONFIG_APM_RTC_IS_GMT=y
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set


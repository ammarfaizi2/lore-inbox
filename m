Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbUCKJPn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 04:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262915AbUCKJPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 04:15:43 -0500
Received: from ns.schottelius.org ([213.146.113.242]:47523 "HELO
	ns.schottelius.org") by vger.kernel.org with SMTP id S261619AbUCKJPV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 04:15:21 -0500
Date: Thu, 11 Mar 2004 10:15:25 +0100
From: Nico Schottelius <nico-kernel@schottelius.org>
To: linux-kernel@vger.kernel.org
Cc: clemej@alum.rpi.edu
Subject: 2.6.3 / cpufreq governor problems
Message-ID: <20040311091525.GB7788@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux bruehe 2.6.3
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

Looks like the user space cpufreq does not get registered:

scice# modprobe cpufreq_userspace                                      
scice# lsmod                                                           
Module                  Size  Used by
cpufreq_powersave        352  0 
cpufreq_userspace       1924  0 
md5                     2688  1 
ipv6                  198208  21 
snd_ali5451            14532  0 
snd_ac97_codec         48388  1 snd_ali5451
snd_pcm                64228  1 snd_ali5451
snd_page_alloc          5412  1 snd_pcm
snd_timer              15428  1 snd_pcm
snd                    32228  4
snd_ali5451,snd_ac97_codec,snd_pcm,snd_timer
soundcore               4096  1 snd
ide_cd                 32836  0 
cdrom                  31456  1 ide_cd
8139too                15456  0 
mii                     2432  1 8139too
crc32                   2848  1 8139too

scice# echo userspace > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo: write error: invalid argument

scice# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors 
performance powersave

scice# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 
powersave

scice# uname -a
Linux scice 2.6.3 #7 Wed Mar 3 08:38:35 CET 2004 i686 GNU/Linux

scice# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver 
longrun

scice# cat /proc/cpuinfo 
processor       : 0
vendor_id       : GenuineTMx86
cpu family      : 6
model           : 4
model name      : Transmeta(tm) Crusoe(tm) Processor TM5600
stepping        : 3
cpu MHz         : 599.263
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr cx8 sep cmov mmx longrun lrti
bogomips        : 1101.82


scice# powernowd -d
PowerNow Daemon v0.85, (c) 2003 John Clemens
Found 1 cpu.
Error writing file governor: Invalid argument
Couldn't get per-cpu data: Illegal seek
PowerNowd encountered and error and could not start.
Please make sure that:
 - You are running a v2.5/v2.6 kernel or later
 - That you have sysfs mounted /sys
 - That you have the core cpufreq and cpufreq-userspace
   modules loaded into your kernel
 - That you have the cpufreq driver for your cpu loaded,
   and that it works. (check dmesg for errors)
If all of the above are true, and you still have problems,
please email the author: clemej@alum.rpi.edu


Any hints? I am compiling 2.6.4 right now, but I don't see changes,
which could fix this problem.

Greetings,
Nico

ps: config.gz attached

--mP3DRpeJDSE+ciuQ
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="config.gz"
Content-Transfer-Encoding: base64

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

--mP3DRpeJDSE+ciuQ--

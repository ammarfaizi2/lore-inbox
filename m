Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129147AbQKIAlh>; Wed, 8 Nov 2000 19:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129205AbQKIAl1>; Wed, 8 Nov 2000 19:41:27 -0500
Received: from name.viagra-canada.com ([24.108.87.2]:63758 "EHLO
	name.hypocrite.org") by vger.kernel.org with ESMTP
	id <S129147AbQKIAlO>; Wed, 8 Nov 2000 19:41:14 -0500
From: Christopher Thompson <chris@hypocrite.org>
Date: Wed, 8 Nov 2000 17:40:53 -0700
X-Mailer: KMail [version 1.1.95.5]
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Subject: ISSUE: Locks up on boot with HPT370
MIME-Version: 1.0
Message-Id: <00110817405300.00254@hatred>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Resubmitting this bug as it happens both on -test10 and, I just 
verified, -test11-pre1.

(using the bug report form. if you wish to contact me, please 
do so off-list as I am not subscribed.) 

1. Locks up on boot with HPT370 
2. Using kernel 2.4.0-test10, my machine gets to the part of 
the bootup where it has detected drives and CD-ROM's on hda, 
hdc, hdd. It then locks up, the floppy light is on and the 
keyboard is non-responsive. Alt-SysRq-foo does nothing. Have 
to hard-reset. On 2.2.17 with the IDE backport, the kernel 
boots up fine, showing that it has found /dev/hde and continuing 
as usual. Have not tested with anything before test9-pre-foo, 
just got this motherboard. 
3. HPT370, Highpoint, HPT366, IDE, boot 
4. 2.4.0-test10 
5. No oops shown. Machine just locks up hard. 
6. Reproducable 100% of the time when booting my machine with 
2.4.0-test10. Please note that the HPT366 is, of course, 
compiled in and is not a module. 
7.1 Debian Potato install with the 2.4.0-test10 kernel from 
ftp.kernel.org 
7.2 $ cat /proc/cpuinfo 
processor : 0 
vendor_id : AuthenticAMD 
cpu family : 6 
model : 4 
model name : AMD Athlon(tm) Processor 
stepping : 2 
cpu MHz : 900.059 
cache size : 256 KB 
fdiv_bug : no 
hlt_bug : no 
sep_bug : no 
f00f_bug : no 
coma_bug : no 
fpu : yes 
fpu_exception : yes 
cpuid level : 1 
wp : yes 
flags : fpu vme de pse tsc msr 6 mce cx8 sep mtrr pge 
14 cmov pat 17 psn mmxext mmx fxsr 3dnowext 3dnow 
bogomips : 1795.69 

Note that this is with an Abit KT7-RAID motherboard. The hard 
drives are NOT in raid mode. 
7.3 No module information to show as the kernel does not boot. 
7.4 No SCSI drives installed, nothing compiled in. 
7.5 Works perfectly fine with kernel 2.2.17, Win98SE, Win2k. 
X. Have found no workaround. Cannot tell if the problem is in 
the HPT366/370 support or is caused elsewhere. Please contact 
me if you have any suggestions or have a patch you wish me to 
try out. Please note that on Thursday and Friday, I will be 
away from the Internet. 
I realise that the highpoint controllers are somewhat 
problematic but note that this system works fine in 2.2.17. 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

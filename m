Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751042AbWAYG30@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbWAYG30 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 01:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbWAYG30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 01:29:26 -0500
Received: from us02smtp1.synopsys.com ([198.182.60.75]:10239 "EHLO
	vaxjo.synopsys.com") by vger.kernel.org with ESMTP id S1751042AbWAYG30 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 01:29:26 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: My Linux doesn't honor "kill -9"...Is it a bug or a feature?
Date: Wed, 25 Jan 2006 11:59:22 +0530
Message-ID: <7EC22963812B4F40AE780CF2F140AFE944119C@IN01WEMBX1.internal.synopsys.com>
Thread-Topic: My Linux doesn't honor "kill -9"...Is it a bug or a feature?
Thread-Index: AcYheK2n9B0w2FJAQ4isCXHFJfrlTA==
From: "Arijit Das" <Arijit.Das@synopsys.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 25 Jan 2006 06:29:24.0067 (UTC) FILETIME=[AEE4F330:01C62178]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My GNU/Linux system sometimes doesn't seem to honor the 'KILL' signal
which is supposed to be a sure-shot killer.

I am using RHWS3.0_U5 in AMD64

Find below some info about one of the process that is not honoring
'KILL' signal.

Please let me know if I can do something to solve this issue.

Thanks,
Arijit


vgamd225> kill -9 31212
vgamd225> ps -eo pid | grep 31212
31212
vgamd225> /bin/kill -s KILL 31212
vgamd225> ps -eo pid | grep 31212
31212
vgamd225>
vgamd225> cat /proc/31212/mem 
cat: /proc/31212/mem: No such process
vgamd225> ls /proc/31212/
cmdline  cpu  cwd  environ  exe  fd  maps  mem  mounts  root  stat
statm  status
vgamd225> cat /proc/31212/cpu 
cpu  22 15883
cpu0 12 8605
cpu1 10 7278
vgamd225> cat /proc/31212/maps
0000000008048000-000000000804e000 r-xp 0000000000000000 00:1b 1714602
/remote/vgn3/linux_RH3_AMD64_VCS2005.06_32_Engineer/bin/qdbgth
000000000804e000-0000000008050000 rwxp 0000000000005000 00:1b 1714602
/remote/vgn3/linux_RH3_AMD64_VCS2005.06_32_Engineer/bin/qdbgth
0000000008050000-0000000008071000 rwxp 0000000000000000 00:00 0
0000000040000000-0000000040015000 r-xp 0000000000000000 08:03 539620
/lib/ld-2.3.2.so
0000000040015000-0000000040016000 rwxp 0000000000015000 08:03 539620
/lib/ld-2.3.2.so
0000000040016000-0000000040017000 rwxp 0000000000000000 00:00 0
0000000040037000-0000000040038000 rwxp 0000000000000000 00:00 0
0000000040038000-0000000040059000 r-xp 0000000000000000 08:03 1062891
/lib/tls/libm-2.3.2.so
0000000040059000-000000004005a000 rwxp 0000000000021000 08:03 1062891
/lib/tls/libm-2.3.2.so
000000004005a000-000000004005c000 r-xp 0000000000000000 08:03 539633
/lib/libdl-2.3.2.so
000000004005c000-000000004005d000 rwxp 0000000000001000 08:03 539633
/lib/libdl-2.3.2.so
000000004005d000-000000004018f000 r-xp 0000000000000000 08:03 1062889
/lib/tls/libc-2.3.2.so
000000004018f000-0000000040192000 rwxp 0000000000132000 08:03 1062889
/lib/tls/libc-2.3.2.so
0000000040192000-0000000040196000 rwxp 0000000000000000 00:00 0
0000000077847000-00000000ffffe000 rwxp ffffffff7784b000 00:00 0
vgamd225> cat /proc/31212/mem
cat: /proc/31212/mem: No such process
vgamd225> cat /proc/31212/stat
31212 (qdbgth) D 1 30723 9648 0 -1 0 559225 0 114 0 22 15894 0 0 15 0 0
0 26634347 2292228096 103178 18446744073709551615 134512640 134536991
4294948320 18446744073709551615 134527712 256 64 33558531 1098936060
18446744071563252746 0 0 17 1 0 0 22 15894 0 0
vgamd225> cat /proc/31212/statm
559301 103184 61 0 0 103184 103121
vgamd225> 
vgamd225> cat /proc/31212/status 
Name:   qdbgth
State:  D (disk sleep)
Tgid:   31212
Pid:    31212
PPid:   1
TracerPid:      0
Uid:    7152    7152    7152    7152
Gid:    30      30      30      30
FDSize: 64
Groups: 30 22594 31 4023 31 2688 22514 20076 
VmSize:  2238676 kB
VmLck:         0 kB
VmRSS:    412884 kB
VmData:      156 kB
VmStk:   2237016 kB
VmExe:        24 kB
VmLib:      1448 kB
SigPnd: 0000000000000100
ShdPnd: 0000000000000100
SigBlk: 0000000000000040
SigIgn: 0000000002001003
SigCgt: 0000000041806efc
CapInh: 0000000000000000
CapPrm: 0000000000000000
CapEff: 0000000000000000
vgamd225> cat /proc/31212/mounts
rootfs / rootfs rw 0 0
/dev/root / ext3 rw 0 0
/proc /proc proc rw 0 0
none /dev/pts devpts rw 0 0
usbdevfs /proc/bus/usb usbdevfs rw 0 0
/dev/sdb1 /SCRATCH ext3 rw 0 0
/dev/sda1 /boot ext3 rw 0 0
none /dev/shm tmpfs rw 0 0
automount(pid1514) /linux autofs rw 0 0
automount(pid1714) /slowfs autofs rw 0 0
automount(pid1797) /fs autofs rw 0 0
automount(pid1577) /global autofs rw 0 0
automount(pid1648) /remote autofs rw 0 0
automount(pid1883) /build autofs rw 0 0
automount(pid1972) /nacbkp autofs rw 0 0
automount(pid2065) /desktop autofs rw 0 0
us01depot2:/vol/DEPOT/depot/amd64-2.4 /linux/depot nfs
ro,v3,rsize=32768,wsize=32768,hard,intr,tcp,nocto,lock,noacl,addr=us01de
pot2 0 0
codenac-1:/vol/VTG06/sge1 /remote/sge1 nfs
rw,v3,rsize=32768,wsize=32768,hard,intr,tcp,lock,noacl,addr=codenac-1 0
0
nactime-1:/vol/VG11/vgnightly /build/vgnightly nfs
rw,v3,rsize=32768,wsize=32768,hard,intr,tcp,lock,noacl,addr=nactime-1 0
0
us01filer03-1:/vol/VG22/vgn3 /remote/vgn3 nfs
rw,v3,rsize=32768,wsize=32768,hard,intr,tcp,lock,noacl,addr=us01filer03-
1 0 0
us01filer05:/vol/VG52/vtghome7 /remote/vtghome7 nfs
rw,v3,rsize=32768,wsize=32768,hard,intr,tcp,lock,noacl,addr=us01filer05
0 0
nackenstein:/vol/mail/mail /remote/mail nfs
rw,sync,v3,rsize=32768,wsize=32768,acregmin=0,acregmax=0,acdirmin=0,acdi
rmax=0,hard,intr,tcp,noac,lock,noacl,addr=nackenstein 0 0
us01depot3:/vol/DEPOT/depot/u /remote/u nfs
rw,v3,rsize=32768,wsize=32768,hard,intr,tcp,lock,noacl,addr=us01depot3 0
0
nactech-1:/vol/VTG04/vtgregress2 /remote/vtgregress2 nfs
rw,v3,rsize=32768,wsize=32768,hard,intr,tcp,lock,noacl,addr=nactech-1 0
0
vgamd225> 
vgamd225> cat /proc/31212/cmdline
/fs/Release/linux_RH3_AMD64_VCS2005.06_32_Engineer/bin/qdbgth/fs/Release
/linux_RH3_AMD64_VCS2005.06_32_Engineer/bin/qdbgvgamd225> 
vgamd225> kill -9 31212
vgamd225> kill -9 31212
vgamd225> /bin/kill -s KILL 31212
vgamd225> ps -eo pid | grep 31212
31212
vgamd225>

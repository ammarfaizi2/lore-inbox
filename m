Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316934AbSE1VOI>; Tue, 28 May 2002 17:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316940AbSE1VOH>; Tue, 28 May 2002 17:14:07 -0400
Received: from colossus.systems.pipex.net ([62.190.223.73]:6318 "EHLO
	colossus.systems.pipex.net") by vger.kernel.org with ESMTP
	id <S316934AbSE1VOC>; Tue, 28 May 2002 17:14:02 -0400
Subject: PROBLEM: Atapi IDE CD/DVD Driver - Ooops, Unable to handle kernel
	NULL pointer dere....
From: Michael Barker <mbarker@dsl.pipex.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 28 May 2002 22:10:09 +0100
Message-Id: <1022620209.1368.17.camel@corona>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keywords: Modules Ooops CD-ROM DVD

Hi,

Currently running Redhat 7.2 (uname = 'Linux corona 2.4.7-10 #1 Thu Sep
6 16:46:36 EDT 2001 i686 unknown'). AMD 1600, Asus AV333 Motherboard,
MATSHITADVD-ROM SR-8587, ATAPI CD/DVD-ROM drive.  I get the following
Ooops on booting (output below).  The CD-Rom will become unusable and
the ide-cd module will remain in the initalising state (judging by the
output from lsmod).  It occurs intermittantly, a reboot has so far fixed
the problem.  It has occured twice in the last 6 or so boots of my
machine.  If you need any more info let me know.  I am not on the lkml
so if you could cc me in the reply that would be appreciated.

Thanks,
Michael Barker
mbarker@dsl.pipex.com

Ooops message (from ksysoops thingy):

Error (expand_objects): cannot stat(/lib/aic7xxx.o) for aic7xxx
Error (expand_objects): cannot stat(/lib/sd_mod.o) for sd_mod
Error (expand_objects): cannot stat(/lib/scsi_mod.o) for scsi_mod
Error (pclose_local): find_objects pclose failed 0x100
Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base
says c01b30d0, System.map says c0154d30.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol usb_devfs_handle  , usbcore
says d0966a00, /lib/modules/2.4.7-10/kernel/drivers/usb/usbcore.o says
d0966520.  Ignoring /lib/modules/2.4.7-10/kernel/drivers/usb/usbcore.o
entry
Warning (map_ksym_to_module): cannot match loaded module ext3 to a
unique module object.  Trace may not be reliable.
Warning (compare_maps): mismatch on symbol sd  , sd_mod says d081bce4,
/lib/modules/2.4.7-10/kernel/drivers/scsi/sd_mod.o says d081bba0. 
Ignoring /lib/modules/2.4.7-10/kernel/drivers/scsi/sd_mod.o entry
Warning (compare_maps): mismatch on symbol proc_scsi  , scsi_mod says
d08175c8, /lib/modules/2.4.7-10/kernel/drivers/scsi/scsi_mod.o says
d0815e50.  Ignoring /lib/modules/2.4.7-10/kernel/drivers/scsi/scsi_mod.o
entry
Warning (compare_maps): mismatch on symbol scsi_devicelist  , scsi_mod
says d08175f4, /lib/modules/2.4.7-10/kernel/drivers/scsi/scsi_mod.o says
d0815e7c.  Ignoring /lib/modules/2.4.7-10/kernel/drivers/scsi/scsi_mod.o
entry
Warning (compare_maps): mismatch on symbol scsi_hostlist  , scsi_mod
says d08175f0, /lib/modules/2.4.7-10/kernel/drivers/scsi/scsi_mod.o says
d0815e78.  Ignoring /lib/modules/2.4.7-10/kernel/drivers/scsi/scsi_mod.o
entry
Warning (compare_maps): mismatch on symbol scsi_hosts  , scsi_mod says
d08175f8, /lib/modules/2.4.7-10/kernel/drivers/scsi/scsi_mod.o says
d0815e80.  Ignoring /lib/modules/2.4.7-10/kernel/drivers/scsi/scsi_mod.o
entry
Warning (compare_maps): mismatch on symbol scsi_logging_level  ,
scsi_mod says d08175c4,
/lib/modules/2.4.7-10/kernel/drivers/scsi/scsi_mod.o says d0815e4c. 
Ignoring /lib/modules/2.4.7-10/kernel/drivers/scsi/scsi_mod.o entry
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
Unable to handle kernel NULL pointer dereference at virtual address
00000028
c018c91a
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c018c91a>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210212
eax: 00000000   ebx: 00001600   ecx: 00000000   edx: 00000000
esi: c02e1e50   edi: 00001100   ebp: 00000040   esp: cae83edc
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 1299, stackpage=cae83000)
Stack: 00001600 00000000 00000330 00000000 c02e2118 00000330 c018c9b1
00001600 
       00000001 cc221e00 00000000 cc221f44 00000002 c018eed5 d1b08a57
d1b0b980 
       d1b05000 00000001 00000001 00000001 c0117795 d1b0b87c ca961000
00006778 
Call Trace: [<c018c9b1>] [<c018eed5>] [<d1b08a57>] [<d1b0b980>]
[<d1b05000>] 
   [<c0117795>] [<d1b0b87c>] [<d1afd000>] [<d1b05060>] [<c0106f2b>] 
Code: 8b 40 28 85 c0 74 04 56 ff d0 5a 80 a6 ae 00 00 00 fb 8d 86 

>>EIP; c018c91a <ide_revalidate_disk+da/110>   <=====
Trace; c018c9b1 <revalidate_drives+61/90>
Trace; c018eed5 <ide_register_module+35/40>
Trace; d1b08a57 <[ide-cd]init_module+187/19f>
Trace; d1b0b980 <[ide-cd]ide_cdrom_module+0/10>
Trace; d1b05000 <[ide-cd]__module_kernel_version+0/18>
Trace; c0117795 <sys_init_module+535/5f0>
Trace; d1b0b87c <[ide-cd].LC76+1c/40>
Trace; d1afd000 <[cmpci]__module_description+1c00/1c60>
Trace; d1b05060 <[ide-cd]cdrom_saw_media_change+0/30>
Trace; c0106f2b <system_call+33/38>
Code;  c018c91a <ide_revalidate_disk+da/110>
00000000 <_EIP>:
Code;  c018c91a <ide_revalidate_disk+da/110>   <=====
   0:   8b 40 28                  mov    0x28(%eax),%eax   <=====
Code;  c018c91d <ide_revalidate_disk+dd/110>
   3:   85 c0                     test   %eax,%eax
Code;  c018c91f <ide_revalidate_disk+df/110>
   5:   74 04                     je     b <_EIP+0xb> c018c925
<ide_revalidate_disk+e5/110>
Code;  c018c921 <ide_revalidate_disk+e1/110>
   7:   56                        push   %esi
Code;  c018c922 <ide_revalidate_disk+e2/110>
   8:   ff d0                     call   *%eax
Code;  c018c924 <ide_revalidate_disk+e4/110>
   a:   5a                        pop    %edx
Code;  c018c925 <ide_revalidate_disk+e5/110>
   b:   80 a6 ae 00 00 00 fb      andb   $0xfb,0xae(%esi)
Code;  c018c92c <ide_revalidate_disk+ec/110>
  12:   8d 86 00 00 00 00         lea    0x0(%esi),%eax


10 warnings and 6 errors issued.  Results may not be reliable.


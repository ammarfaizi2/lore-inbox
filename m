Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271503AbRHZTrt>; Sun, 26 Aug 2001 15:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270712AbRHZTrm>; Sun, 26 Aug 2001 15:47:42 -0400
Received: from WARSL401PIP3.highway.telekom.at ([195.3.96.75]:17479 "HELO
	email02.aon.at") by vger.kernel.org with SMTP id <S269868AbRHZTrX>;
	Sun, 26 Aug 2001 15:47:23 -0400
Content-Type: text/plain; charset=US-ASCII
From: Peter Klotz <peter.klotz@aon.at>
To: linux-kernel@vger.kernel.org
Subject: Kernel oops with 2.4.8
Date: Sun, 26 Aug 2001 21:50:50 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01082621505000.07911@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi developers

The following kernel oops occurred recently. I ran it through ksymoops after 
copying it from the screen and rebooting.

Maybe it is of some use.

Please CC to me since I am not on the list.

Bye, Peter.




[root@localhost oops]# ksymoops -m /boot/System.map-2.4.8 < oops.txt
ksymoops 2.4.1 on i686 2.4.8.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.8/ (default)
     -m /boot/System.map-2.4.8 (specified)

Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says 
c01aad60, System.map says c014fc10.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol proc_scsi  , scsi_mod says 
cc956674, /lib/modules/2.4.8/kernel/drivers/scsi/scsi_mod.o says cc954f0c.  
Ignoring /lib/modules/2.4.8/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_devicelist  , scsi_mod says 
cc9566a0, /lib/modules/2.4.8/kernel/drivers/scsi/scsi_mod.o says cc954f38.  
Ignoring /lib/modules/2.4.8/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_hostlist  , scsi_mod says 
cc95669c, /lib/modules/2.4.8/kernel/drivers/scsi/scsi_mod.o says cc954f34.  
Ignoring /lib/modules/2.4.8/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_hosts  , scsi_mod says 
cc9566a4, /lib/modules/2.4.8/kernel/drivers/scsi/scsi_mod.o says cc954f3c.  
Ignoring /lib/modules/2.4.8/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_logging_level  , scsi_mod 
says cc956670, /lib/modules/2.4.8/kernel/drivers/scsi/scsi_mod.o says 
cc954f08.  Ignoring /lib/modules/2.4.8/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol usb_devfs_handle  , usbcore says 
cc81d480, /lib/modules/2.4.8/kernel/drivers/usb/usbcore.o says cc81cfa0.  
Ignoring /lib/modules/2.4.8/kernel/drivers/usb/usbcore.o entry
Unable to handle kernel paging request at virtual address f35db60f
c0111cc8
Oops: 0000
CPU: 0
EIP: 0010:[<c0111cc8>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010012
eax: 00000001 ebx: 8414758b ecx: f35db60f edx: 00000014
ds: 0018 es: 0018 ss: 0018
Process swapper (pid: 0, stackpage=c0261000)
Stack: c23fe8ac 00000001 00000082 00000003 c23fe860 c23fe808 00000001 00000001
       c013285f c23fe860 cbfc11a0 c0179b6a c23fe860 00000001 cbfc11a0 cbfc5060
       00000046 c02c4fc0 c0184ff5 cbfc11a0 00000001 c02c50f0 00000000 cbfc11a0
Call Trace: [<c013285f>] [<c0179b6a>] [<c0184ff5>] [<c018ef00>] [<c0186890>] 
[<c018ee90>] [<c01081aa>] [<c0108328>]
            [<c0105390>] [<c0105390>] [<c0106f64>] [<c0105390>] [<c0105390>] 
[<c01053b3>] [<c0105432>] [<c0105000>]
Code: 8b 01 85 45 f0 74 4f 31 c0 9c 5e fa c7 01 00 00 00 00 8b 51
 
>>EIP; c0111cc8 <__wake_up+38/a0>   <=====
Trace; c013285f <end_buffer_io_sync+3f/50>
Trace; c0179b6a <end_that_request_first+5a/b0>
Trace; c0184ff5 <ide_end_request+25/60>
Trace; c018ef00 <ide_dma_intr+70/b0>
Trace; c0186890 <ide_intr+f0/150>
Trace; c018ee90 <ide_dma_intr+0/b0>
Trace; c01081aa <handle_IRQ_event+3a/70>
Trace; c0108328 <do_IRQ+68/b0>
Trace; c0105390 <default_idle+0/30>
Trace; c0105390 <default_idle+0/30>
Trace; c0106f64 <ret_from_intr+0/7>
Trace; c0105390 <default_idle+0/30>
Trace; c0105390 <default_idle+0/30>
Trace; c01053b3 <default_idle+23/30>
Trace; c0105432 <cpu_idle+52/70>
Trace; c0105000 <_stext+0/0>
Code;  c0111cc8 <__wake_up+38/a0>
00000000 <_EIP>:
Code;  c0111cc8 <__wake_up+38/a0>   <=====
   0:   8b 01                     mov    (%ecx),%eax   <=====
Code;  c0111cca <__wake_up+3a/a0>
   2:   85 45 f0                  test   %eax,0xfffffff0(%ebp)
Code;  c0111ccd <__wake_up+3d/a0>
   5:   74 4f                     je     56 <_EIP+0x56> c0111d1e 
<__wake_up+8e/a0>
Code;  c0111ccf <__wake_up+3f/a0>
   7:   31 c0                     xor    %eax,%eax
Code;  c0111cd1 <__wake_up+41/a0>
   9:   9c                        pushf
Code;  c0111cd2 <__wake_up+42/a0>
   a:   5e                        pop    %esi
Code;  c0111cd3 <__wake_up+43/a0>
   b:   fa                        cli
Code;  c0111cd4 <__wake_up+44/a0>
   c:   c7 01 00 00 00 00         movl   $0x0,(%ecx)
Code;  c0111cda <__wake_up+4a/a0>
  12:   8b 51 00                  mov    0x0(%ecx),%edx
 
Kernel panic: Aiee, killing interrupt handler!
 
7 warnings issued.  Results may not be reliable.

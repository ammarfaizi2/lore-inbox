Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269174AbRHMDm5>; Sun, 12 Aug 2001 23:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269255AbRHMDms>; Sun, 12 Aug 2001 23:42:48 -0400
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:20703 "EHLO snfc21.pbi.net")
	by vger.kernel.org with ESMTP id <S269174AbRHMDmh>;
	Sun, 12 Aug 2001 23:42:37 -0400
Date: Sun, 12 Aug 2001 20:46:49 -0700
From: Francois Lorrain <francois.lorrain@attglobal.net>
Subject: Oops on 2.4.7-ac7 / ac11 in ide-scsi
To: linux-kernel@vger.kernel.org
Message-id: <3B774DA9.5050500@attglobal.net>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_hYje9z+tXGJT8NWBl5+WIw)"
X-Accept-Language: fr, en
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.7-ac11 i686; en-US; rv:0.9.1)
 Gecko/20010622
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_hYje9z+tXGJT8NWBl5+WIw)
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT


  Hello,

  I can trigger this oops from a user program running from a non 
priviledged account : dos -A (dosemu). It kills the kernel in an 
interrupt routine so I have to transcribe the oops from the dump 
on-screen :-)

  There are two ksymoops results attached.

  Configuration : PIII 550 MHz 256MB RAM Intel 440 chipset + HPT343 ide
(IDE CD writer and CD connected to HPT343).
  RH7.1 - 2.4.7 ac7 and ac11 NVidia 32Meg Geoforce II.

  The crash only occurs if X (Gnome) is running, I suspect the applet 
which pools the CD drives might trigger the OOPS. It seems that it has 
something to do with the end of the transaction on the ide-scsi CR R/W.

  Let me know if you need more info. I am not not the list, please copy 
me on the answer ...

  Keep the good work !

  Francois

  Francois.lorrain@attglobal.net


--Boundary_(ID_hYje9z+tXGJT8NWBl5+WIw)
Content-type: text/plain; name=oops.lst
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=oops.lst

ksymoops 2.4.0 on i686 2.4.7-ac11.  Options used
     -v ./work/linux/linux-2.4.7/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.7-ac11/ (default)
     -m /boot/System.map-2.4.7-ac11 (default)

Warning (compare_maps): mismatch on symbol proc_scsi  , scsi_mod says d09811cc, /lib/modules/2.4.7-ac11/kernel/drivers/scsi/scsi_mod.o says d0980c70.  Ignoring /lib/modules/2.4.7-ac11/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_devicelist  , scsi_mod says d09811f8, /lib/modules/2.4.7-ac11/kernel/drivers/scsi/scsi_mod.o says d0980c9c.  Ignoring /lib/modules/2.4.7-ac11/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_hostlist  , scsi_mod says d09811f4, /lib/modules/2.4.7-ac11/kernel/drivers/scsi/scsi_mod.o says d0980c98.  Ignoring /lib/modules/2.4.7-ac11/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_hosts  , scsi_mod says d09811fc, /lib/modules/2.4.7-ac11/kernel/drivers/scsi/scsi_mod.o says d0980ca0.  Ignoring /lib/modules/2.4.7-ac11/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_logging_level  , scsi_mod says d09811c8, /lib/modules/2.4.7-ac11/kernel/drivers/scsi/scsi_mod.o says d0980c6c.  Ignoring /lib/modules/2.4.7-ac11/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol md_size  , md says d0888120, /lib/modules/2.4.7-ac11/kernel/drivers/md/md.o says d0887f40.  Ignoring /lib/modules/2.4.7-ac11/kernel/drivers/md/md.o entry
Warning (compare_maps): mismatch on symbol mddev_map  , md says d0887920, /lib/modules/2.4.7-ac11/kernel/drivers/md/md.o says d0887740.  Ignoring /lib/modules/2.4.7-ac11/kernel/drivers/md/md.o entry
Warning (compare_maps): mismatch on symbol usb_devfs_handle  , usbcore says d086da80, /lib/modules/2.4.7-ac11/kernel/drivers/usb/usbcore.o says d086d5a0.  Ignoring /lib/modules/2.4.7-ac11/kernel/drivers/usb/usbcore.o entry
Warning (compare_maps): mismatch on symbol unix_socket_table  , unix says d0803220, /lib/modules/2.4.7-ac11/kernel/net/unix/unix.o says d0802e60.  Ignoring /lib/modules/2.4.7-ac11/kernel/net/unix/unix.o entry
CPU:    0
EIP:    0010:d09799a7
EFLAGS: 00010206
eax: 28000000   ebx: ca997200   ecx: 00000010   edx: cfa835a0
esi: ca997304   edi: cfa835a8   ebp: 00000000   esp: c6a53d74
ds: 0018   es: 0000   ss: 0018
Process dos (pid: 3374, process nr: 21, stackpage=00589000)
Stack: 28000000 cf4bb000 cfab4ee0 28000000 00000246 c0274e80 c0274e80 28000000
       c0274ea0 d0983455 ca997200 00000000 00000000 00000000 00000000 00000000
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
Call Trace: d0983455 d097781f d0983536 c0187690 d09834b0
Code: f3 a5 53 ff 53 20 5b fa 83 c4 10 5b 5e 5f 5d c3 89 f6 8d bc
Using defaults from ksymoops -t elf32-i386 -a i386

Trace; d0983455 <[ide-scsi]idescsi_end_request+205/260>
Trace; d097781f <[scsi_mod]scsi_add_timer+1f/70>
Trace; d0983536 <[ide-scsi]idescsi_pc_intr+86/250>
Trace; c0187690 <ide_intr+f0/150>
Trace; d09834b0 <[ide-scsi]idescsi_pc_intr+0/250>
Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   f3 a5                     repz movsl %ds:(%esi),%es:(%edi)
Code;  00000002 Before first symbol
   2:   53                        push   %ebx
Code;  00000003 Before first symbol
   3:   ff 53 20                  call   *0x20(%ebx)
Code;  00000006 Before first symbol
   6:   5b                        pop    %ebx
Code;  00000007 Before first symbol
   7:   fa                        cli    
Code;  00000008 Before first symbol
   8:   83 c4 10                  add    $0x10,%esp
Code;  0000000b Before first symbol
   b:   5b                        pop    %ebx
Code;  0000000c Before first symbol
   c:   5e                        pop    %esi
Code;  0000000d Before first symbol
   d:   5f                        pop    %edi
Code;  0000000e Before first symbol
   e:   5d                        pop    %ebp
Code;  0000000f Before first symbol
   f:   c3                        ret    
Code;  00000010 Before first symbol
  10:   89 f6                     mov    %esi,%esi
Code;  00000012 Before first symbol
  12:   8d bc 00 00 00 00 00      lea    0x0(%eax,%eax,1),%edi


9 warnings issued.  Results may not be reliable.

--Boundary_(ID_hYje9z+tXGJT8NWBl5+WIw)
Content-type: text/plain; name=oops1.lst
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=oops1.lst

ksymoops 2.4.0 on i686 2.4.7-ac11.  Options used
     -v ./work/linux/linux-2.4.7/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.7-ac11/ (default)
     -m /boot/System.map-2.4.7-ac11 (default)

Warning (compare_maps): mismatch on symbol proc_scsi  , scsi_mod says d09811cc, /lib/modules/2.4.7-ac11/kernel/drivers/scsi/scsi_mod.o says d0980c70.  Ignoring /lib/modules/2.4.7-ac11/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_devicelist  , scsi_mod says d09811f8, /lib/modules/2.4.7-ac11/kernel/drivers/scsi/scsi_mod.o says d0980c9c.  Ignoring /lib/modules/2.4.7-ac11/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_hostlist  , scsi_mod says d09811f4, /lib/modules/2.4.7-ac11/kernel/drivers/scsi/scsi_mod.o says d0980c98.  Ignoring /lib/modules/2.4.7-ac11/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_hosts  , scsi_mod says d09811fc, /lib/modules/2.4.7-ac11/kernel/drivers/scsi/scsi_mod.o says d0980ca0.  Ignoring /lib/modules/2.4.7-ac11/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_logging_level  , scsi_mod says d09811c8, /lib/modules/2.4.7-ac11/kernel/drivers/scsi/scsi_mod.o says d0980c6c.  Ignoring /lib/modules/2.4.7-ac11/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol md_size  , md says d0888120, /lib/modules/2.4.7-ac11/kernel/drivers/md/md.o says d0887f40.  Ignoring /lib/modules/2.4.7-ac11/kernel/drivers/md/md.o entry
Warning (compare_maps): mismatch on symbol mddev_map  , md says d0887920, /lib/modules/2.4.7-ac11/kernel/drivers/md/md.o says d0887740.  Ignoring /lib/modules/2.4.7-ac11/kernel/drivers/md/md.o entry
Warning (compare_maps): mismatch on symbol usb_devfs_handle  , usbcore says d086da80, /lib/modules/2.4.7-ac11/kernel/drivers/usb/usbcore.o says d086d5a0.  Ignoring /lib/modules/2.4.7-ac11/kernel/drivers/usb/usbcore.o entry
Warning (compare_maps): mismatch on symbol unix_socket_table  , unix says d0803220, /lib/modules/2.4.7-ac11/kernel/net/unix/unix.o says d0802e60.  Ignoring /lib/modules/2.4.7-ac11/kernel/net/unix/unix.o entry
CPU:    0
EIP:    0010:d09792aa
EFLAGS: 00010046
eax: 00000000   ebx: c870e000   ecx: 00000010   edx: c970e104
esi: 00000bb8   edi: c870c104   ebp: 00000004   esp: c776fdc0
ds: 0018   es: 0000   ss: 0018
Process dos (pid: 1778, stackpage=c776f000)
Stack: c870e000 c870c000 d0979621 c870e000 00000002 ccc33000 cccd1720 00000000
       00000246 c14c30e0 00000000 c79c2620 d0983455 c870e000 00000000 c14c30e0
       c14c6680 c0274e80 00000282 00000000 c0274e80 c14c30e0 c79c2620 cff00a60
Call Trace: d0979621 d0982455 d09834b0 c01084aa c0108628 c0107ce0 c0106fad c0106ebb
Code: f3 ab 8b 43 0c 80 b8 d9 00 00 00 03 7f 0a 0f b6 43 4c c0 e0
Using defaults from ksymoops -t elf32-i386 -a i386

Trace; d0979621 <[scsi_mod]scsi_old_done+281/620>
Trace; d0982455 <[scsi_mod]__kstrtab_scsi_delete_timer+f30/1b3b>
Trace; d09834b0 <[ide-scsi]idescsi_pc_intr+0/250>
Trace; c01084aa <handle_IRQ_event+3a/70>
Trace; c0108628 <do_IRQ+68/b0>
Trace; c0107ce0 <do_general_protection+0/80>
Trace; c0106fad <error_code+2d/40>
Trace; c0106ebb <system_call+33/38>
Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   f3 ab                     repz stos %eax,%es:(%edi)
Code;  00000002 Before first symbol
   2:   8b 43 0c                  mov    0xc(%ebx),%eax
Code;  00000005 Before first symbol
   5:   80 b8 d9 00 00 00 03      cmpb   $0x3,0xd9(%eax)
Code;  0000000c Before first symbol
   c:   7f 0a                     jg     18 <_EIP+0x18> 00000018 Before first symbol
Code;  0000000e Before first symbol
   e:   0f b6 43 4c               movzbl 0x4c(%ebx),%eax
Code;  00000012 Before first symbol
  12:   c0 e0 00                  shl    $0x0,%al


9 warnings issued.  Results may not be reliable.

--Boundary_(ID_hYje9z+tXGJT8NWBl5+WIw)--

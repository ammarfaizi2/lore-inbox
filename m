Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270018AbRHNDTd>; Mon, 13 Aug 2001 23:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270199AbRHNDTZ>; Mon, 13 Aug 2001 23:19:25 -0400
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:4319 "EHLO pltn13.pbi.net")
	by vger.kernel.org with ESMTP id <S270018AbRHNDTN>;
	Mon, 13 Aug 2001 23:19:13 -0400
Date: Mon, 13 Aug 2001 20:23:30 -0700
From: Francois Lorrain <francois.lorrain@attglobal.net>
Subject: Re: Oops on 2.4.7-ac7 / ac11 in ide-scsi
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Message-id: <3B7899B2.5010604@attglobal.net>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_EcwVPxPRzPfE2MNZKvS4NA)"
X-Accept-Language: fr, en
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.8-ac4 i686; en-US; rv:0.9.1)
 Gecko/20010622
In-Reply-To: <E15WHZd-0007Oe-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_EcwVPxPRzPfE2MNZKvS4NA)
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT

  Hello,

  I tried again with 2.4.8-ac4, figured it would better than ac2 ...

  I get the same trap (see attached ksymoops)
  (I was lazy so the register values are not correct)


Trace; d0979621 <[scsi_mod]scsi_old_done+281/620>
Trace; d0983455 <[ide-scsi]idescsi_end_request+205/260>
Trace; d09837a5 <[ide-scsi]idescsi_transfer_pc+a5/c0>
Trace; d0983536 <[ide-scsi]idescsi_pc_intr+86/250>
Trace; c0186288 <ide_set_handler+58/60>
Trace; c0107b00 <do_segment_not_present+30/a0>
Trace; d09834b0 <[ide-scsi]idescsi_pc_intr+0/250>
Trace; c01084aa <handle_IRQ_event+3a/70>
Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
    0:   f3 ab                     repz stos %eax,%es:(%edi)
Code;  00000002 Before first symbol
    2:   8b 43 0c                  mov    0xc(%ebx),%eax
Code;  00000005 Before first symbol
    5:   80 b8 d9 00 00 00 03      cmpb   $0x3,0xd9(%eax)
Code;  0000000c Before first symbol
    c:   7f 0a                     jg     18 <_EIP+0x18> 00000018 Before 
first symbol
Code;  0000000e Before first symbol
    e:   0f b6 43 4c               movzbl 0x4c(%ebx),%eax
Code;  00000012 Before first symbol
   12:   c0 e0 00                  shl    $0x0,%al

  I'll keep trying ...


  Francois


Alan Cox wrote:

>>  I can trigger this oops from a user program running from a non 
>>priviledged account : dos -A (dosemu). It kills the kernel in an 
>>interrupt routine so I have to transcribe the oops from the dump 
>>on-screen :-)
>>
> 
> Does this still happen on 2.4.8ac2. I backed out a change in the scsi
> code that seemed to make things very unhappy for several ide-scsi users.
> 
> .
> 
> 



--Boundary_(ID_EcwVPxPRzPfE2MNZKvS4NA)
Content-type: text/plain; name=oops2.lst
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=oops2.lst

ksymoops 2.4.0 on i686 2.4.8-ac4.  Options used
     -v ./work/linux/linux-2.4.8/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.8-ac4/ (default)
     -m /boot/System.map-2.4.8-ac4 (default)

Warning (compare_maps): mismatch on symbol packet_socks_nr  , af_packet says d09a5e64, /lib/modules/2.4.8-ac4/kernel/net/packet/af_packet.o says d09a5c44.  Ignoring /lib/modules/2.4.8-ac4/kernel/net/packet/af_packet.o entry
Warning (compare_maps): mismatch on symbol proc_scsi  , scsi_mod says d09811ac, /lib/modules/2.4.8-ac4/kernel/drivers/scsi/scsi_mod.o says d0980c50.  Ignoring /lib/modules/2.4.8-ac4/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_devicelist  , scsi_mod says d09811d8, /lib/modules/2.4.8-ac4/kernel/drivers/scsi/scsi_mod.o says d0980c7c.  Ignoring /lib/modules/2.4.8-ac4/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_hostlist  , scsi_mod says d09811d4, /lib/modules/2.4.8-ac4/kernel/drivers/scsi/scsi_mod.o says d0980c78.  Ignoring /lib/modules/2.4.8-ac4/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_hosts  , scsi_mod says d09811dc, /lib/modules/2.4.8-ac4/kernel/drivers/scsi/scsi_mod.o says d0980c80.  Ignoring /lib/modules/2.4.8-ac4/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_logging_level  , scsi_mod says d09811a8, /lib/modules/2.4.8-ac4/kernel/drivers/scsi/scsi_mod.o says d0980c4c.  Ignoring /lib/modules/2.4.8-ac4/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol md_size  , md says d0888120, /lib/modules/2.4.8-ac4/kernel/drivers/md/md.o says d0887f40.  Ignoring /lib/modules/2.4.8-ac4/kernel/drivers/md/md.o entry
Warning (compare_maps): mismatch on symbol mddev_map  , md says d0887920, /lib/modules/2.4.8-ac4/kernel/drivers/md/md.o says d0887740.  Ignoring /lib/modules/2.4.8-ac4/kernel/drivers/md/md.o entry
Warning (compare_maps): mismatch on symbol usb_devfs_handle  , usbcore says d086da80, /lib/modules/2.4.8-ac4/kernel/drivers/usb/usbcore.o says d086d5a0.  Ignoring /lib/modules/2.4.8-ac4/kernel/drivers/usb/usbcore.o entry
Warning (compare_maps): mismatch on symbol unix_socket_table  , unix says d0803200, /lib/modules/2.4.8-ac4/kernel/net/unix/unix.o says d0802e60.  Ignoring /lib/modules/2.4.8-ac4/kernel/net/unix/unix.o entry
CPU:    0
EIP:    0010:d09792a9
EFLAGS: 00010046
eax: 00000000   ebx: 00000000   ecx: 00000010   edx: c970e104
esi: 00000bb8   edi: c870c104   ebp: 00000004   esp: c776fdc0
ds: 0018   es: 0000   ss: 0018
Process dos (pid: 1778, stackpage=c776f000)
Stack: c9e4e800 c9e4e800 d0979621 c9e4e800 00000002 cccbc000 00000000 00000000
Call Trace: d0979621 d0983455 d09837a5 d0983536 c0186288 c0107b00 d09834b0 c01084aa
Code: f3 ab 8b 43 0c 80 b8 d9 00 00 00 03 7f 0a 0f b6 43 4c c0 e0
Using defaults from ksymoops -t elf32-i386 -a i386

Trace; d0979621 <[scsi_mod]scsi_old_done+281/620>
Trace; d0983455 <[ide-scsi]idescsi_end_request+205/260>
Trace; d09837a5 <[ide-scsi]idescsi_transfer_pc+a5/c0>
Trace; d0983536 <[ide-scsi]idescsi_pc_intr+86/250>
Trace; c0186288 <ide_set_handler+58/60>
Trace; c0107b00 <do_segment_not_present+30/a0>
Trace; d09834b0 <[ide-scsi]idescsi_pc_intr+0/250>
Trace; c01084aa <handle_IRQ_event+3a/70>
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


10 warnings issued.  Results may not be reliable.

--Boundary_(ID_EcwVPxPRzPfE2MNZKvS4NA)--

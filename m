Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129752AbRAKRaA>; Thu, 11 Jan 2001 12:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129798AbRAKR3t>; Thu, 11 Jan 2001 12:29:49 -0500
Received: from db0bm.automation.fh-aachen.de ([193.175.144.197]:48392 "EHLO
	db0bm.ampr.org") by vger.kernel.org with ESMTP id <S129752AbRAKR3c>;
	Thu, 11 Jan 2001 12:29:32 -0500
Date: Thu, 11 Jan 2001 18:29:27 +0100
From: f5ibh <f5ibh@db0bm.ampr.org>
Message-Id: <200101111729.SAA24053@db0bm.ampr.org>
To: linux-kernel@vger.kernel.org
Subject: Oops while loading ppa in 2.2.19-pre7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I got this non-fatal oops while loading the ppa module for my IOMEGA parallel
port ZIP drive.

included :
----------
- raw oops
- oops processed by ksymoops
- configuration


raw oops :
----------

ppa: Version 2.07 (for Linux 2.2.x)
ppa: Found device at ID 6, Attempting to use EPP 32 bit
ppa: Communication established with ID 6 using EPP 32 bit
Warning: kfree_skb passed an skb still on a list (from c8074fc1).
Oops: 0002
CPU:    0
EIP:    0010:[skb_recv_datagram+359/416]
EFLAGS: 00010046
eax: c781f2c0   ebx: 00000000   ecx: 00000246   edx: 00000000
esi: 000005dc   edi: c6fe1e84   ebp: c6e1a0c4   esp: c6fe1dcc
ds: 0018   es: 0018   ss: 0018
Process tnt (pid: 388, process nr: 29, stackpage=c6fe1000)
Stack: c6fe1e84 c6fe1f48 c7ffa040 c6fe1df0 00000000 00000000 00000000 c01a36a0
       20006d78 c8082b5b c6e1a080 00000000 00000000 c6fe1e20 c6e00ac0 000005dc
       c6fe1e84 c6fe1f48 00000000 c01a36a0 c6e1a080 34323730 63376666 c77d8e20
Call Trace: [twist_table.693+13984/14496] [unix:unix_socket_table+361083/47427333] [twist_table.693+13984/14496] [sock_recvmsg+65/184] [tcp_listen_poll+56/80] [sys_recvfrom+168/260] [free_pages+39/44]
        [free_wait+101/116] [do_select+487/512] [do_select+440/512] [sys_select+993/1176] [sys_socketcall+410/540] [system_call+52/56]
Code: 89 6a 04 89 55 00 c7 00 00 00 00 00 c7 40 04 00 00 00 00 c7
scsi0 : Iomega VPI0 (ppa) interface
scsi : 1 host.
Vendor: IOMEGA   Model: ZIP 100 Rev: L.01
Type:  Direct-Access ANSI SCSI revision: 02

ksymoops 2.3.7 on i586 2.2.19pre7.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.2.19pre7/ (default)
     -m /boot/System.map-2.2.19pre7 (specified)

Warning (compare_maps): ksyms_base symbol module_list_R__ver_module_list not found in System.map.  Ignoring ksyms_base entry
Oops: 0002
CPU:    0
EIP:    0010:[skb_recv_datagram+359/416]
EFLAGS: 00010046
eax: c781f2c0   ebx: 00000000   ecx: 00000246   edx: 00000000
esi: 000005dc   edi: c6fe1e84   ebp: c6e1a0c4   esp: c6fe1dcc
ds: 0018   es: 0018   ss: 0018
Process tnt (pid: 388, process nr: 29, stackpage=c6fe1000)
Stack: c6fe1e84 c6fe1f48 c7ffa040 c6fe1df0 00000000 00000000 00000000 c01a36a0 20006d78 c8082b5b c6e1a080 00000000 00000000 c6fe1e20 c6e00ac0 000005dc
       c6fe1e84 c6fe1f48 00000000 c01a36a0 c6e1a080 34323730 63376666 c77d8e20
Call Trace: [twist_table.693+13984/14496] [unix:unix_socket_table+361083/47427333] [twist_table.693+13984/14496] [sock_recvmsg+65/184] [tcp_listen_poll+56/80] [sys_recvfrom+168/260] [free_pages+39/44]
Code: 89 6a 04 89 55 00 c7 00 00 00 00 00 c7 40 04 00 00 00 00 c7
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   89 6a 04                  mov    %ebp,0x4(%edx)
Code;  00000003 Before first symbol
   3:   89 55 00                  mov    %edx,0x0(%ebp)
Code;  00000006 Before first symbol
   6:   c7 00 00 00 00 00         movl   $0x0,(%eax)
Code;  0000000c Before first symbol
   c:   c7 40 04 00 00 00 00      movl   $0x0,0x4(%eax)
Code;  00000013 Before first symbol
  13:   c7 00 00 00 00 00         movl   $0x0,(%eax)


1 warning issued.  Results may not be reliable.

configuration :
---------------
System is K6-2/500  128Mb running  2.2.19-pre7 + patch for usb-Config 
                                               + patches for ic2 and lm-sensors

					       
-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux debian-f5ibh 2.2.19pre7 #1 jeu jan 11 17:16:23 CET 2001 i586 unknown
Kernel modules         2.4.1
Gnu C                  2.95.2
Binutils               2.9.5.0.37
Linux C Library        2.1.3
Dynamic linker         ldd: version 1.9.11
Procps                 2.0.6
Mount                  2.10o
Net-tools              2.05
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded         sd_mod parport_pc ppa parport scsi_mod af_packet scc ax25 mousedev usb-ohci hid input autofs lockd sunrpc usbcore unix w83781d sensors i2c-core

------

Regards

		Jean-Luc
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

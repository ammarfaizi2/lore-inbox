Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282494AbRK2TWZ>; Thu, 29 Nov 2001 14:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280766AbRK2TWQ>; Thu, 29 Nov 2001 14:22:16 -0500
Received: from irwell.zetnet.co.uk ([194.247.47.48]:51132 "EHLO zetnet.co.uk")
	by vger.kernel.org with ESMTP id <S282400AbRK2TWD> convert rfc822-to-8bit;
	Thu, 29 Nov 2001 14:22:03 -0500
Content-Type: text/plain; charset=US-ASCII
From: Charles Baylis <cb-lkml@fish.zetnet.co.uk>
To: linux-kernel@vger.kernel.org
Subject: [OOPS] [2.4.16] comparing CD-RW with CD
Date: Thu, 29 Nov 2001 13:56:29 +0000
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E169Rg2-0001Mp-00@flat>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

I can reliably oops this machine by doing:
cmp /dev/scd0 /dev/hdb

The CD-RW is /dev/scd0 and is using ide-scsi.

This machine is a AMD K6-2 500, ALI chipset, 160MB RAM.
/dev/hda is an old Seagate 631MB drive
/dev/hdb is a DVD-ROM drive.
/dev/scd0 is /dev/hdc using ide-scsi, - a CD-RW drive
/dev/hdd is a really old IBM 343MB drive.

I had to transcribe the oops by hand as the machine locks. More information 
available on request. 

Regards,
Charlie

--------------------- Decoded Oops below
ksymoops 2.4.3 on i586 2.4.16.  Options used
     -V (default)
     -k /var/log/ksymoops/20011129115325.ksyms (specified)
     -l /var/log/ksymoops/20011129115325.modules (specified)
     -o /lib/modules/2.4.16/ (default)
     -m /usr/local/src/linux/System.map (specified)

ca8394d8
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<ca8394d8>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000051   ebx: c30af000   ecx: c02404d0   edx: 00000177
esi: c64400c0   edi: 01000000   ebp: c0240410   esp: c139bd6c
ds: 0018   es: 0018   ss: 0018
Process syslogd (pid: 156, stackpage=c139b000)
Stack: c0240410 c129f260 00000296 c02403d0 00000002 c0240451 c016f847 
c0240410
       c12849a0 04000010 0000000f c139bde8 ca839468 c0107d6c 0000000f 
c129f260
       c139bde8 000001e0 c821bae0 0000000f c139bde0 c0107ed2 0000000f 
c139bde8
Call Trace: [<c016f847>] [<ca839468>] [<c0108d6c>] [<c0109c48>]
   [<c0182b7e>] [<c0182bf7>] [<c0182d54>] [<c0184670>] [<c01b0f68>] 
[<c0180131>]
   [<c0180eb7>] [<c0111bf1>] [<c0128483>] [<c012849e>] [<c0138cab>] 
[<c0138fa8>]
   [<c0138fe1>] [<c0180f29>] [<c01815b5>] [<c0106b23>]
Code: ff 47 18 8b 85 c8 00 00 00 ff 70 04 6a 01 e8 e5 fd ff ff 31

>>EIP; ca8394d8 <[ide-scsi]idescsi_pc_intr+70/22c>   <=====
Trace; c016f846 <ide_intr+f6/14c>
Trace; ca839468 <[ide-scsi]idescsi_pc_intr+0/22c>
Trace; c0108d6c <handle_vm86_fault+290/75c>
Trace; c0109c48 <call_do_IRQ+6/e>
Trace; c0182b7e <skb_release_data+2/70>
Trace; c0182bf6 <kfree_skbmem+a/58>
Trace; c0182d54 <__kfree_skb+110/118>
Trace; c0184670 <skb_free_datagram+1c/20>
Trace; c01b0f68 <unix_dgram_recvmsg+f8/108>
Trace; c0180130 <sock_recvmsg+3c/bc>
Trace; c0180eb6 <sys_recvfrom+a2/fc>
Trace; c0111bf0 <schedule+2ac/2d4>
Trace; c0128482 <__free_pages+1a/1c>
Trace; c012849e <free_pages+1a/1c>
Trace; c0138caa <poll_freewait+3a/44>
Trace; c0138fa8 <do_select+1c4/1dc>

Trace; c0138fe0 <select_bits_free+8/10>
Trace; c0180f28 <sys_recv+18/20>
Trace; c01815b4 <sys_socketcall+144/1d4>
Trace; c0106b22 <system_call+32/40>
Code;  ca8394d8 <[ide-scsi]idescsi_pc_intr+70/22c>
00000000 <_EIP>:
Code;  ca8394d8 <[ide-scsi]idescsi_pc_intr+70/22c>   <=====
   0:   ff 47 18                  incl   0x18(%edi)   <=====
Code;  ca8394da <[ide-scsi]idescsi_pc_intr+72/22c>
   3:   8b 85 c8 00 00 00         mov    0xc8(%ebp),%eax
Code;  ca8394e0 <[ide-scsi]idescsi_pc_intr+78/22c>
   9:   ff 70 04                  pushl  0x4(%eax)
Code;  ca8394e4 <[ide-scsi]idescsi_pc_intr+7c/22c>
   c:   6a 01                     push   $0x1
Code;  ca8394e6 <[ide-scsi]idescsi_pc_intr+7e/22c>
   e:   e8 e5 fd ff ff            call   fffffdf8 <_EIP+0xfffffdf8> 
ca8392d0 <[ide-scsi]idescsi_end_request+b0/248>
Code;  ca8394ea <[ide-scsi]idescsi_pc_intr+82/22c>
  13:   31 00                     xor    %eax,(%eax)


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267940AbUI1VPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267940AbUI1VPc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 17:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267971AbUI1VPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 17:15:32 -0400
Received: from [81.3.11.18] ([81.3.11.18]:57531 "EHLO mail.ku-gbr.de")
	by vger.kernel.org with ESMTP id S267940AbUI1VLW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 17:11:22 -0400
Date: Tue, 28 Sep 2004 23:11:16 +0200
From: Konstantin Kletschke <lists@ku-gbr.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-rc2 Oops on IDE load
Message-ID: <20040928211116.GB7765@ku-gbr.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Score: 1.6
X-Spam-Report: Spam detection software, running on the system "kermit", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or block
	similar future email.  If you have any questions, see
	admin@mail.ku-gbr.de for details.
	Content preview:  Hi people! I wanted to try out 2.6.9-rc2 on my intel
	i865 Chipset Computer and realize, that it does hard freezes when IDE
	load occurs. For example an "emerge sync" (using gentoo on it) triggers
	the freeze reliable. [...] 
	Content analysis details:   (1.6 points, 10.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.23.246.12 listed in dnsbl.sorbs.net]
	1.6 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.23.246.12 listed in combined.njabl.org]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi people!

I wanted to try out 2.6.9-rc2 on my intel i865 Chipset Computer and
realize, that it does hard freezes when IDE load occurs. For example an
"emerge sync" (using gentoo on it) triggers the freeze reliable.

I don't know if the lspci output is useful, because it contains only
"Unknown Devices" don't know why, I am running 2.6.7 at the moment...

00:00.0 Host bridge: Intel Corp.: Unknown device 2560 (rev 02)
00:01.0 PCI bridge: Intel Corp.: Unknown device 2561 (rev 02)
00:1d.0 USB Controller: Intel Corp.: Unknown device 24c2 (rev 02)
00:1d.1 USB Controller: Intel Corp.: Unknown device 24c4 (rev 02)
00:1d.2 USB Controller: Intel Corp.: Unknown device 24c7 (rev 02)
00:1d.7 USB Controller: Intel Corp.: Unknown device 24cd (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA PCI Bridge (rev 82)
00:1f.0 ISA bridge: Intel Corp.: Unknown device 24c0 (rev 02)
00:1f.1 IDE interface: Intel Corp.: Unknown device 24cb (rev 02)
00:1f.3 SMBus: Intel Corp.: Unknown device 24c3 (rev 02)
01:00.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4Ti4400] (rev a2)
02:01.0 SCSI storage controller: Adaptec AHA-7850 (rev 03)
02:03.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev06)
02:04.0 Ethernet controller: Davicom Semiconductor, Inc. Ethernet 100/10MBit (rev 31)
02:05.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev07)
02:05.1 Input device controller: Creative Labs SB Live! MIDI/Game Port(rev 07)
02:09.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 HostController (rev 46)
02:0a.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev10)
02:0d.0 Ethernet controller: Intel Corp.: Unknown device 100e (rev 02)
02:0e.0 RAID bus controller: Promise Technology, Inc.: Unknown device3376 (rev 02)

The HDD is attached to the intel Controller.


ksymoops 2.4.9 on i686 2.6.7.  Options used
     -V (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.9-rc2-p4-konsti-0.1/ (specified)
     -m /boot/System.map-2.6.9-rc2-p4-konsti-0.1 (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c02ab414>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246   (2.6.9-rc2-p4-konsti-0.1)
eax: 00019d1f   ebx: eb244308   ecx: 00000002   edx: 00000000
esi: 00000003   edi: eb2440a4   ebp: c039be0c   esp: c039bdf4
ds: 007b   es: 007b   ss: 0068
Stack: 00000246 00019e1a 00000001 eb244308 00000000 88259a30 c039be50 c02abf99
       c039be50 c02aca12 c03669e0 c039be44 8825958c 00244308 00000004 00000000
       00000107 00000003 8825958c eb2440a4 00000003 eb244308 88259a30 c039be90
Call Trace:
 [<c0105952>]
 [<c0105ac1>]
 [<c0105d23>]
 [<c0117595>]
 [<c0105461>]
 [<c02abf99>]
 [<c02ad323>]
 [<c02afdfc>]
 [<c02b9cf0>]
 [<c02ba498>]
 [<c029df0a>]
 [<c029e2d2>]
 [<c0288439>]
 [<c0288509>]
 [<c02885f5>]
 [<c0125ff9>]
 [<c0108df9>]
 [<c0107c60>]
 [<c01053c4>]
 [<c010225f>]
 [<c0375757>]
 [<c010019f>]
 [<c0105952>]
 [<c0105ac1>]
 [<c0105d23>]
 [<c0117595>]
 [<c0105461>]
 [<c02abf99>]
 [<c02ad323>]
 [<c02afdfc>]
 [<c02b9cf0>]
 [<c02ba498>]
 [<c029df0a>]
 [<c029e2d2>]
 [<c0288439>]
 [<c0288509>]
 [<c02885f5>]
 [<c0125ff9>]
 [<c0108df9>]
 [<c0107c60>]
 [<c01053c4>]
 [<c010225f>]
 [<c0375757>]
 [<c010019f>]
 [<c0105952>]
 [<c0105ac1>]
 [<c0105d23>]
 [<c0117595>]
 [<c0105461>]
 [<c02abf99>]
 [<c02ad323>]
 [<c02afdfc>]
 [<c02b9cf0>]
 [<c02ba498>]
 [<c029df0a>]
 [<c029e2d2>]
 [<c0288439>]
 [<c0288509>]
 [<c02885f5>]
 [<c0125ff9>]
 [<c0108df9>]
 [<c0107c60>]
 [<c01053c4>]
 [<c010225f>]
 [<c0375757>]
 [<c010019f>]
Code: 5d c3 8b 92 cc 01 00 00 83 c2 01 e9 6c fe ff ff 8d 87 9c 00 00 00 8b 97 9c 00 00 00 39 c2 b8 00 00 00 00 0f 44 d0 a1 20 d5 31 c0 <2b> 42 50 3b 83 a8 00 00 00 77 bc e9 6a fe ff ff c7 45 f0 00 00


>>EIP; c02ab414 <tcp_time_to_recover+1ea/239>   <=====

>>ebx; eb244308 <pg0+2ae84308/3fc3e400>
>>edi; eb2440a4 <pg0+2ae840a4/3fc3e400>
>>ebp; c039be0c <softirq_stack+e0c/1000>
>>esp; c039bdf4 <softirq_stack+df4/1000>

Trace; c0105952 <show_stack+7a/90>
Trace; c0105ac1 <show_registers+140/1b8>
Trace; c0105d23 <die+151/2cd>
Trace; c0117595 <do_page_fault+2d7/5bc>
Trace; c0105461 <error_code+2d/38>
Trace; c02abf99 <tcp_fastretrans_alert+14c/6e7>
Trace; c02ad323 <tcp_ack+249/5b9>
Trace; c02afdfc <tcp_rcv_established+581/809>
Trace; c02b9cf0 <tcp_v4_do_rcv+ee/f0>
Trace; c02ba498 <tcp_v4_rcv+7a6/8e6>
Trace; c029df0a <ip_local_deliver+63/13a>
Trace; c029e2d2 <ip_rcv+2f1/40b>
Trace; c0288439 <netif_receive_skb+18a/1e1>
Trace; c0288509 <process_backlog+79/100>
Trace; c02885f5 <net_rx_action+65/e1>
Trace; c0125ff9 <__do_softirq+41/8b>
Trace; c0108df9 <do_softirq+46/55>
Trace; c0107c60 <do_IRQ+29f/3d9>
Trace; c01053c4 <common_interrupt+18/20>
Trace; c010225f <cpu_idle+2a/38>
Trace; c0375757 <start_kernel+1b6/222>
Trace; c010019f <L6+0/2>
Trace; c0105952 <show_stack+7a/90>
Trace; c0105ac1 <show_registers+140/1b8>
Trace; c0105d23 <die+151/2cd>
Trace; c0117595 <do_page_fault+2d7/5bc>
Trace; c0105461 <error_code+2d/38>
Trace; c02abf99 <tcp_fastretrans_alert+14c/6e7>
Trace; c02ad323 <tcp_ack+249/5b9>
Trace; c02afdfc <tcp_rcv_established+581/809>
Trace; c02b9cf0 <tcp_v4_do_rcv+ee/f0>
Trace; c02ba498 <tcp_v4_rcv+7a6/8e6>
Trace; c029df0a <ip_local_deliver+63/13a>
Trace; c029e2d2 <ip_rcv+2f1/40b>
Trace; c0288439 <netif_receive_skb+18a/1e1>
Trace; c0288509 <process_backlog+79/100>
Trace; c02885f5 <net_rx_action+65/e1>
Trace; c0125ff9 <__do_softirq+41/8b>
Trace; c0108df9 <do_softirq+46/55>
Trace; c0107c60 <do_IRQ+29f/3d9>
Trace; c01053c4 <common_interrupt+18/20>
Trace; c010225f <cpu_idle+2a/38>
Trace; c0375757 <start_kernel+1b6/222>
Trace; c010019f <L6+0/2>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c02ab3e9 <tcp_time_to_recover+1bf/239>
00000000 <_EIP>:
Code;  c02ab3e9 <tcp_time_to_recover+1bf/239>
   0:   5d                        pop    %ebp
Code;  c02ab3ea <tcp_time_to_recover+1c0/239>
   1:   c3                        ret
Code;  c02ab3eb <tcp_time_to_recover+1c1/239>
   2:   8b 92 cc 01 00 00         mov    0x1cc(%edx),%edx
Code;  c02ab3f1 <tcp_time_to_recover+1c7/239>
   8:   83 c2 01                  add    $0x1,%edx
Code;  c02ab3f4 <tcp_time_to_recover+1ca/239>
   b:   e9 6c fe ff ff            jmp    fffffe7c <_EIP+0xfffffe7c>
Code;  c02ab3f9 <tcp_time_to_recover+1cf/239>
  10:   8d 87 9c 00 00 00         lea    0x9c(%edi),%eax
Code;  c02ab3ff <tcp_time_to_recover+1d5/239>
  16:   8b 97 9c 00 00 00         mov    0x9c(%edi),%edx
Code;  c02ab405 <tcp_time_to_recover+1db/239>
  1c:   39 c2                     cmp    %eax,%edx
Code;  c02ab407 <tcp_time_to_recover+1dd/239>
  1e:   b8 00 00 00 00            mov    $0x0,%eax
Code;  c02ab40c <tcp_time_to_recover+1e2/239>
  23:   0f 44 d0                  cmove  %eax,%edx
Code;  c02ab40f <tcp_time_to_recover+1e5/239>
  26:   a1 20 d5 31 c0            mov    0xc031d520,%eax

This decode from eip onwards should be reliable

Code;  c02ab414 <tcp_time_to_recover+1ea/239>
00000000 <_EIP>:
Code;  c02ab414 <tcp_time_to_recover+1ea/239>   <=====
   0:   2b 42 50                  sub    0x50(%edx),%eax   <=====
Code;  c02ab417 <tcp_time_to_recover+1ed/239>
   3:   3b 83 a8 00 00 00         cmp    0xa8(%ebx),%eax
Code;  c02ab41d <tcp_time_to_recover+1f3/239>
   9:   77 bc                     ja     ffffffc7 <_EIP+0xffffffc7>
Code;  c02ab41f <tcp_time_to_recover+1f5/239>
   b:   e9 6a fe ff ff            jmp    fffffe7a <_EIP+0xfffffe7a>
Code;  c02ab424 <tcp_time_to_recover+1fa/239>
  10:   c7                        .byte 0xc7
Code;  c02ab425 <tcp_time_to_recover+1fb/239>
  11:   45                        inc    %ebp
Code;  c02ab426 <tcp_time_to_recover+1fc/239>
  12:   f0 00 00                  lock add %al,(%eax)


1 error issued.  Results may not be reliable.

Regards, Konsti


-- 
GPG KeyID EF62FCEF
Fingerprint: 13C9 B16B 9844 EC15 CC2E  A080 1E69 3FDA EF62 FCEF

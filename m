Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264903AbTBAQF5>; Sat, 1 Feb 2003 11:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264907AbTBAQF5>; Sat, 1 Feb 2003 11:05:57 -0500
Received: from ool-43535071.dyn.optonline.net ([67.83.80.113]:21379 "EHLO
	wisdom.bubble.org") by vger.kernel.org with ESMTP
	id <S264903AbTBAQFy>; Sat, 1 Feb 2003 11:05:54 -0500
From: jeff@wisdom.bubble.org
Message-Id: <200302011615.h11GFKF06248@wisdom.bubble.org>
Subject: 2.4.21-pre4 - oops in ide-scsi.c:512
To: linux-kernel@vger.kernel.org
Date: Sat, 1 Feb 2003 11:15:20 -0500 (EST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

here is the oops meeesage from 2.4.21-pre4, the ksymoops output...


 scsi : aborting command due to timeout : pid 38368, scsi0, channel 0, id 1, lun 0 Request Sense 00 00 00 40 00
hdd: irq timeout: status=0xfe { Busy }
hdd: ATAPI reset complete
hdd: irq timeout: status=0x80 { Busy }
hdd: ATAPI reset complete
hdd: irq timeout: status=0x80 { Busy }
scsi0 channel 0 : resetting for second half of retries.
SCSI bus is being reset for host 0 channel 0.
kernel BUG at ide-scsi.c:512!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0209f65>]    Not tainted
EFLAGS: 00010286
eax: c01ee8f0   ebx: c0345e58   ecx: 0cd9f24c   edx: 00000172
esi: c4b5c100   edi: cf63dd80   ebp: c8e42e80   esp: c62bfebc
ds: 0018   es: 0018   ss: 0018
Process setiathome (pid: 1018, stackpage=c62bf000)
Stack: 00000172 c0345e58 00000008 00000080 00000003 c0345e58 c0345e58 00000040
       00000000 c01f6e41 c0345e58 c4b5c100 00000000 00000088 00000003 00345c6c
       00000000 00000082 c0345e58 c12cd680 c8e42e80 c0345c6c c01f6fbb c0345e58
Call Trace:    [<c01f6e41>] [<c01f6fbb>] [<c01f7273>] [<c01f7190>] [<c0121c3b>]
  [<c011dfd2>] [<c011dee6>] [<c011dd25>] [<c0108b8e>] [<c010b1f8>]

Code: 0f 0b 00 02 ba ba 29 c0 8b 56 38 a1 a4 7b 32 c0 89 d1 29 c1
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing


]$ sh scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux wisdom2 2.4.21-pre4 #12 Fri Jan 31 20:00:02 EST 2003 i686 i686 i386 GNU/Linux

Gnu C                  3.2
Gnu make               3.79.1
util-linux             2.11r
mount                  2.11r
modutils               2.4.18
e2fsprogs              1.27
jfsutils               1.0.17
reiserfsprogs          3.6.2
pcmcia-cs              3.1.31
Linux C Library        2.2.93
Dynamic linker (ldd)   2.2.93
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.12
Modules Loaded         autofs e100 af_packet microcode ehci-hcd usbcore rtc unix

Ksymoops:

Reading Oops report from the terminal
invalid operand: 0000
CPU:  invalid operand: 0000
  0
EIP:  CPU:    0
  0010:[<c0209f65>]    Not tainted
EFLAGS:EIP:    0010:[<c0209f65>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
 00010286
eax: cEFLAGS: 00010286
01ee8f0   ebx: c0345e58   ecx: 0cd9f24c   edx: 00000172
eax: c01ee8f0   ebx: c0345e58   ecx: 0cd9f24c   edx: 00000172
esi: c4b5c100   edi: cf63dd80   ebp: c8e42e80   esp: c62bfebc
dsesi: c4b5c100   edi: cf63dd80   ebp: c8e42e80   esp: c62bfebc
: 0018   es: 0018   ss: 0018
Prods: 0018   es: 0018   ss: 0018
cess setiathome (pid: 1018, stackpage=c62bf000)
Process setiathome (pid: 1018, stackpage=c62bf000)
Stack: 00000172 c0345e58 00000008 00000080 00000003 c0345e58 c0345e58 00000040
 Stack: 00000172 c0345e58 00000008 00000080 00000003 c0345e58 c0345e58 00000040
      00000000 c01f6e41 c0345e58 c4b5c100 00000000 00000088 00000003 00345c6c
         00000000 c01f6e41 c0345e58 c4b5c100 00000000 00000088 00000003 00345c6c
     00000000 00000082 c0345e58 c12cd680 c8e42e80 c0345c6c c01f6fbb c0345e58
Cal       00000000 00000082 c0345e58 c12cd680 c8e42e80 c0345c6c c01f6fbb c0345e58
l Trace:    [<c01f6e41>] [<c01f6fbb>] [<c01f7273>] [<c01f7190>] [<c0121c3b>]
  [Call Trace:    [<c01f6e41>] [<c01f6fbb>] [<c01f7273>] [<c01f7190>] [<c0121c3b>]
<c011dfd2>] [<c011dee6>] [<c011dd25>] [<c0108b8e>] [<c010b1f8>]
  [<c011dfd2>] [<c011dee6>] [<c011dd25>] [<c0108b8e>] [<c010b1f8>]

Code: 0f 0b 00 02 ba ba 29 c0 8b 56 38 a1 a4 7b 32 c0 89 d1 29 c1
Code: 0f 0b 00 02 ba ba 29 c0 8b 56 38 a1 a4 7b 32 c0 89 d1 29 c1


>>EIP; c0209f65 <idescsi_transfer_pc+a5/140>   <=====

>>eax; c01ee8f0 <atapi_reset_pollfunc+0/120>
>>ebx; c0345e58 <ide_hwifs+638/2af8>
>>ecx; 0cd9f24c Before first symbol
>>esi; c4b5c100 <_end+4810d3c/fd46c9c>
>>edi; cf63dd80 <_end+f2f29bc/fd46c9c>
>>ebp; c8e42e80 <_end+8af7abc/fd46c9c>
>>esp; c62bfebc <_end+5f74af8/fd46c9c>

Trace; c01f6e41 <start_request+1c1/240>
Trace; c01f6fbb <ide_do_request+ab/1a0>
Trace; c01f7273 <ide_timer_expiry+e3/1b0>
Trace; c01f7190 <ide_timer_expiry+0/1b0>
Trace; c0121c3b <run_timer_list+10b/170>
Trace; c011dfd2 <bh_action+22/40>
Trace; c011dee6 <tasklet_hi_action+46/70>
Trace; c011dd25 <do_softirq+95/a0>
Trace; c0108b8e <do_IRQ+9e/a0>
Trace; c010b1f8 <call_do_IRQ+5/d>

Code;  c0209f65 <idescsi_transfer_pc+a5/140>
00000000 <_EIP>:
Code;  c0209f65 <idescsi_transfer_pc+a5/140>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0209f67 <idescsi_transfer_pc+a7/140>
   2:   00 02                     add    %al,(%edx)
Code;  c0209f69 <idescsi_transfer_pc+a9/140>
   4:   ba ba 29 c0 8b            mov    $0x8bc029ba,%edx
Code;  c0209f6e <idescsi_transfer_pc+ae/140>
   9:   56                        push   %esi
Code;  c0209f6f <idescsi_transfer_pc+af/140>
   a:   38 a1 a4 7b 32 c0         cmp    %ah,0xc0327ba4(%ecx)
Code;  c0209f75 <idescsi_transfer_pc+b5/140>
  10:   89 d1                     mov    %edx,%ecx
Code;  c0209f77 <idescsi_transfer_pc+b7/140>
  12:   29 c1                     sub    %eax,%ecx


-- 
.Sig??? you want a stinkin' .Sig???

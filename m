Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbUANQUX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 11:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261965AbUANQUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 11:20:23 -0500
Received: from internal-bristol34.naxs.com ([216.98.66.34]:37401 "EHLO
	mail.electro-mechanical.com") by vger.kernel.org with ESMTP
	id S261929AbUANQUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 11:20:04 -0500
Date: Wed, 14 Jan 2004 11:20:20 -0500
From: William Thompson <wt@electro-mechanical.com>
To: linux-kernel@vger.kernel.org
Subject: oops unmounting a jaz disk 2.4.23
Message-ID: <20040114162020.GB16799@electro-mechanical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel is stock 2.4.23 (no extra patches).  Jaz disk is on an aha2906
controller (controller 1) as id6.  There is also an aha2940u controller
(controller 0).  Machine is a dual pIII 1.0ghz 1024mb ram.  Kernel was
compiled for 4GB high memory.

Keep me in the CC.  I'm not subscribed.

Oops:
ksymoops 2.4.5 on i686 2.4.23.  Options used
     -v /usr/src/linux/potato/2.4.23/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.23/ (default)
     -m /boot/System.map-2.4.23 (default)

Reading Oops report from the terminal
kernel BUG at ll_rw_blk.c:1018!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01baa22>]    Not tainted
EFLAGS: 00010246
eax: 00000080   ebx: 00000001   ecx: 00000200   edx: e6a29ae0
esi: e6a29ae0   edi: 00000001   ebp: 00000000   esp: cf70bcdc
ds: 0018   es: 0018   ss: 0018
Process umount (pid: 2041, stackpage=cf70b000)
Stack: c01d030c f7ebe078 00000000 00000014 f7ebe08c 00000007 f7ec2000
c02e6d50 
       00000200 00000000 00000000 f78ef448 00000000 00000008 00001040
c01d0d78 
       00000810 e6a29ae0 00000008 00000001 c01bb1d4 f78ef418 00000001
e6a29ae0 
Call Trace:    [<c01d030c>] [<c01d0d78>] [<c01bb1d4>] [<c01bb282>]
[<c0144556>]
  [<c01bb438>] [<c017decd>] [<c017be21>] [<c017bc4f>] [<c01debb4>]
[<c01e3627>]
  [<c0119296>] [<c017e321>] [<c01748b9>] [<c01488bb>] [<c015cdaf>]
[<c015ce15>]
  [<c01076df>]

Code: 0f 0b fa 03 59 b8 24 c0 8b 0d b0 af 2c c0 8b 42 38 29 c8 c1 
kernel BUG at ll_rw_blk.c:1018!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01baa22>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000080   ebx: 00000001   ecx: 00000200   edx: e6a29ae0
esi: e6a29ae0   edi: 00000001   ebp: 00000000   esp: cf70bcdc
ds: 0018   es: 0018   ss: 0018
Process umount (pid: 2041, stackpage=cf70b000)
Stack: c01d030c f7ebe078 00000000 00000014 f7ebe08c 00000007 f7ec2000
c02e6d50 
       00000200 00000000 00000000 f78ef448 00000000 00000008 00001040
c01d0d78 
       00000810 e6a29ae0 00000008 00000001 c01bb1d4 f78ef418 00000001
e6a29ae0 
Call Trace:    [<c01d030c>] [<c01d0d78>] [<c01bb1d4>] [<c01bb282>]
[<c0144556>]
  [<c01bb438>] [<c017decd>] [<c017be21>] [<c017bc4f>] [<c01debb4>]
[<c01e3627>]
  [<c0119296>] [<c017e321>] [<c01748b9>] [<c01488bb>] [<c015cdaf>]
[<c015ce15>]
  [<c01076df>]
Code: 0f 0b fa 03 59 b8 24 c0 8b 0d b0 af 2c c0 8b 42 38 29 c8 c1 


>>EIP; c01baa22 <__make_request+a2/770>   <=====

>>edx; e6a29ae0 <_end+2673c808/38512d88>
>>esi; e6a29ae0 <_end+2673c808/38512d88>
>>esp; cf70bcdc <_end+f41ea04/38512d88>

Trace; c01d030c <ide_build_sglist+9c/210>
Trace; c01d0d78 <__ide_dma_begin+38/50>
Trace; c01bb1d4 <generic_make_request+e4/140>
Trace; c01bb282 <submit_bh+52/100>
Trace; c0144556 <__refile_buffer+56/70>
Trace; c01bb438 <ll_rw_block+108/1b0>
Trace; c017decd <journal_update_superblock+5d/a0>
Trace; c017be21 <cleanup_journal_tail+a1/120>
Trace; c017bc4f <log_do_checkpoint+1f/150>
Trace; c01debb4 <__kfree_skb+104/170>
Trace; c01e3627 <net_tx_action+57/130>
Trace; c0119296 <schedule+2c6/520>
Trace; c017e321 <journal_destroy+1b1/1d0>
Trace; c01748b9 <ext3_put_super+29/1c0>
Trace; c01488bb <kill_super+12b/160>
Trace; c015cdaf <sys_umount+3f/90>
Trace; c015ce15 <sys_oldumount+15/20>
Trace; c01076df <system_call+33/38>

Code;  c01baa22 <__make_request+a2/770>
00000000 <_EIP>:
Code;  c01baa22 <__make_request+a2/770>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01baa24 <__make_request+a4/770>
   2:   fa                        cli    
Code;  c01baa25 <__make_request+a5/770>
   3:   03 59 b8                  add    0xffffffb8(%ecx),%ebx
Code;  c01baa28 <__make_request+a8/770>
   6:   24 c0                     and    $0xc0,%al
Code;  c01baa2a <__make_request+aa/770>
   8:   8b 0d b0 af 2c c0         mov    0xc02cafb0,%ecx
Code;  c01baa30 <__make_request+b0/770>
   e:   8b 42 38                  mov    0x38(%edx),%eax
Code;  c01baa33 <__make_request+b3/770>
  11:   29 c8                     sub    %ecx,%eax
Code;  c01baa35 <__make_request+b5/770>
  13:   c1 00 00                  roll   $0x0,(%eax)

Modules:
ext2                   37248   0 (autoclean)
nls_iso8859-1           2844   0 (autoclean)
isofs                  18860   0 (autoclean)
loop                   10168   0 (autoclean)
floppy                 52540   0 (autoclean)
nfs                    74872   2 (autoclean)
lockd                  51664   1 (autoclean) [nfs]
sunrpc                 73152   1 (autoclean) [nfs lockd]
tdfx                   35288   1
agpgart                14740   0 (autoclean) (unused)
parport_pc             24008   1 (autoclean)
lp                      7264   0 (autoclean)
parport                26504   1 (autoclean) [parport_pc lp]
mct_u232                5784   0 (unused)
usbserial              19740   0 [mct_u232]
mousedev                4472   1
hid                    21828   0 (unused)
usbmouse                2300   0 (unused)
input                   3424   0 [mousedev hid usbmouse]
tun                     4512   3 (autoclean)
iptable_nat            16902   1 (autoclean)
ip_conntrack           21760   1 (autoclean) [iptable_nat]
iptable_filter          1740   0 (autoclean) (unused)
ip_tables              12992   4 [iptable_nat iptable_filter]
tulip                  42208   1 (autoclean)
crc32                   2880   0 (autoclean) [tulip]
eepro100               20148   1 (autoclean)
mii                     2432   0 (autoclean) [eepro100]
uhci                   27196   0 (unused)
usbcore                64716   1 [mct_u232 usbserial hid usbmouse uhci]
es1371                 29996   2 (autoclean)
ac97_codec             13656   0 (autoclean) [es1371]
soundcore               3844   4 (autoclean) [es1371]
serial                 49252   0 (autoclean)
sd_mod                 11276   6 (autoclean)
ide-scsi               10480   0 (autoclean)
aic7xxx               153200   3 (autoclean)
scsi_mod               59124   3 (autoclean) [sd_mod ide-scsi aic7xxx]
raid0                   3240   1 (autoclean)
md                     46656   2 (autoclean) [raid0]

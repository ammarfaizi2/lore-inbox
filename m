Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbUL2RXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbUL2RXl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 12:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbUL2RXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 12:23:41 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:65152 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S261369AbUL2RXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 12:23:38 -0500
Date: Wed, 29 Dec 2004 18:23:37 +0100 (CET)
From: Folkert van Heusden <folkert@vanheusden.com>
X-X-Sender: <folkert@muur.intranet.vanheusden.com>
To: <linux-kernel@vger.kernel.org>
Subject: [2.6.9] kernel BUG at mm/rmap.c:474!
Message-ID: <Pine.LNX.4.33.0412291823230.777-100000@muur.intranet.vanheusden.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This error came up on my 2.6.9 machine.
896MB RAM, P-III 1GHz
applied patches: exec-shield and driver for pwc (philibs webcams)
Please let me know if you need more info.
config: http://keetweej.vanheusden.com/~folkert/config

kernel BUG at mm/rmap.c:474!
invalid operand: 0000 [#2]
Modules linked in: bttv video_buf i2c_algo_bit v4l2_common btcx_risc police
sch_ingress cls_u32 sch_sfq sch_cbq ipt_state ipt_REJECT ipt_MASQUERADE
ipt_TOS iptable_mangle iptable_filter bsd_comp audio pwc videodev
ip6table_filter ip6_tables via686a eeprom i2c_sensor i2c_isa i2c_core usbhid
soundcore uhci_hcd ide_cd cdrom button processor microcode nfsd exportfs
lockd sunrpc md5 ipv6 rtl8150 usbcore 3c59x iptable_nat ip_conntrack
ip_tables ppp_deflate zlib_deflate zlib_inflate ppp_async crc_ccitt
ppp_generic slip slhc rtc rd
CPU:    0
EIP:    0060:[<c013d886>]    Not tainted VLI
EFLAGS: 00010286   (2.6.9-exec-shield-pwc)
EIP is at page_remove_rmap+0x26/0x40
eax: ffffffff   ebx: 000a7000   ecx: c1068480   edx: c1068480
esi: cb44f3b8   edi: c1068480   ebp: 000ed000   esp: cbecbeb8
ds: 007b   es: 007b   ss: 0068
Process check_snmp_stor (pid: 28715, threadinfo=cbeca000 task=f6bb5020)
Stack: c0137bd6 c03801c0 cbecbee0 00000092 00000001 03424067 08447000
c038006c
       08847000 e12f4088 08534000 c038006c c0137d2b 000ed000 00000000
f7fc2400
       eb52476c 08447000 e12f4088 08534000 c038006c c0137d8d 000ed000
00000000
Call Trace:
 [<c0137bd6>] zap_pte_range+0x136/0x240
 [<c0137d2b>] zap_pmd_range+0x4b/0x70
 [<c0137d8d>] unmap_page_range+0x3d/0x70
 [<c0137ebe>] unmap_vmas+0xfe/0x1b0
 [<c013be49>] exit_mmap+0x69/0x130
 [<c0111f80>] mmput+0x40/0x70
 [<c01158f2>] do_exit+0x122/0x320
 [<c0115b72>] do_group_exit+0x32/0x70
 [<c0103e63>] syscall_call+0x7/0xb
Code: 90 8d 74 26 00 89 c2 8b 00 f6 c4 08 75 27 83 42 08 ff 0f 98 c0 84 c0
74 11 8b 42 08 40 78 0c 9c 58 fa ff 0d 90 3e 39 c0 50 9d c3 <0f> 0b da 01 7b
58 2a c0 eb ea 0f 0b d7 01 7b 58 2a c0 eb cf 8d


Folkert van Heusden

Op zoek naar een IT of Finance baan? Mail me voor de mogelijkheden!
+------------------------------------------------------------------+
|UNIX admin? Then give MultiTail (http://vanheusden.com/multitail/)|
|a try, it brings monitoring logfiles to a different level! See    |
|http://vanheusden.com/multitail/features.html for a feature list. |
+------------------------------------------= www.unixsoftware.nl =-+



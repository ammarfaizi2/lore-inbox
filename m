Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbTFZPPV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 11:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbTFZPPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 11:15:21 -0400
Received: from ip-86-245.evc.net ([212.95.86.245]:24705 "EHLO hal9003.1g6.biz")
	by vger.kernel.org with ESMTP id S261874AbTFZPPJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 11:15:09 -0400
From: Nicolas <linux@1g6.biz>
To: linux-kernel@vger.kernel.org
Subject: slab oops, no more than 5 days of uptime
Date: Thu, 26 Jun 2003 17:29:31 +0200
User-Agent: KMail/1.5
References: <20030610164156.46888.qmail@web80110.mail.yahoo.com> <3EE60F26.90409@rackable.com>
In-Reply-To: <3EE60F26.90409@rackable.com>
Organization: 1G6
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306261729.31119.linux@1g6.biz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I have never more than 5 days of uptime,
since I am trying 2.5.x branch (since 2.5.66-67 can't remember),
Always slab oops,
I can send .config, or whatever needed if you
ask.

Regards.

Nicolas.


Module                  Size  Used by
sr_mod                 12192  0
floppy                 53908  0
lp                      8672  0
sis900                 15236  0
crc32                   4096  1 sis900
e100                   54532  0
ide_scsi               12544  0
pktcdvd                24512  0
softdog                 4100  1
sg                     28172  0
scsi_mod               94236  3 sr_mod,ide_scsi,sg
i2c_sis96x              3968  0
ide_cd                 36992  0
cdrom                  32288  3 sr_mod,pktcdvd,ide_cd
af_key                 25224  0
ov511                  88348  0
button                  4884  0
ac                      3720  0
thermal                11272  0
fan                     3080  0
processor              11672  1 thermal
usblp                  11264  0
nfsd                   88752  0
exportfs                4864  1 nfsd
ehci_hcd               34176  0
ohci_hcd               30592  0
usbcore                98516  6 ov511,usblp,ehci_hcd,ohci_hcd
udf                    91396  0
parport_pc             22808  1
parport                35008  2 lp,parport_pc
i2c_dev                 7808  0
ipt_state               1536  3
ipt_ULOG                5512  0
ipt_LOG                 4736  7
iptable_filter          2176  1
iptable_mangle          2176  0
ipt_MASQUERADE          3072  1
iptable_nat            18964  2 ipt_MASQUERADE
ip_conntrack           23956  3 ipt_state,ipt_MASQUERADE,iptable_nat
ip_tables              13952  7 
ipt_state,ipt_ULOG,ipt_LOG,iptable_filter,iptable_mangle,ipt_MASQUERADE,iptable_nat
loop                   12680  6
isofs                  30136  3
tuner                  14340  0
saa7134                82060  0
video_buf              16384  1 saa7134
v4l1_compat            13312  1 saa7134
i2c_core               19588  4 i2c_sis96x,i2c_dev,tuner,saa7134
v4l2_common             3968  1 saa7134
videodev                8448  2 ov511,saa7134
i810_audio             25216  0
ac97_codec             13440  1 i810_audio
ohci1394               33280  0
ieee1394               66444  1 ohci1394
ntfs                   83984  1
af_packet              11656  4




Jun 25 16:05:32 hal9003 postfix/master[1967]: warning: process 
/usr/lib/postfix/smtpd pid 6163 killed by signal 11
Jun 25 16:05:32 hal9003 postfix/master[1967]: warning: /usr/lib/postfix/smtpd: 
bad command startup -- throttling
Jun 25 16:05:32 hal9003 kernel: ------------[ cut here ]------------
Jun 25 16:05:32 hal9003 kernel: kernel BUG at mm/slab.c:1622!
Jun 25 16:05:32 hal9003 kernel: invalid operand: 0000 [#1]
Jun 25 16:05:32 hal9003 kernel: CPU:    0
Jun 25 16:05:32 hal9003 kernel: EIP:    0060:[cache_alloc_refill+617/697]    
Not tainted
Jun 25 16:05:32 hal9003 kernel: EIP:    0060:[<c01395ba>]    Not tainted
Jun 25 16:05:32 hal9003 kernel: EFLAGS: 00010002
Jun 25 16:05:32 hal9003 kernel: EIP is at cache_alloc_refill+0x269/0x2b9
Jun 25 16:05:32 hal9003 kernel: eax: 20666f20   ebx: f7ffdc60   ecx: c8772080   
edx: 0000000a
Jun 25 16:05:32 hal9003 kernel: esi: 0000000b   edi: c8772098   ebp: f5337eb4   
esp: f5337e88
Jun 25 16:05:32 hal9003 kernel: ds: 007b   es: 007b   ss: 0068
Jun 25 16:05:32 hal9003 kernel: Process smtpd (pid: 6163, threadinfo=f5336000 
task=deec8180)
Jun 25 16:05:32 hal9003 kernel: Stack: 40353000 00000000 c02e09b8 f7fe3e30 
f7ffdc6c f7ffdc74 f7fe3e20 0000000c
Jun 25 16:05:32 hal9003 kernel:        00000001 f7ffdc60 00000246 f5337edc 
c0139a1b f7ffdc60 000000d0 ed862c9c
Jun 25 16:05:32 hal9003 kernel:        d3f49400 40353380 00000001 f7ff549c 
c02f5788 f5337efc c0235efe f7ffdc60
Jun 25 16:05:32 hal9003 kernel: Call Trace:
Jun 25 16:05:32 hal9003 kernel:  [kmem_cache_alloc+317/324] 
kmem_cache_alloc+0x13d/0x144
Jun 25 16:05:32 hal9003 kernel:  [<c0139a1b>] kmem_cache_alloc+0x13d/0x144
Jun 25 16:05:32 hal9003 kernel:  [sock_alloc_inode+27/96] 
sock_alloc_inode+0x1b/0x60
Jun 25 16:05:32 hal9003 kernel:  [<c0235efe>] sock_alloc_inode+0x1b/0x60
Jun 25 16:05:32 hal9003 kernel:  [alloc_inode+30/330] alloc_inode+0x1e/0x14a
Jun 25 16:05:32 hal9003 kernel:  [<c01603e2>] alloc_inode+0x1e/0x14a
Jun 25 16:05:32 hal9003 kernel:  [do_page_fault+329/1149] 
do_page_fault+0x149/0x47d
Jun 25 16:05:32 hal9003 kernel:  [<c01185b9>] do_page_fault+0x149/0x47d
Jun 25 16:05:32 hal9003 kernel:  [new_inode+26/98] new_inode+0x1a/0x62
Jun 25 16:05:32 hal9003 kernel:  [<c0160cbb>] new_inode+0x1a/0x62
Jun 25 16:05:32 hal9003 kernel:  [sock_alloc+22/86] sock_alloc+0x16/0x56
Jun 25 16:05:32 hal9003 kernel:  [<c02361bd>] sock_alloc+0x16/0x56
Jun 25 16:05:32 hal9003 kernel:  [sock_create+101/444] sock_create+0x65/0x1bc
Jun 25 16:05:32 hal9003 kernel:  [<c0236d63>] sock_create+0x65/0x1bc
Jun 25 16:05:32 hal9003 kernel:  [sys_socket+41/86] sys_socket+0x29/0x56
Jun 25 16:05:32 hal9003 kernel:  [<c0236ee3>] sys_socket+0x29/0x56
Jun 25 16:05:32 hal9003 kernel:  [sys_socketcall+114/610] 
sys_socketcall+0x72/0x262
Jun 25 16:05:32 hal9003 kernel:  [<c0237d97>] sys_socketcall+0x72/0x262
Jun 25 16:05:32 hal9003 kernel:  [sys_munmap+67/97] sys_munmap+0x43/0x61
Jun 25 16:05:32 hal9003 kernel:  [<c0141b3a>] sys_munmap+0x43/0x61
Jun 25 16:05:32 hal9003 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jun 25 16:05:32 hal9003 kernel:  [<c0108fc7>] syscall_call+0x7/0xb
Jun 25 16:05:32 hal9003 kernel:
Jun 25 16:05:32 hal9003 kernel: Code: 0f 0b 56 06 65 c8 2a c0 e9 ca fe ff ff 
8b 45 08 8b 50 3c e9
Jun 25 16:05:49 hal9003 kernel:  ------------[ cut here ]------------
Jun 25 16:05:49 hal9003 kernel: kernel BUG at mm/slab.c:1622!
Jun 25 16:05:49 hal9003 kernel: invalid operand: 0000 [#2]
Jun 25 16:05:49 hal9003 kernel: CPU:    0
Jun 25 16:05:49 hal9003 kernel: EIP:    0060:[cache_alloc_refill+617/697]    
Not tainted
Jun 25 16:05:49 hal9003 kernel: EIP:    0060:[<c01395ba>]    Not tainted
Jun 25 16:05:49 hal9003 kernel: EFLAGS: 00010002
Jun 25 16:05:49 hal9003 kernel: EIP is at cache_alloc_refill+0x269/0x2b9
Jun 25 16:05:49 hal9003 kernel: eax: 20666f20   ebx: f7ffdc60   ecx: c8772080   
edx: 0000000a
Jun 25 16:05:49 hal9003 kernel: esi: 0000000b   edi: c8772098   ebp: f5337eb4   
esp: f5337e88
Jun 25 16:05:49 hal9003 kernel: ds: 007b   es: 007b   ss: 0068
Jun 25 16:05:49 hal9003 kernel: Process ping (pid: 6164, threadinfo=f5336000 
task=dd2ed380)
Jun 25 16:05:49 hal9003 kernel: Stack: 40115000 00000000 00000001 f5337ed4 
f7ffdc6c f7ffdc74 f7fe3e20 00000010
Jun 25 16:05:49 hal9003 kernel:        00000002 f7ffdc60 00000246 f5337edc 
c0139a1b f7ffdc60 000000d0 e830b894
Jun 25 16:05:49 hal9003 kernel:        eeefe400 40115380 00000002 f7ff549c 
c02f4228 f5337efc c0235efe f7ffdc60
Jun 25 16:05:49 hal9003 kernel: Call Trace:
Jun 25 16:05:49 hal9003 kernel:  [kmem_cache_alloc+317/324] 
kmem_cache_alloc+0x13d/0x144
Jun 25 16:05:49 hal9003 kernel:  [<c0139a1b>] kmem_cache_alloc+0x13d/0x144
Jun 25 16:05:49 hal9003 kernel:  [sock_alloc_inode+27/96] 
sock_alloc_inode+0x1b/0x60
Jun 25 16:05:49 hal9003 kernel:  [<c0235efe>] sock_alloc_inode+0x1b/0x60
Jun 25 16:05:49 hal9003 kernel:  [alloc_inode+30/330] alloc_inode+0x1e/0x14a
Jun 25 16:05:49 hal9003 kernel:  [<c01603e2>] alloc_inode+0x1e/0x14a
Jun 25 16:05:49 hal9003 kernel:  [do_page_fault+329/1149] 
do_page_fault+0x149/0x47d
Jun 25 16:05:49 hal9003 kernel:  [<c01185b9>] do_page_fault+0x149/0x47d
Jun 25 16:05:49 hal9003 kernel:  [new_inode+26/98] new_inode+0x1a/0x62
Jun 25 16:05:49 hal9003 kernel:  [<c0160cbb>] new_inode+0x1a/0x62
Jun 25 16:05:49 hal9003 kernel:  [sock_alloc+22/86] sock_alloc+0x16/0x56
Jun 25 16:05:49 hal9003 kernel:  [<c02361bd>] sock_alloc+0x16/0x56
Jun 25 16:05:49 hal9003 kernel:  [sock_create+101/444] sock_create+0x65/0x1bc
Jun 25 16:05:49 hal9003 kernel:  [<c0236d63>] sock_create+0x65/0x1bc
Jun 25 16:05:49 hal9003 kernel:  [sys_socket+41/86] sys_socket+0x29/0x56
Jun 25 16:05:49 hal9003 kernel:  [<c0236ee3>] sys_socket+0x29/0x56
Jun 25 16:05:49 hal9003 kernel:  [sys_socketcall+114/610] 
sys_socketcall+0x72/0x262
Jun 25 16:05:49 hal9003 kernel:  [<c0237d97>] sys_socketcall+0x72/0x262
Jun 25 16:05:49 hal9003 kernel:  [sys_munmap+67/97] sys_munmap+0x43/0x61
Jun 25 16:05:49 hal9003 kernel:  [<c0141b3a>] sys_munmap+0x43/0x61
Jun 25 16:05:49 hal9003 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jun 25 16:05:49 hal9003 kernel:  [<c0108fc7>] syscall_call+0x7/0xb
Jun 25 16:05:49 hal9003 kernel:
Jun 25 16:05:49 hal9003 kernel: Code: 0f 0b 56 06 65 c8 2a c0 e9 ca fe ff ff 
8b 45 08 8b 50 3c e9
Jun 25 16:05:55 hal9003 kernel:  ------------[ cut here ]------------
Jun 25 16:05:55 hal9003 kernel: kernel BUG at mm/slab.c:1622!
Jun 25 16:05:55 hal9003 kernel: invalid operand: 0000 [#3]


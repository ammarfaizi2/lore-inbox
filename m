Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262479AbUBXVb0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 16:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262481AbUBXVb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 16:31:26 -0500
Received: from mta02.alltel.net ([166.102.165.144]:58538 "EHLO
	mta02-srv.alltel.net") by vger.kernel.org with ESMTP
	id S262479AbUBXVbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 16:31:14 -0500
Date: Tue, 24 Feb 2004 16:31:10 -0500 (EST)
From: Burton Windle <bwindle@fint.org>
X-X-Sender: bwindle@morpheus
To: linux-kernel@vger.kernel.org
Subject: 2.6.3: oops reading /proc/net/rpc/auth.unix.ip/content
Message-ID: <Pine.LNX.4.58.0402241629090.889@morpheus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.  I just upgraded a workstation from 2.6.2 to 2.6.3, and am now
seeing an oops on boot when my init scripts run the nfs-kernel-server
script. The oops actually happens whenever trying to read
/proc/net/rpc/auth.unix.ip/content


Linux version 2.6.3 (root@jekyll) (gcc version 3.3.2 (Debian)) #11 Mon Feb 23 22:23:26 EST 2004

Unable to handle kernel NULL pointer dereference at virtual address 00000044
 printing eip:
c0396beb
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c0396beb>]    Not tainted
EFLAGS: 00010246
EIP is at content_open+0x5b/0x80
eax: 00000000   ebx: cfb49628   ecx: 00000000   edx: cf92d738
esi: 00000000   edi: cfb29df4   ebp: cfc45f3c   esp: cfc45f28
ds: 007b   es: 007b   ss: 0068
Process grep (pid: 225, threadinfo=cfc44000 task=cfe01440)
Stack: cfb29df4 c0435e98 cfb29df4 cf9b2c24 ffffffe9 cfc45f58 c015b824 cf9b2c24
       cfb29df4 00000000 cffee000 00008000 cfc45f9c c015b76b cf9dfae0 cfff56ec
       00008000 00000003 00008000 cffee000 cf9dfae0 cfff56ec cffee000 00008000
Call Trace:
 [<c015b824>] dentry_open+0xac/0x14c
 [<c015b76b>] filp_open+0x4f/0x5c
 [<c015bdb3>] sys_open+0x37/0x80
 [<c0109c1b>] syscall_call+0x7/0xb

Code: 89 58 44 89 f0 8b 5d f4 8b 75 f8 8b 7d fc 89 ec 5d c3 8d 76



CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_NET_KEY=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_XFRM=y
CONFIG_IPV6_SCTP__=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=y
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=y
CONFIG_NET_TULIP=y
CONFIG_TULIP=y
CONFIG_DE4X5=y
CONFIG_WINBOND_840=y
CONFIG_DM9102=y
CONFIG_NET_PCI=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
CONFIG_SUNRPC=y
CONFIG_SMB_FS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_IOVIRT=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_FRAME_POINTER=y




Thanks,

Burton Windle


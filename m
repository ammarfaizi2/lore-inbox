Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263622AbTKXFTQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 00:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263625AbTKXFTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 00:19:16 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:51106 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S263622AbTKXFTL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 00:19:11 -0500
Date: Sun, 23 Nov 2003 21:19:10 -0800
From: Larry McVoy <lm@bitmover.com>
To: linux-kernel@vger.kernel.org, hpa@zytor.com
Subject: data from kernel.bkbits.net
Message-ID: <20031124051910.GA2766@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	linux-kernel@vger.kernel.org, hpa@zytor.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been trying to get all the data off the drives on the machine which
was broken into.  I have a feeling that whoever this was was hiding stuff
in the file system because both drives will not fsck clean nor will they
completely read.

I've managed to get most of the data off but not all.  Given that I've put
about 3 days into this I'm pretty much done.  If someone else wants to look
at the drives I can make them available, let me know.  But just reading the
main drive makes the kernel (Fedora 1) kill the tar process as below (it
also managed to wack the system enough that it overwrote the NVRAM with
garbage).  It hasn't been a fun weekend.

3w-xxxx: scsi0: Command failed: status = 0xc7, flags = 0x1b, unit #3.
3w-xxxx: scsi0: Command failed: status = 0xc7, flags = 0x1b, unit #3.
3w-xxxx: scsi0: AEN: WARNING: ATA port timeout: Port #3.
3w-xxxx: scsi0: AEN: WARNING: ATA port timeout: Port #3.
3w-xxxx: scsi0: Reset succeeded.
3w-xxxx: scsi0: Command failed: status = 0xc7, flags = 0x1b, unit #3.
3w-xxxx: scsi0: Command failed: status = 0xc7, flags = 0x1b, unit #3.
3w-xxxx: scsi0: Command failed: status = 0xc7, flags = 0x1b, unit #3.
3w-xxxx: scsi0: Command failed: status = 0xc7, flags = 0x1b, unit #3.
3w-xxxx: scsi0: Command failed: status = 0xc7, flags = 0x1b, unit #3.
3w-xxxx: scsi0: Command failed: status = 0xc7, flags = 0x1b, unit #3.
3w-xxxx: scsi0: AEN: WARNING: ATA port timeout: Port #3.
3w-xxxx: scsi0: AEN: WARNING: ATA port timeout: Port #3.
3w-xxxx: scsi0: AEN: WARNING: ATA port timeout: Port #3.
3w-xxxx: scsi0: AEN: WARNING: ATA port timeout: Port #3.
3w-xxxx: scsi0: AEN: WARNING: ATA port timeout: Port #3.
3w-xxxx: scsi0: AEN: WARNING: ATA port timeout: Port #3.
3w-xxxx: scsi0: Reset succeeded.
Unable to handle kernel paging request at virtual address 4954507d
 printing eip:
c015a129
*pde = 00000000
Oops: 0000
3w-xxxx sd_mod sis900 ipt_REJECT ipt_state ip_conntrack iptable_filter ip_tables sg scsi_mod keybdev mousedev hid input ehci-hcd usb-uhci usbcore ext3 jbd  
CPU:    0
EIP:    0060:[<c015a129>]    Not tainted
EFLAGS: 00010a97

EIP is at find_inode [kernel] 0x19 (2.4.22-1.2115.nptl)
eax: 00000000   ebx: 49545055   ecx: 0000000f   edx: c1640000
esi: 00000000   edi: c1655868   ebp: 0027ace1   esp: cea97ea4
ds: 0068   es: 0068   ss: 0068
Process tar (pid: 2816, stackpage=cea97000)
Stack: db99a05c 00000000 0000002a dacd43c0 c1655868 0027ace1 df9db800 c015a452 
       df9db800 0027ace1 c1655868 00000000 00000000 dacd43c0 dd476d40 df9db800 
       dd476d40 c0173669 df9db800 0027ace1 00000000 00000000 fffffff4 dacd442c 
Call Trace:   [<c015a452>] iget4_locked [kernel] 0x52 (0xcea97ec0)
[<c0173669>] ext2_lookup [kernel] 0x69 (0xcea97ee8)
[<c014f197>] real_lookup [kernel] 0xc7 (0xcea97f08)
[<c014f88a>] link_path_walk [kernel] 0x59a (0xcea97f24)
[<c014fb67>] path_lookup [kernel] 0x37 (0xcea97f60)
[<c014fdf9>] __user_walk [kernel] 0x49 (0xcea97f70)
[<c014bddf>] sys_lstat64 [kernel] 0x1f (0xcea97f8c)
[<c01099df>] system_call [kernel] 0x33 (0xcea97fc0)


Code: 39 6b 28 89 de 75 f1 8b 44 24 20 39 83 a0 00 00 00 75 e5 8b 
 
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm

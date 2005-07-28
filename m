Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261278AbVG1Dj5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbVG1Dj5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 23:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbVG1Dj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 23:39:57 -0400
Received: from dialin-209-183-23-104.tor.primus.ca ([209.183.23.104]:51408
	"EHLO node1.opengeometry.net") by vger.kernel.org with ESMTP
	id S261278AbVG1Dj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 23:39:56 -0400
Date: Wed, 27 Jul 2005 23:37:46 -0400
From: William Park <opengeometry@yahoo.ca>
To: linux-kernel@vger.kernel.org
Subject: kernel oops in 2.6.12.3 SMP
Message-ID: <20050728033746.GA2252@node1.opengeometry.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been having frequent lockup, especially while booting.  Once it
hangs, even reset button doesn't reboot the machine.  I have to turn
on/off the power.  I suspect my memory is going bad.

In the last lockup, some kernel messages showed up in /var/log/syslog.
Can anyone decipher this into plain English?


 <1>Unable to handle kernel paging request at virtual address 7fd48ac8
 printing eip:
c015603f
*pde = 00000000
Oops: 0000 [#12]
SMP 
Modules linked in: ppp_deflate zlib_deflate zlib_inflate bsd_comp ppp_async crc_ccitt 8250 serial_core ppp_generic slhc psmouse pcspkr snd_pcm_oss snd_mixer_oss nfsd exportfs lockd sunrpc ipt_MASQUERADE ipt_LOG ipt_state iptable_filter ip_nat_ftp iptable_nat ip_tables ip_conntrack_ftp ip_conntrack via_agp agpgart parport_pc parport snd_ens1371 snd_rawmidi snd_seq_device snd_ac97_codec snd_pcm snd_timer snd soundcore snd_page_alloc 3c59x mii ext3 jbd
CPU:    0
EIP:    0060:[<c015603f>]    Not tainted VLI
EFLAGS: 00010286   (2.6.12.3-smp) 
EIP is at do_sync_read+0x9f/0xe0
eax: 00000080   ebx: d928ac40   ecx: e08623e0   edx: 00000000
esi: d14d9ee0   edi: d14d9fa4   ebp: bfea4524   esp: d14d9ed4
ds: 007b   es: 007b   ss: 0068
Process mpg123 (pid: 2523, threadinfo=d14d8000 task=d731a080)
Stack: 00000080 00218b40 00000000 00000000 cfe9412c 00000000 00000001 ffffffff 
       d928ac40 df564530 00000000 d6dd5000 00000000 c0164dcf d14d9f58 d731a080 
       00000000 00000000 00218b40 00000000 cfe9412c dffc3980 c0155591 d928ac8c 
Call Trace:
 [<c0164dcf>] open_namei+0x9f/0x610
 [<c0155591>] dentry_open+0xf1/0x200
 [<c012ec40>] autoremove_wake_function+0x0/0x40
 [<c0155490>] filp_open+0x50/0x60
 [<c0156117>] vfs_read+0x97/0x100
 [<c015639d>] sys_read+0x3d/0x70
 [<c0102b79>] syscall_call+0x7/0xb
Code: 89 44 24 60 89 44 24 64 8b bc 24 9c 00 00 00 8b 07 8b 57 04 89 54 24 40 89 44 24 3c 89 e6 8b 4b 10 52 50 8b 84 24 a0 00 00 00 50 <8b> 3c 68 40 c1 00 f9 30 c0 00 f9 30 c0 4c 68 40 c1 4c 68 40 c1 

-- 
William Park <opengeometry@yahoo.ca>, Toronto, Canada
ThinFlash: Linux thin-client on USB key (flash) drive
	   http://home.eol.ca/~parkw/thinflash.html
BashDiff: Super Bash shell
	  http://freshmeat.net/projects/bashdiff/

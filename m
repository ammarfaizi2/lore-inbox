Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266096AbUIMQ4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266096AbUIMQ4K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 12:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267683AbUIMQ4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 12:56:10 -0400
Received: from barclay.balt.net ([195.14.162.78]:16286 "EHLO barclay.balt.net")
	by vger.kernel.org with ESMTP id S266096AbUIMQ4C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 12:56:02 -0400
Date: Mon, 13 Sep 2004 19:55:51 +0300
From: Zilvinas Valinskas <zilvinas@gemtek.lt>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.9 rc2 freezing
Message-ID: <20040913165551.GA24135@gemtek.lt>
Reply-To: Zilvinas Valinskas <zilvinas@gemtek.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Attribution: Zilvinas
X-Url: http://www.gemtek.lt/
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem: 
 Applied patch-2.6.9.bz2 on top of linux 2.6.8 tree, reboot - 
 then suddenly laptop frozes.
 
[2.] Full description of the problem/report:
 It is the same .config used to compile 2.6.9 rc1 and 2.6.9 rc2 
 (http://www.gemtek.lt/~zilvinas/oops/ for kern.log and .config).
 Laptop booted as usual, logged in KDE and started up evolution -
 mouse froze, keyboard seemed dead - although sysrq-s, sysrq-u & 
 sysrq-b worked just fine. After reboot I found a lot of messages
 repeated like :

Sep 13 18:51:24 evo800 kernel: Warning: kfree_skb on hard IRQ 000000d8
Sep 13 18:51:24 evo800 kernel: bad: scheduling while atomic!
Sep 13 18:51:24 evo800 kernel:  [schedule+1208/1213] schedule+0x4b8/0x4bd
Sep 13 18:51:24 evo800 kernel:  [sys_time+22/80] sys_time+0x16/0x50
Sep 13 18:51:24 evo800 kernel:  [work_resched+5/22] work_resched+0x5/0x16

or 

Sep 13 18:51:24 evo800 kernel: Warning: kfree_skb on hard IRQ 000000d8
Sep 13 18:51:24 evo800 kernel: bad: scheduling while atomic!
Sep 13 18:51:24 evo800 kernel:  [schedule+1208/1213] schedule+0x4b8/0x4bd
Sep 13 18:51:24 evo800 kernel:  [schedule_timeout+96/179] schedule_timeout+0x60/0xb3
Sep 13 18:51:24 evo800 kernel:  [__get_free_pages+31/59] __get_free_pages+0x1f/0x3b
Sep 13 18:51:24 evo800 kernel:  [process_timeout+0/5] process_timeout+0x0/0x5
Sep 13 18:51:24 evo800 kernel:  [do_select+394/698] do_select+0x18a/0x2ba
Sep 13 18:51:24 evo800 kernel:  [__pollwait+0/192] __pollwait+0x0/0xc0
Sep 13 18:51:24 evo800 kernel:  [print_context_stack+35/93] print_context_stack+0x23/0x5d
Sep 13 18:51:24 evo800 kernel:  [sys_select+670/1176] sys_select+0x29e/0x498
Sep 13 18:51:24 evo800 kernel:  [sys_time+22/80] sys_time+0x16/0x50
Sep 13 18:51:24 evo800 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
 

[3.] Keywords (i.e., modules, networking, kernel):
 Modules Loaded         nfs esp4 nfsd exportfs lockd sunrpc nsc_ircc
 ipt_state iptable_filter iptable_nat crypto_null microcode ehci_hcd
 ohci_hcd floppy irtty_sir sir_dev irda crc_ccitt 8250_pnp khazad
 twofish sha512 sha256 sha1 serpent md5 md4 des deflate zlib_deflate
 zlib_inflate cast6 cast5 blowfish arc4 aes_i586 xfrm_user
 ip_conntrack_irc ip_conntrack_ftp ip_conntrack ip_tables ide_cd cdrom
 8250 serial_core snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mixer_oss
 snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi
 snd_seq_device snd soundcore yenta_socket radeon intel_agp agpgart

[4.] Kernel version (from /proc/version):
 see (http://www.gemtek.lt/~zilvinas/oops/

[7.1.] Software (add the output of the ver_linux script here)
sh scripts/ver_linux
Linux swoop 2.6.9-rc1 #1 Wed Aug 25 10:52:32 EEST 2004 i686 GNU/Linux
 
 Gnu C                  3.3.4
 Gnu make               3.80
 binutils               2.15
 util-linux             2.12
 mount                  2.12
 module-init-tools      3.1-pre5
 e2fsprogs              1.35
 reiserfsprogs          3.6.18
 reiser4progs           line
 xfsprogs               2.6.20
 pcmcia-cs              3.2.5
 nfs-utils              1.0.6
 Linux C Library        2.3.2
 Dynamic linker (ldd)   2.3.2
 Procps                 3.2.3
 Net-tools              1.60
 Console-tools          0.2.3
 Sh-utils               5.2.1


[7.2.] Processor information (from /proc/cpuinfo):
   see http://www.gemtek.lt/~zilvinas/oops/
Thank you

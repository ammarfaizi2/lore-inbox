Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265015AbUFRHMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265015AbUFRHMu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 03:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265024AbUFRHMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 03:12:50 -0400
Received: from dialpool3-50.dial.tijd.com ([62.112.12.50]:54656 "EHLO
	precious.kicks-ass.org") by vger.kernel.org with ESMTP
	id S265015AbUFRHMs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 03:12:48 -0400
From: Jan De Luyck <lkml@kcore.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [2.6.7] Oops on rmmod processor module
Date: Fri, 18 Jun 2004 09:13:16 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200406180913.21483.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Just a F.Y.I.

I know the kernel is tainted, it does the exact same oops when I don't load the slamr (winmodem) module. Everything keeps working fine.

Jun 18 09:04:32 precious kernel: Unable to handle kernel paging request at virtual address e1aed23a
Jun 18 09:04:32 precious kernel:  printing eip:
Jun 18 09:04:32 precious kernel: e1aed23a
Jun 18 09:04:32 precious kernel: *pde = 01583067
Jun 18 09:04:32 precious kernel: *pte = 00000000
Jun 18 09:04:32 precious kernel: Oops: 0000 [#1]
Jun 18 09:04:32 precious kernel: PREEMPT
Jun 18 09:04:32 precious kernel: Modules linked in: ppp_deflate zlib_deflate zlib_inflate bsd_comp ppp_async ppp_generic slhc nsc_ircc irda fan button ac battery ohci1394
ieee1394 yenta_socket pcmcia_core b44 mii slamr 8250_pci usbhid 8250 serial_core i810_audio ac97_codec soundcore ehci_hcd uhci_hcd usbcore ipt_state iptable_nat iptable_fi
lter ip_tables nls_iso8859_15 nls_cp850 vfat fat ip_conntrack_irc ip_conntrack pcspkr psmouse sg scsi_mod cpufreq_powersave cpufreq_userspace speedstep_centrino freq_table
 ide_cd cdrom
Jun 18 09:04:32 precious kernel: CPU:    0
Jun 18 09:04:32 precious kernel: EIP:    0060:[__crc_cap_inode_removexattr+2038594/4200594]    Tainted: P
Jun 18 09:04:32 precious kernel: EFLAGS: 00010216   (2.6.7)
Jun 18 09:04:32 precious kernel: EIP is at 0xe1aed23a
Jun 18 09:04:32 precious kernel: eax: 0003a97b   ebx: 00001008   ecx: 0003a8ee   edx: 00001008
Jun 18 09:04:32 precious kernel: esi: dff3fcb0   edi: c043cc80   ebp: dff3fc00   esp: c0419fbc
Jun 18 09:04:32 precious kernel: ds: 007b   es: 007b   ss: 0068
Jun 18 09:04:32 precious kernel: Process swapper (pid: 0, threadinfo=c0418000 task=c039ea40)
Jun 18 09:04:32 precious kernel: Stack: 0009f700 00000001 c0418000 0009f700 c043cc80 0047a007 c01030e4 c0418000
Jun 18 09:04:32 precious kernel:        c041a5e9 c039ea40 00000000 c0435428 00000017 c041a340 c043ca80 00000816
Jun 18 09:04:32 precious kernel:        c010019f
Jun 18 09:04:32 precious kernel: Call Trace:
Jun 18 09:04:32 precious kernel:  [cpu_idle+52/64] cpu_idle+0x34/0x40
Jun 18 09:04:32 precious kernel:  [start_kernel+345/384] start_kernel+0x159/0x180
Jun 18 09:04:32 precious kernel:  [unknown_bootoption+0/288] unknown_bootoption+0x0/0x120
Jun 18 09:04:32 precious kernel:
Jun 18 09:04:32 precious kernel: Code:  Bad EIP value.
Jun 18 09:04:32 precious kernel:  <0>Kernel panic: Attempted to kill the idle task!
Jun 18 09:04:32 precious kernel: In idle task - not syncing

- -- 
Captain Penny's Law:
	You can fool all of the people some of the
	time, and some of the people all of the
	time, but you can't fool mom.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA0pYOUQQOfidJUwQRAi+VAJ9DYlVLxr1l1X3hXJVGThzOX3aRZQCfUb6S
CBUvz4As0zxXUAYdtT1zemQ=
=k35N
-----END PGP SIGNATURE-----

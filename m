Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268799AbUIHASN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268799AbUIHASN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 20:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268800AbUIHASN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 20:18:13 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:53161 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S268799AbUIHASH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 20:18:07 -0400
X-SPF-Record: No.SPF.Records
Date: Tue, 7 Sep 2004 17:16:14 -0700 (PDT)
From: Richard A Nelson <cowboy@debian.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm4 kjournald oops (repeatable)
Message-ID: <Pine.LNX.4.58.0409071707100.6982@onaqvg-unyy.qla.jronurnq.voz.pbz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've received a few of these already - always during *very* heavy disk
activity. After the Oops, the disk becomes strangely idle :), and a reboot
is required.

 Unable to handle kernel paging request at virtual address 6b6b6b93
  printing eip:
 c01ae727
 *pde = 00000000
 Oops: 0000 [#1]
 PREEMPT
 Modules linked in: ppp_generic slhc radeon msr ds lp binfmt_misc autofs4
	thermal fan button ac battery af_packet sch_ingress cls_u32 sch_sfq
	sch_htb ipt_MASQUERADE ip6t_multiport ipt_multiport ipt_TOS ipt_state
	ipt_TARPIT ip6t_limit ipt_limit ipt_REJECT ip6t_LOG ipt_LOG ipt_pkttype
	ipt_recent ip6table_mangle iptable_mangle ip6table_filter ip6_tables
	iptable_filter eepro100 snd_intel8x0m hw_random usbhid uhci_hcd usbcore
	parport_pc parport irtty_sir sir_dev irda crc_ccitt pcspkr yenta_socket
	pcmcia_core snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mixer_oss
	snd_pcm snd_timer snd_page_alloc gameport snd_mpu401_uart snd_rawmidi
	snd_seq_device snd soundcore nls_iso8859_1 nls_cp437 vfat fat dm_mod
	joydev evdev psmouse nvram capability commoncap intel_agp agpgart tun
	e100 mii ip_nat_tftp ip_nat_irc ip_conntrack_irc ip_nat_ftp iptable_nat
	ip_conntrack_ftp ip_conntrack ip_tables md5 ipv6 proc_intf acpi
	freq_table processor microcode cpuid rtc unix
 CPU:    0
 EIP: 0060:[__journal_clean_checkpoint_list+199/240]    Not tainted VLI
 EFLAGS: 00010202   (2.6.9-rc1-mm4)
 EIP is at __journal_clean_checkpoint_list+0xc7/0xf0
 eax: ce70e650   ebx: 6b6b6b6b   ecx: 00000000   edx: cf5aa000
 esi: cf5aa000   edi: c322f7a8   ebp: cf5aadb8   esp: cf5aad90
 ds: 007b   es: 007b   ss: 0068
 Process kjournald (pid: 1351, threadinfo=cf5aa000 task=cf588000)
 Stack: cf5aa000 c322f7a8 0000017f ce70e578 c3f2550c ce70e650 cfcbe9a8 cf5aa000
        00000000 00000000 cf5aaf58 c01abc6e 00000000 5a5a5a5a 5a5a5a5a 5a5a5a5a
        5a5a5a5a cfcbea04 cf5aa000 5a5a5a5a 5a5a5a5a 00000000 00000000 00000000
 Call Trace:
  [show_stack+122/144] show_stack+0x7a/0x90
  [show_registers+329/432] show_registers+0x149/0x1b0
  [die+221/368] die+0xdd/0x170
  [do_page_fault+565/1463] do_page_fault+0x235/0x5b7
  [error_code+45/56] error_code+0x2d/0x38
  [journal_commit_transaction+670/6480] journal_commit_transaction+0x29e/0x1950
  [kjournald+342/992] kjournald+0x156/0x3e0
  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
 Code: 45 e0 83 c4 1c 5b 5e 5f 5d c3 e8 f5 1a 14 00 eb ee 8b 45 d8 ff 48
14 8b 55 d8 8b 42 08 a8 08 75 2b 8b 45 ec 8b 58 28 85 db 74 09 <8b> 43
28 8b 55 ec 89 42 28 8b 45 f0 8b 40 30 85 c0 89 45 ec 74
-- 
Rick Nelson
<gholam> well I'm impressed
<gholam> win98 managed to crash X from within vmware.
* gholam applauds.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264120AbTKSOom (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 09:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264126AbTKSOom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 09:44:42 -0500
Received: from [203.88.135.194] ([203.88.135.194]:58257 "EHLO elitecore.com")
	by vger.kernel.org with ESMTP id S264120AbTKSOoe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 09:44:34 -0500
Message-ID: <005c01c3aeab$a0aa93c0$3901a8c0@elite.co.in>
From: "Sumit Pandya" <sumit@elitecore.com>
To: "Zwane Mwaikambo" <zwane@arm.linux.org.uk>
Cc: <linux-kernel@vger.kernel.org>, <joern@wohnheim.fh-wedel.de>
References: <00b001c3ae6e$c5e80a60$3901a8c0@elite.co.in> <Pine.LNX.4.53.0311190332320.11537@montezuma.fsmlabs.com>
Subject: Re: Infinite do_IRQ
Date: Wed, 19 Nov 2003 20:14:25 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zwane,
    I'm sorry to bother you again. Following is output from
http://kernelnewbies.org/scripts/check-stack.sh

100 getxattr
100 pirq_peer_trick
100 removexattr
100 setxattr
100 sys_reboot
100 sys_recvmsg
108 rt_cache_get_info
108 sg_proc_hoststrs_info
10c rs_read_proc
110 autofs4_notify_daemon
110 set_serial_info
110 sys_sendmsg
114 scsi_request_sense
11c autofs4_expire_run
11c radeon_cp_clear
11c scan_scsis
128 aout_core_dump
13c load_elf_binary
140 do_execve
140 mmc_ioctl
140 vc_resize
144 elf_kcore_store_hdr
170 sg_ioctl
178 extract_entropy
190 sys_msgctl
1a0 scsi_reset_provider
1a4 sys_shmctl
1ac check_tcp_syn_cookie
1b0 tcp_timewait_state_process
1b4 ip_getsockopt
1cc secure_tcp_syn_cookie
1d0 tcp_v4_conn_request
1d4 sys_semtimedop
1d8 tcp_check_req
204 cdrom_buffer_sectors
224 cdrom_read_intr
228 ip_setsockopt
248 semctl_main
258 elf_core_dump
2a8 pci_do_scan_bus
2f4 vt_ioctl
31c sym53c8xx_detect
324 pcibios_fixup_peer_bridges
324 pci_sanity_check
410 cdrom_number_of_slots
410 cdrom_select_disc
410 cdrom_slot_status
444 cdrom_ioctl
47c ide_unregister
490 inflate_fixed
524 inflate_dynamic
5a8 huft_build
73c sanitize_e820_map

    Any comments on this? Thanks in advance
-- Sumit
----- Original Message -----

From: "Zwane Mwaikambo" <zwane@arm.linux.org.uk>
Sent: Wednesday, November 19, 2003 2:17 PM


> On Wed, 19 Nov 2003, Sumit Pandya wrote:
>
> > Hi All,
> >     I'm running 2.4.22 kernel on Pentium-III processor with following
few
> > patches
> >     1. ebtables-brnf-3_vs_2.4.22.diff
> >     2. routes-2.4.22-9.diff (Julean's DGD)
> >     3. nfnetlink-ctnetlink-0.12-2.patch
> >     4. htb_3.12_3.13.diff
>
> That's quite the patch cocktail, perhaps they need some auditing on stack
> usage.
>
> >     After running it for few time suddenly it hangs and I get continuous
> > "do_IRQ: stack overflow:" messages on my serial console. I'm using
ttywatch
> > for reading console output on other Linux System.
[snip]
>
> The i386 stack grows downwards, so if anything it'll report even earlier
> than what you're hitting now. I'd recommend backing out those patches one
by
> one until you find out the offending patch and then perhaps do the stack
> usage audit from there.


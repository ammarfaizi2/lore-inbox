Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263081AbTJEMFy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 08:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263082AbTJEMFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 08:05:53 -0400
Received: from aeropc5.hut.fi ([130.233.68.132]:65224 "EHLO aeropc5.hut.fi")
	by vger.kernel.org with ESMTP id S263081AbTJEMFh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 08:05:37 -0400
Message-ID: <3F8008E1.1080200@aeropc5.hut.fi>
Date: Sun, 05 Oct 2003 15:04:49 +0300
From: Mikko Korhonen <mjkorhon@aeropc5.hut.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: fi, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: irda weirdness
Content-Type: multipart/mixed;
 boundary="------------090108070806020805010009"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090108070806020805010009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

    Hi,

I'm getting
Debug: sleeping function called from invalid context at 
include/asm/uaccess.h:498
and
Badness in local_bh_enable at kernel/softirq.c:119
 (look below) with plain 2.6.0-test6 and sir_dev ircomm_tty (as well as 
with other 2.6.0-tests).

Mikko


--------------090108070806020805010009
Content-Type: text/plain;
 name="loki.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="loki.txt"

Oct  5 14:32:43 taavi modprobe: FATAL: Module /dev/115200 not found. 
Oct  5 14:32:43 taavi pppd[1992]: pppd 2.4.1 started by mjkorhon, uid 501
Oct  5 14:32:43 taavi pppd[1992]: Using interface ppp0
Oct  5 14:32:43 taavi pppd[1992]: Connect: ppp0 <--> /dev/ircomm0
Oct  5 14:32:50 taavi pppd[1992]: local  IP address 62.78.109.70
Oct  5 14:32:50 taavi pppd[1992]: remote IP address 217.78.193.130
Oct  5 14:32:50 taavi pppd[1992]: primary   DNS address 217.78.192.22
Oct  5 14:32:50 taavi pppd[1992]: secondary DNS address 217.78.192.78
Oct  5 14:33:18 taavi loka    5 14:33:18 su(pam_unix)[2050]: session opened for user root by mjkorhon(uid=501)
Oct  5 14:34:14 taavi pppd[1992]: Terminating on signal 15.
Oct  5 14:34:14 taavi pppd[1992]: Connection terminated.
Oct  5 14:34:14 taavi pppd[1992]: Connect time 1.6 minutes.
Oct  5 14:34:14 taavi pppd[1992]: Sent 125 bytes, received 64 bytes.
Oct  5 14:34:14 taavi pppd[1992]: Exit.
Oct  5 14:34:14 taavi kernel: Badness in local_bh_enable at kernel/softirq.c:119
Oct  5 14:34:14 taavi kernel: Call Trace:
Oct  5 14:34:14 taavi kernel:  [__crc_per_cpu__kstat+109679503/288634417] local_bh_enable+0x8f/0xa0
Oct  5 14:34:14 taavi kernel:  [<c012fa7f>] local_bh_enable+0x8f/0xa0
Oct  5 14:34:14 taavi kernel:  [__crc_kernel_fpu_begin+117735339/289073630] sirdev_hard_xmit+0x16c/0x400 [sir_dev]
Oct  5 14:34:14 taavi kernel:  [<e08b5a7c>] sirdev_hard_xmit+0x16c/0x400 [sir_dev]
Oct  5 14:34:14 taavi kernel:  [__crc_per_cpu__kstat+111420934/288634417] qdisc_restart+0xc6/0x300
Oct  5 14:34:14 taavi kernel:  [<c02d8cf6>] qdisc_restart+0xc6/0x300
Oct  5 14:34:14 taavi kernel:  [__crc_per_cpu__kstat+111359376/288634417] dev_queue_xmit+0x340/0x440
Oct  5 14:34:14 taavi kernel:  [<c02c9c80>] dev_queue_xmit+0x340/0x440
Oct  5 14:34:14 taavi kernel:  [__crc_per_cpu__kstat+111422528/288634417] pfifo_fast_enqueue+0x0/0x90
Oct  5 14:34:14 taavi kernel:  [<c02d9330>] pfifo_fast_enqueue+0x0/0x90
Oct  5 14:34:14 taavi kernel:  [__crc_kernel_fpu_begin+118019425/289073630] irlap_send_data_primary_poll+0x112/0x240 [irda]
Oct  5 14:34:14 taavi kernel:  [<e08fb032>] irlap_send_data_primary_poll+0x112/0x240 [irda]
Oct  5 14:34:14 taavi kernel:  [__crc_kernel_fpu_begin+118004989/289073630] irlap_state_xmit_p+0x1be/0x3d0 [irda]
Oct  5 14:34:14 taavi kernel:  [<e08f77ce>] irlap_state_xmit_p+0x1be/0x3d0 [irda]
Oct  5 14:34:14 taavi kernel:  [__crc_kernel_fpu_begin+117999935/289073630] irlap_do_event+0x150/0x280 [irda]
Oct  5 14:34:14 taavi kernel:  [<e08f6410>] irlap_do_event+0x150/0x280 [irda]
Oct  5 14:34:14 taavi kernel:  [__crc_kernel_fpu_begin+117180460/289073630] uhci_insert_qh+0x8d/0xd0 [uhci_hcd]
Oct  5 14:34:14 taavi kernel:  [<e082e2fd>] uhci_insert_qh+0x8d/0xd0 [uhci_hcd]
Oct  5 14:34:14 taavi kernel:  [__crc_kernel_fpu_begin+117990868/289073630] irlap_data_request+0x185/0x240 [irda]
Oct  5 14:34:14 taavi kernel:  [<e08f40a5>] irlap_data_request+0x185/0x240 [irda]
Oct  5 14:34:14 taavi kernel:  [__crc_kernel_fpu_begin+117983686/289073630] irlmp_state_dtr+0x1d7/0x320 [irda]
Oct  5 14:34:14 taavi kernel:  [<e08f2497>] irlmp_state_dtr+0x1d7/0x320 [irda]
Oct  5 14:34:14 taavi kernel:  [__crc_kernel_fpu_begin+117979648/289073630] irlmp_do_lsap_event+0x81/0xd0 [irda]
Oct  5 14:34:14 taavi kernel:  [<e08f14d1>] irlmp_do_lsap_event+0x81/0xd0 [irda]
Oct  5 14:34:14 taavi kernel:  [__crc_kernel_fpu_begin+117969979/289073630] irlmp_disconnect_request+0xac/0x260 [irda]
Oct  5 14:34:14 taavi kernel:  [<e08eef0c>] irlmp_disconnect_request+0xac/0x260 [irda]
Oct  5 14:34:14 taavi kernel:  [__crc_kernel_fpu_begin+118045084/289073630] irttp_disconnect_request+0xfd/0x220 [irda]
Oct  5 14:34:14 taavi kernel:  [<e090146d>] irttp_disconnect_request+0xfd/0x220 [irda]
Oct  5 14:34:14 taavi kernel:  [__crc_kernel_fpu_begin+117765958/289073630] ircomm_state_conn+0x97/0x100 [ircomm]
Oct  5 14:34:14 taavi kernel:  [<e08bd217>] ircomm_state_conn+0x97/0x100 [ircomm]
Oct  5 14:34:14 taavi kernel:  [__crc_kernel_fpu_begin+117766121/289073630] ircomm_do_event+0x3a/0x80 [ircomm]
Oct  5 14:34:14 taavi kernel:  [<e08bd2ba>] ircomm_do_event+0x3a/0x80 [ircomm]
Oct  5 14:34:14 taavi kernel:  [__crc_kernel_fpu_begin+117764005/289073630] ircomm_disconnect_request+0x76/0xb0 [ircomm]
Oct  5 14:34:14 taavi kernel:  [<e08bca76>] ircomm_disconnect_request+0x76/0xb0 [ircomm]
Oct  5 14:34:14 taavi kernel:  [__crc_kernel_fpu_begin+117807379/289073630] ircomm_tty_state_ready+0x74/0x110 [ircomm_tty]
Oct  5 14:34:14 taavi kernel:  [<e08c73e4>] ircomm_tty_state_ready+0x74/0x110 [ircomm_tty]
Oct  5 14:34:14 taavi kernel:  [__crc_kernel_fpu_begin+117807671/289073630] ircomm_tty_do_event+0x88/0xe0 [ircomm_tty]
Oct  5 14:34:14 taavi kernel:  [<e08c7508>] ircomm_tty_do_event+0x88/0xe0 [ircomm_tty]
Oct  5 14:34:14 taavi kernel:  [__crc_kernel_fpu_begin+117801967/289073630] ircomm_tty_detach_cable+0xc0/0x140 [ircomm_tty]
Oct  5 14:34:14 taavi kernel:  [<e08c5ec0>] ircomm_tty_detach_cable+0xc0/0x140 [ircomm_tty]
Oct  5 14:34:14 taavi kernel:  [__crc_kernel_fpu_begin+117797306/289073630] ircomm_tty_shutdown+0x11b/0x1d0 [ircomm_tty]
Oct  5 14:34:14 taavi kernel:  [<e08c4c8b>] ircomm_tty_shutdown+0x11b/0x1d0 [ircomm_tty]
Oct  5 14:34:14 taavi kernel:  [__crc_kernel_fpu_begin+117793284/289073630] ircomm_tty_close+0x225/0x390 [ircomm_tty]
Oct  5 14:34:14 taavi kernel:  [<e08c3cd5>] ircomm_tty_close+0x225/0x390 [ircomm_tty]
Oct  5 14:34:14 taavi kernel:  [__crc_per_cpu__kstat+110931502/288634417] tty_fasync+0x8e/0x140
Oct  5 14:34:14 taavi kernel:  [<c026151e>] tty_fasync+0x8e/0x140
Oct  5 14:34:14 taavi kernel:  [__crc_per_cpu__kstat+110929912/288634417] release_dev+0x6e8/0x740
Oct  5 14:34:14 taavi kernel:  [<c0260ee8>] release_dev+0x6e8/0x740
Oct  5 14:34:14 taavi kernel:  [__crc_per_cpu__kstat+109742704/288634417] rcu_process_callbacks+0x180/0x1c0
Oct  5 14:34:14 taavi kernel:  [<c013f160>] rcu_process_callbacks+0x180/0x1c0
Oct  5 14:34:14 taavi kernel:  [__crc_per_cpu__kstat+109680056/288634417] tasklet_action+0x68/0xc0
Oct  5 14:34:14 taavi kernel:  [<c012fca8>] tasklet_action+0x68/0xc0
Oct  5 14:34:14 taavi kernel:  [__crc_per_cpu__kstat+109612119/288634417] smp_apic_timer_interrupt+0xd7/0x150
Oct  5 14:34:14 taavi kernel:  [<c011f347>] smp_apic_timer_interrupt+0xd7/0x150
Oct  5 14:34:14 taavi kernel:  [__crc_per_cpu__kstat+110931053/288634417] tty_release+0x3d/0xc0
Oct  5 14:34:14 taavi kernel:  [<c026135d>] tty_release+0x3d/0xc0
Oct  5 14:34:14 taavi kernel:  [__crc_per_cpu__kstat+109947725/288634417] __fput+0x12d/0x140
Oct  5 14:34:14 taavi kernel:  [<c017123d>] __fput+0x12d/0x140
Oct  5 14:34:14 taavi kernel:  [__crc_per_cpu__kstat+109940487/288634417] filp_close+0x57/0x80
Oct  5 14:34:14 taavi kernel:  [<c016f5f7>] filp_close+0x57/0x80
Oct  5 14:34:14 taavi kernel:  [__crc_per_cpu__kstat+109667004/288634417] put_files_struct+0x6c/0xe0
Oct  5 14:34:14 taavi kernel:  [<c012c9ac>] put_files_struct+0x6c/0xe0
Oct  5 14:34:14 taavi kernel:  [__crc_per_cpu__kstat+109671024/288634417] do_exit+0x210/0x5c0
Oct  5 14:34:14 taavi kernel:  [<c012d960>] do_exit+0x210/0x5c0
Oct  5 14:34:14 taavi kernel:  [__crc_per_cpu__kstat+109672391/288634417] do_group_exit+0x107/0x190
Oct  5 14:34:14 taavi kernel:  [<c012deb7>] do_group_exit+0x107/0x190
Oct  5 14:34:14 taavi kernel:  [__crc_per_cpu__kstat+109888664/288634417] sys_munmap+0x58/0x80
Oct  5 14:34:14 taavi kernel:  [<c0162b88>] sys_munmap+0x58/0x80
Oct  5 14:34:14 taavi kernel:  [__crc_per_cpu__kstat+109531963/288634417] syscall_call+0x7/0xb
Oct  5 14:34:14 taavi kernel:  [<c010ba2b>] syscall_call+0x7/0xb
Oct  5 14:34:14 taavi kernel: 
Oct  5 14:34:14 taavi kernel: Badness in local_bh_enable at kernel/softirq.c:119
Oct  5 14:34:14 taavi kernel: Call Trace:
Oct  5 14:34:14 taavi kernel:  [__crc_per_cpu__kstat+109679503/288634417] local_bh_enable+0x8f/0xa0
Oct  5 14:34:14 taavi kernel:  [<c012fa7f>] local_bh_enable+0x8f/0xa0
Oct  5 14:34:14 taavi kernel:  [__crc_per_cpu__kstat+111359433/288634417] dev_queue_xmit+0x379/0x440
Oct  5 14:34:14 taavi kernel:  [<c02c9cb9>] dev_queue_xmit+0x379/0x440
Oct  5 14:34:14 taavi kernel:  [__crc_per_cpu__kstat+111422528/288634417] pfifo_fast_enqueue+0x0/0x90
Oct  5 14:34:14 taavi kernel:  [<c02d9330>] pfifo_fast_enqueue+0x0/0x90
Oct  5 14:34:14 taavi kernel:  [__crc_kernel_fpu_begin+118019425/289073630] irlap_send_data_primary_poll+0x112/0x240 [irda]
Oct  5 14:34:14 taavi kernel:  [<e08fb032>] irlap_send_data_primary_poll+0x112/0x240 [irda]
Oct  5 14:34:14 taavi kernel:  [__crc_kernel_fpu_begin+118004989/289073630] irlap_state_xmit_p+0x1be/0x3d0 [irda]
Oct  5 14:34:14 taavi kernel:  [<e08f77ce>] irlap_state_xmit_p+0x1be/0x3d0 [irda]
Oct  5 14:34:14 taavi kernel:  [__crc_kernel_fpu_begin+117999935/289073630] irlap_do_event+0x150/0x280 [irda]
Oct  5 14:34:14 taavi kernel:  [<e08f6410>] irlap_do_event+0x150/0x280 [irda]
Oct  5 14:34:14 taavi kernel:  [__crc_kernel_fpu_begin+117180460/289073630] uhci_insert_qh+0x8d/0xd0 [uhci_hcd]
Oct  5 14:34:14 taavi kernel:  [<e082e2fd>] uhci_insert_qh+0x8d/0xd0 [uhci_hcd]
Oct  5 14:34:14 taavi kernel:  [__crc_kernel_fpu_begin+117990868/289073630] irlap_data_request+0x185/0x240 [irda]
Oct  5 14:34:14 taavi kernel:  [<e08f40a5>] irlap_data_request+0x185/0x240 [irda]
Oct  5 14:34:14 taavi kernel:  [__crc_kernel_fpu_begin+117983686/289073630] irlmp_state_dtr+0x1d7/0x320 [irda]
Oct  5 14:34:14 taavi kernel:  [<e08f2497>] irlmp_state_dtr+0x1d7/0x320 [irda]
Oct  5 14:34:14 taavi kernel:  [__crc_kernel_fpu_begin+117979648/289073630] irlmp_do_lsap_event+0x81/0xd0 [irda]
Oct  5 14:34:14 taavi kernel:  [<e08f14d1>] irlmp_do_lsap_event+0x81/0xd0 [irda]
Oct  5 14:34:14 taavi kernel:  [__crc_kernel_fpu_begin+117969979/289073630] irlmp_disconnect_request+0xac/0x260 [irda]
Oct  5 14:34:14 taavi kernel:  [<e08eef0c>] irlmp_disconnect_request+0xac/0x260 [irda]
Oct  5 14:34:14 taavi kernel:  [__crc_kernel_fpu_begin+118045084/289073630] irttp_disconnect_request+0xfd/0x220 [irda]
Oct  5 14:34:14 taavi kernel:  [<e090146d>] irttp_disconnect_request+0xfd/0x220 [irda]
Oct  5 14:34:14 taavi kernel:  [__crc_kernel_fpu_begin+117765958/289073630] ircomm_state_conn+0x97/0x100 [ircomm]
Oct  5 14:34:14 taavi kernel:  [<e08bd217>] ircomm_state_conn+0x97/0x100 [ircomm]
Oct  5 14:34:14 taavi kernel:  [__crc_kernel_fpu_begin+117766121/289073630] ircomm_do_event+0x3a/0x80 [ircomm]
Oct  5 14:34:14 taavi kernel:  [<e08bd2ba>] ircomm_do_event+0x3a/0x80 [ircomm]
Oct  5 14:34:14 taavi kernel:  [__crc_kernel_fpu_begin+117764005/289073630] ircomm_disconnect_request+0x76/0xb0 [ircomm]
Oct  5 14:34:14 taavi kernel:  [<e08bca76>] ircomm_disconnect_request+0x76/0xb0 [ircomm]
Oct  5 14:34:14 taavi kernel:  [__crc_kernel_fpu_begin+117807379/289073630] ircomm_tty_state_ready+0x74/0x110 [ircomm_tty]
Oct  5 14:34:14 taavi kernel:  [<e08c73e4>] ircomm_tty_state_ready+0x74/0x110 [ircomm_tty]
Oct  5 14:34:14 taavi kernel:  [__crc_kernel_fpu_begin+117807671/289073630] ircomm_tty_do_event+0x88/0xe0 [ircomm_tty]
Oct  5 14:34:14 taavi kernel:  [<e08c7508>] ircomm_tty_do_event+0x88/0xe0 [ircomm_tty]
Oct  5 14:34:14 taavi kernel:  [__crc_kernel_fpu_begin+117801967/289073630] ircomm_tty_detach_cable+0xc0/0x140 [ircomm_tty]
Oct  5 14:34:14 taavi kernel:  [<e08c5ec0>] ircomm_tty_detach_cable+0xc0/0x140 [ircomm_tty]
Oct  5 14:34:14 taavi kernel:  [__crc_kernel_fpu_begin+117797306/289073630] ircomm_tty_shutdown+0x11b/0x1d0 [ircomm_tty]
Oct  5 14:34:14 taavi kernel:  [<e08c4c8b>] ircomm_tty_shutdown+0x11b/0x1d0 [ircomm_tty]
Oct  5 14:34:14 taavi kernel:  [__crc_kernel_fpu_begin+117793284/289073630] ircomm_tty_close+0x225/0x390 [ircomm_tty]
Oct  5 14:34:14 taavi kernel:  [<e08c3cd5>] ircomm_tty_close+0x225/0x390 [ircomm_tty]
Oct  5 14:34:14 taavi kernel:  [__crc_per_cpu__kstat+110931502/288634417] tty_fasync+0x8e/0x140
Oct  5 14:34:14 taavi kernel:  [<c026151e>] tty_fasync+0x8e/0x140
Oct  5 14:34:14 taavi kernel:  [__crc_per_cpu__kstat+110929912/288634417] release_dev+0x6e8/0x740
Oct  5 14:34:14 taavi kernel:  [<c0260ee8>] release_dev+0x6e8/0x740
Oct  5 14:34:14 taavi kernel:  [__crc_per_cpu__kstat+109742704/288634417] rcu_process_callbacks+0x180/0x1c0
Oct  5 14:34:14 taavi kernel:  [<c013f160>] rcu_process_callbacks+0x180/0x1c0
Oct  5 14:34:14 taavi kernel:  [__crc_per_cpu__kstat+109680056/288634417] tasklet_action+0x68/0xc0
Oct  5 14:34:14 taavi kernel:  [<c012fca8>] tasklet_action+0x68/0xc0
Oct  5 14:34:14 taavi kernel:  [__crc_per_cpu__kstat+109612119/288634417] smp_apic_timer_interrupt+0xd7/0x150
Oct  5 14:34:14 taavi kernel:  [<c011f347>] smp_apic_timer_interrupt+0xd7/0x150
Oct  5 14:34:14 taavi kernel:  [__crc_per_cpu__kstat+110931053/288634417] tty_release+0x3d/0xc0
Oct  5 14:34:14 taavi kernel:  [<c026135d>] tty_release+0x3d/0xc0
Oct  5 14:34:14 taavi kernel:  [__crc_per_cpu__kstat+109947725/288634417] __fput+0x12d/0x140
Oct  5 14:34:14 taavi kernel:  [<c017123d>] __fput+0x12d/0x140
Oct  5 14:34:14 taavi kernel:  [__crc_per_cpu__kstat+109940487/288634417] filp_close+0x57/0x80
Oct  5 14:34:14 taavi kernel:  [<c016f5f7>] filp_close+0x57/0x80
Oct  5 14:34:14 taavi kernel:  [__crc_per_cpu__kstat+109667004/288634417] put_files_struct+0x6c/0xe0
Oct  5 14:34:14 taavi kernel:  [<c012c9ac>] put_files_struct+0x6c/0xe0
Oct  5 14:34:14 taavi kernel:  [__crc_per_cpu__kstat+109671024/288634417] do_exit+0x210/0x5c0
Oct  5 14:34:14 taavi kernel:  [<c012d960>] do_exit+0x210/0x5c0
Oct  5 14:34:14 taavi kernel:  [__crc_per_cpu__kstat+109672391/288634417] do_group_exit+0x107/0x190
Oct  5 14:34:14 taavi kernel:  [<c012deb7>] do_group_exit+0x107/0x190
Oct  5 14:34:14 taavi kernel:  [__crc_per_cpu__kstat+109888664/288634417] sys_munmap+0x58/0x80
Oct  5 14:34:14 taavi kernel:  [<c0162b88>] sys_munmap+0x58/0x80
Oct  5 14:34:14 taavi kernel:  [__crc_per_cpu__kstat+109531963/288634417] syscall_call+0x7/0xb
Oct  5 14:34:14 taavi kernel:  [<c010ba2b>] syscall_call+0x7/0xb
Oct  5 14:34:14 taavi kernel: 
Oct  5 14:34:21 taavi modprobe: FATAL: Module /dev/115200 not found. 
Oct  5 14:34:21 taavi pppd[2106]: pppd 2.4.1 started by mjkorhon, uid 501
Oct  5 14:34:21 taavi pppd[2106]: Using interface ppp0
Oct  5 14:34:21 taavi pppd[2106]: Connect: ppp0 <--> /dev/ircomm0
Oct  5 14:34:27 taavi pppd[2106]: local  IP address 62.78.120.140
Oct  5 14:34:27 taavi pppd[2106]: remote IP address 217.78.193.146
Oct  5 14:34:27 taavi pppd[2106]: primary   DNS address 217.78.192.22
Oct  5 14:34:27 taavi pppd[2106]: secondary DNS address 217.78.192.78
Oct  5 14:35:07 taavi pppd[2106]: Terminating on signal 15.
Oct  5 14:35:07 taavi pppd[2106]: Connection terminated.
Oct  5 14:35:07 taavi pppd[2106]: Connect time 0.8 minutes.
Oct  5 14:35:07 taavi pppd[2106]: Sent 125 bytes, received 64 bytes.
Oct  5 14:35:08 taavi pppd[2106]: Exit.
Oct  5 14:35:08 taavi modprobe: FATAL: Module /dev/:0 not found. 
Oct  5 14:35:17 taavi modprobe: FATAL: Module /dev/115200 not found. 
Oct  5 14:35:18 taavi pppd[2130]: pppd 2.4.1 started by mjkorhon, uid 501
Oct  5 14:35:18 taavi pppd[2130]: Using interface ppp0
Oct  5 14:35:18 taavi pppd[2130]: Connect: ppp0 <--> /dev/ircomm0
Oct  5 14:35:20 taavi pppd[2130]: Couldn't set active-filter in kernel: Invalid argument
Oct  5 14:35:23 taavi pppd[2130]: local  IP address 62.78.109.126
Oct  5 14:35:23 taavi pppd[2130]: remote IP address 217.78.193.130
Oct  5 14:35:23 taavi pppd[2130]: primary   DNS address 217.78.192.22
Oct  5 14:35:23 taavi pppd[2130]: secondary DNS address 217.78.192.78
Oct  5 14:35:43 taavi pppd[2130]: Terminating on signal 15.
Oct  5 14:35:43 taavi pppd[2130]: Connection terminated.
Oct  5 14:35:43 taavi pppd[2130]: Connect time 0.5 minutes.
Oct  5 14:35:43 taavi pppd[2130]: Sent 125 bytes, received 64 bytes.
Oct  5 14:35:43 taavi pppd[2130]: Exit.
Oct  5 14:35:43 taavi kernel: Badness in local_bh_enable at kernel/softirq.c:119
Oct  5 14:35:43 taavi kernel: Call Trace:
Oct  5 14:35:43 taavi kernel:  [__crc_per_cpu__kstat+109679503/288634417] local_bh_enable+0x8f/0xa0
Oct  5 14:35:43 taavi kernel:  [<c012fa7f>] local_bh_enable+0x8f/0xa0
Oct  5 14:35:43 taavi kernel:  [__crc_kernel_fpu_begin+117735339/289073630] sirdev_hard_xmit+0x16c/0x400 [sir_dev]
Oct  5 14:35:43 taavi kernel:  [<e08b5a7c>] sirdev_hard_xmit+0x16c/0x400 [sir_dev]
Oct  5 14:35:43 taavi kernel:  [__crc_per_cpu__kstat+111420934/288634417] qdisc_restart+0xc6/0x300
Oct  5 14:35:43 taavi kernel:  [<c02d8cf6>] qdisc_restart+0xc6/0x300
Oct  5 14:35:43 taavi kernel:  [__crc_per_cpu__kstat+111359376/288634417] dev_queue_xmit+0x340/0x440
Oct  5 14:35:43 taavi kernel:  [<c02c9c80>] dev_queue_xmit+0x340/0x440
Oct  5 14:35:43 taavi kernel:  [__crc_per_cpu__kstat+111422528/288634417] pfifo_fast_enqueue+0x0/0x90
Oct  5 14:35:43 taavi kernel:  [<c02d9330>] pfifo_fast_enqueue+0x0/0x90
Oct  5 14:35:43 taavi kernel:  [__crc_kernel_fpu_begin+118019425/289073630] irlap_send_data_primary_poll+0x112/0x240 [irda]
Oct  5 14:35:43 taavi kernel:  [<e08fb032>] irlap_send_data_primary_poll+0x112/0x240 [irda]
Oct  5 14:35:43 taavi kernel:  [__crc_kernel_fpu_begin+118004989/289073630] irlap_state_xmit_p+0x1be/0x3d0 [irda]
Oct  5 14:35:43 taavi kernel:  [<e08f77ce>] irlap_state_xmit_p+0x1be/0x3d0 [irda]
Oct  5 14:35:43 taavi kernel:  [__crc_kernel_fpu_begin+117061270/289073630] hcd_submit_urb+0x147/0x1f0 [usbcore]
Oct  5 14:35:43 taavi kernel:  [<e0811167>] hcd_submit_urb+0x147/0x1f0 [usbcore]
Oct  5 14:35:43 taavi kernel:  [__crc_kernel_fpu_begin+117999935/289073630] irlap_do_event+0x150/0x280 [irda]
Oct  5 14:35:43 taavi kernel:  [<e08f6410>] irlap_do_event+0x150/0x280 [irda]
Oct  5 14:35:43 taavi kernel:  [__crc_kernel_fpu_begin+117990868/289073630] irlap_data_request+0x185/0x240 [irda]
Oct  5 14:35:43 taavi kernel:  [<e08f40a5>] irlap_data_request+0x185/0x240 [irda]
Oct  5 14:35:43 taavi kernel:  [__crc_kernel_fpu_begin+117983686/289073630] irlmp_state_dtr+0x1d7/0x320 [irda]
Oct  5 14:35:43 taavi kernel:  [<e08f2497>] irlmp_state_dtr+0x1d7/0x320 [irda]
Oct  5 14:35:43 taavi kernel:  [__crc_kernel_fpu_begin+117979648/289073630] irlmp_do_lsap_event+0x81/0xd0 [irda]
Oct  5 14:35:43 taavi kernel:  [<e08f14d1>] irlmp_do_lsap_event+0x81/0xd0 [irda]
Oct  5 14:35:43 taavi kernel:  [__crc_kernel_fpu_begin+117969979/289073630] irlmp_disconnect_request+0xac/0x260 [irda]
Oct  5 14:35:43 taavi kernel:  [<e08eef0c>] irlmp_disconnect_request+0xac/0x260 [irda]
Oct  5 14:35:43 taavi kernel:  [__crc_kernel_fpu_begin+118045084/289073630] irttp_disconnect_request+0xfd/0x220 [irda]
Oct  5 14:35:43 taavi kernel:  [<e090146d>] irttp_disconnect_request+0xfd/0x220 [irda]
Oct  5 14:35:43 taavi kernel:  [__crc_kernel_fpu_begin+117765958/289073630] ircomm_state_conn+0x97/0x100 [ircomm]
Oct  5 14:35:43 taavi kernel:  [<e08bd217>] ircomm_state_conn+0x97/0x100 [ircomm]
Oct  5 14:35:43 taavi kernel:  [__crc_kernel_fpu_begin+117766121/289073630] ircomm_do_event+0x3a/0x80 [ircomm]
Oct  5 14:35:43 taavi kernel:  [<e08bd2ba>] ircomm_do_event+0x3a/0x80 [ircomm]
Oct  5 14:35:43 taavi kernel:  [__crc_kernel_fpu_begin+117764005/289073630] ircomm_disconnect_request+0x76/0xb0 [ircomm]
Oct  5 14:35:43 taavi kernel:  [<e08bca76>] ircomm_disconnect_request+0x76/0xb0 [ircomm]
Oct  5 14:35:43 taavi kernel:  [__crc_kernel_fpu_begin+117807379/289073630] ircomm_tty_state_ready+0x74/0x110 [ircomm_tty]
Oct  5 14:35:43 taavi kernel:  [<e08c73e4>] ircomm_tty_state_ready+0x74/0x110 [ircomm_tty]
Oct  5 14:35:43 taavi kernel:  [__crc_kernel_fpu_begin+117807671/289073630] ircomm_tty_do_event+0x88/0xe0 [ircomm_tty]
Oct  5 14:35:43 taavi kernel:  [<e08c7508>] ircomm_tty_do_event+0x88/0xe0 [ircomm_tty]
Oct  5 14:35:43 taavi kernel:  [__crc_kernel_fpu_begin+117801967/289073630] ircomm_tty_detach_cable+0xc0/0x140 [ircomm_tty]
Oct  5 14:35:43 taavi kernel:  [<e08c5ec0>] ircomm_tty_detach_cable+0xc0/0x140 [ircomm_tty]
Oct  5 14:35:43 taavi kernel:  [__crc_kernel_fpu_begin+117797306/289073630] ircomm_tty_shutdown+0x11b/0x1d0 [ircomm_tty]
Oct  5 14:35:43 taavi kernel:  [<e08c4c8b>] ircomm_tty_shutdown+0x11b/0x1d0 [ircomm_tty]
Oct  5 14:35:44 taavi kernel:  [__crc_kernel_fpu_begin+117793284/289073630] ircomm_tty_close+0x225/0x390 [ircomm_tty]
Oct  5 14:35:44 taavi kernel:  [<e08c3cd5>] ircomm_tty_close+0x225/0x390 [ircomm_tty]
Oct  5 14:35:44 taavi kernel:  [__crc_per_cpu__kstat+110931502/288634417] tty_fasync+0x8e/0x140
Oct  5 14:35:44 taavi kernel:  [<c026151e>] tty_fasync+0x8e/0x140
Oct  5 14:35:44 taavi kernel:  [__crc_per_cpu__kstat+110929912/288634417] release_dev+0x6e8/0x740
Oct  5 14:35:44 taavi kernel:  [<c0260ee8>] release_dev+0x6e8/0x740
Oct  5 14:35:44 taavi kernel:  [__crc_per_cpu__kstat+109745051/288634417] kernel_text_address+0x3b/0x50
Oct  5 14:35:44 taavi kernel:  [<c013fa8b>] kernel_text_address+0x3b/0x50
Oct  5 14:35:44 taavi kernel:  [__crc_per_cpu__kstat+109628520/288634417] kernel_map_pages+0x28/0x5c
Oct  5 14:35:44 taavi kernel:  [<c0123358>] kernel_map_pages+0x28/0x5c
Oct  5 14:35:44 taavi kernel:  [__crc_per_cpu__kstat+110931053/288634417] tty_release+0x3d/0xc0
Oct  5 14:35:44 taavi kernel:  [<c026135d>] tty_release+0x3d/0xc0
Oct  5 14:35:44 taavi kernel:  [__crc_per_cpu__kstat+109947725/288634417] __fput+0x12d/0x140
Oct  5 14:35:44 taavi kernel:  [<c017123d>] __fput+0x12d/0x140
Oct  5 14:35:44 taavi kernel:  [__crc_per_cpu__kstat+109940487/288634417] filp_close+0x57/0x80
Oct  5 14:35:44 taavi kernel:  [<c016f5f7>] filp_close+0x57/0x80
Oct  5 14:35:44 taavi kernel:  [__crc_per_cpu__kstat+109667004/288634417] put_files_struct+0x6c/0xe0
Oct  5 14:35:44 taavi kernel:  [<c012c9ac>] put_files_struct+0x6c/0xe0
Oct  5 14:35:44 taavi kernel:  [__crc_per_cpu__kstat+109671024/288634417] do_exit+0x210/0x5c0
Oct  5 14:35:44 taavi kernel:  [<c012d960>] do_exit+0x210/0x5c0
Oct  5 14:35:44 taavi kernel:  [__crc_per_cpu__kstat+109672391/288634417] do_group_exit+0x107/0x190
Oct  5 14:35:44 taavi kernel:  [<c012deb7>] do_group_exit+0x107/0x190
Oct  5 14:35:44 taavi kernel:  [__crc_per_cpu__kstat+109888664/288634417] sys_munmap+0x58/0x80
Oct  5 14:35:44 taavi kernel:  [<c0162b88>] sys_munmap+0x58/0x80
Oct  5 14:35:44 taavi kernel:  [__crc_per_cpu__kstat+109531963/288634417] syscall_call+0x7/0xb
Oct  5 14:35:44 taavi kernel:  [<c010ba2b>] syscall_call+0x7/0xb
Oct  5 14:35:44 taavi kernel: 
Oct  5 14:35:44 taavi kernel: Badness in local_bh_enable at kernel/softirq.c:119
Oct  5 14:35:44 taavi kernel: Call Trace:
Oct  5 14:35:44 taavi kernel:  [__crc_per_cpu__kstat+109679503/288634417] local_bh_enable+0x8f/0xa0
Oct  5 14:35:44 taavi kernel:  [<c012fa7f>] local_bh_enable+0x8f/0xa0
Oct  5 14:35:44 taavi kernel:  [__crc_per_cpu__kstat+111359433/288634417] dev_queue_xmit+0x379/0x440
Oct  5 14:35:44 taavi kernel:  [<c02c9cb9>] dev_queue_xmit+0x379/0x440
Oct  5 14:35:44 taavi kernel:  [__crc_per_cpu__kstat+111422528/288634417] pfifo_fast_enqueue+0x0/0x90
Oct  5 14:35:44 taavi kernel:  [<c02d9330>] pfifo_fast_enqueue+0x0/0x90
Oct  5 14:35:44 taavi kernel:  [__crc_kernel_fpu_begin+118019425/289073630] irlap_send_data_primary_poll+0x112/0x240 [irda]
Oct  5 14:35:44 taavi kernel:  [<e08fb032>] irlap_send_data_primary_poll+0x112/0x240 [irda]
Oct  5 14:35:44 taavi kernel:  [__crc_kernel_fpu_begin+118004989/289073630] irlap_state_xmit_p+0x1be/0x3d0 [irda]
Oct  5 14:35:44 taavi kernel:  [<e08f77ce>] irlap_state_xmit_p+0x1be/0x3d0 [irda]
Oct  5 14:35:44 taavi kernel:  [__crc_kernel_fpu_begin+117061270/289073630] hcd_submit_urb+0x147/0x1f0 [usbcore]
Oct  5 14:35:44 taavi kernel:  [<e0811167>] hcd_submit_urb+0x147/0x1f0 [usbcore]
Oct  5 14:35:44 taavi kernel:  [__crc_kernel_fpu_begin+117999935/289073630] irlap_do_event+0x150/0x280 [irda]
Oct  5 14:35:44 taavi kernel:  [<e08f6410>] irlap_do_event+0x150/0x280 [irda]
Oct  5 14:35:44 taavi kernel:  [__crc_kernel_fpu_begin+117990868/289073630] irlap_data_request+0x185/0x240 [irda]
Oct  5 14:35:44 taavi kernel:  [<e08f40a5>] irlap_data_request+0x185/0x240 [irda]
Oct  5 14:35:44 taavi kernel:  [__crc_kernel_fpu_begin+117983686/289073630] irlmp_state_dtr+0x1d7/0x320 [irda]
Oct  5 14:35:44 taavi kernel:  [<e08f2497>] irlmp_state_dtr+0x1d7/0x320 [irda]
Oct  5 14:35:44 taavi kernel:  [__crc_kernel_fpu_begin+117979648/289073630] irlmp_do_lsap_event+0x81/0xd0 [irda]
Oct  5 14:35:44 taavi kernel:  [<e08f14d1>] irlmp_do_lsap_event+0x81/0xd0 [irda]
Oct  5 14:35:44 taavi kernel:  [__crc_kernel_fpu_begin+117969979/289073630] irlmp_disconnect_request+0xac/0x260 [irda]
Oct  5 14:35:44 taavi kernel:  [<e08eef0c>] irlmp_disconnect_request+0xac/0x260 [irda]
Oct  5 14:35:44 taavi kernel:  [__crc_kernel_fpu_begin+118045084/289073630] irttp_disconnect_request+0xfd/0x220 [irda]
Oct  5 14:35:44 taavi kernel:  [<e090146d>] irttp_disconnect_request+0xfd/0x220 [irda]
Oct  5 14:35:44 taavi kernel:  [__crc_kernel_fpu_begin+117765958/289073630] ircomm_state_conn+0x97/0x100 [ircomm]
Oct  5 14:35:44 taavi kernel:  [<e08bd217>] ircomm_state_conn+0x97/0x100 [ircomm]
Oct  5 14:35:44 taavi kernel:  [__crc_kernel_fpu_begin+117766121/289073630] ircomm_do_event+0x3a/0x80 [ircomm]
Oct  5 14:35:44 taavi kernel:  [<e08bd2ba>] ircomm_do_event+0x3a/0x80 [ircomm]
Oct  5 14:35:44 taavi kernel:  [__crc_kernel_fpu_begin+117764005/289073630] ircomm_disconnect_request+0x76/0xb0 [ircomm]
Oct  5 14:35:44 taavi kernel:  [<e08bca76>] ircomm_disconnect_request+0x76/0xb0 [ircomm]
Oct  5 14:35:44 taavi kernel:  [__crc_kernel_fpu_begin+117807379/289073630] ircomm_tty_state_ready+0x74/0x110 [ircomm_tty]
Oct  5 14:35:44 taavi kernel:  [<e08c73e4>] ircomm_tty_state_ready+0x74/0x110 [ircomm_tty]
Oct  5 14:35:44 taavi kernel:  [__crc_kernel_fpu_begin+117807671/289073630] ircomm_tty_do_event+0x88/0xe0 [ircomm_tty]
Oct  5 14:35:44 taavi kernel:  [<e08c7508>] ircomm_tty_do_event+0x88/0xe0 [ircomm_tty]
Oct  5 14:35:44 taavi kernel:  [__crc_kernel_fpu_begin+117801967/289073630] ircomm_tty_detach_cable+0xc0/0x140 [ircomm_tty]
Oct  5 14:35:44 taavi kernel:  [<e08c5ec0>] ircomm_tty_detach_cable+0xc0/0x140 [ircomm_tty]
Oct  5 14:35:44 taavi kernel:  [__crc_kernel_fpu_begin+117797306/289073630] ircomm_tty_shutdown+0x11b/0x1d0 [ircomm_tty]
Oct  5 14:35:44 taavi kernel:  [<e08c4c8b>] ircomm_tty_shutdown+0x11b/0x1d0 [ircomm_tty]
Oct  5 14:35:44 taavi kernel:  [__crc_kernel_fpu_begin+117793284/289073630] ircomm_tty_close+0x225/0x390 [ircomm_tty]
Oct  5 14:35:44 taavi kernel:  [<e08c3cd5>] ircomm_tty_close+0x225/0x390 [ircomm_tty]
Oct  5 14:35:44 taavi kernel:  [__crc_per_cpu__kstat+110931502/288634417] tty_fasync+0x8e/0x140
Oct  5 14:35:44 taavi kernel:  [<c026151e>] tty_fasync+0x8e/0x140
Oct  5 14:35:44 taavi kernel:  [__crc_per_cpu__kstat+110929912/288634417] release_dev+0x6e8/0x740
Oct  5 14:35:44 taavi kernel:  [<c0260ee8>] release_dev+0x6e8/0x740
Oct  5 14:35:44 taavi kernel:  [__crc_per_cpu__kstat+109745051/288634417] kernel_text_address+0x3b/0x50
Oct  5 14:35:44 taavi kernel:  [<c013fa8b>] kernel_text_address+0x3b/0x50
Oct  5 14:35:44 taavi kernel:  [__crc_per_cpu__kstat+109628520/288634417] kernel_map_pages+0x28/0x5c
Oct  5 14:35:44 taavi kernel:  [<c0123358>] kernel_map_pages+0x28/0x5c
Oct  5 14:35:44 taavi kernel:  [__crc_per_cpu__kstat+110931053/288634417] tty_release+0x3d/0xc0
Oct  5 14:35:44 taavi kernel:  [<c026135d>] tty_release+0x3d/0xc0
Oct  5 14:35:44 taavi kernel:  [__crc_per_cpu__kstat+109947725/288634417] __fput+0x12d/0x140
Oct  5 14:35:44 taavi kernel:  [<c017123d>] __fput+0x12d/0x140
Oct  5 14:35:44 taavi kernel:  [__crc_per_cpu__kstat+109940487/288634417] filp_close+0x57/0x80
Oct  5 14:35:44 taavi kernel:  [<c016f5f7>] filp_close+0x57/0x80
Oct  5 14:35:44 taavi kernel:  [__crc_per_cpu__kstat+109667004/288634417] put_files_struct+0x6c/0xe0
Oct  5 14:35:44 taavi kernel:  [<c012c9ac>] put_files_struct+0x6c/0xe0
Oct  5 14:35:44 taavi kernel:  [__crc_per_cpu__kstat+109671024/288634417] do_exit+0x210/0x5c0
Oct  5 14:35:44 taavi kernel:  [<c012d960>] do_exit+0x210/0x5c0
Oct  5 14:35:44 taavi kernel:  [__crc_per_cpu__kstat+109672391/288634417] do_group_exit+0x107/0x190
Oct  5 14:35:44 taavi kernel:  [<c012deb7>] do_group_exit+0x107/0x190
Oct  5 14:35:44 taavi kernel:  [__crc_per_cpu__kstat+109888664/288634417] sys_munmap+0x58/0x80
Oct  5 14:35:44 taavi kernel:  [<c0162b88>] sys_munmap+0x58/0x80
Oct  5 14:35:44 taavi kernel:  [__crc_per_cpu__kstat+109531963/288634417] syscall_call+0x7/0xb
Oct  5 14:35:44 taavi kernel:  [<c010ba2b>] syscall_call+0x7/0xb
Oct  5 14:35:44 taavi kernel: 
Oct  5 14:35:51 taavi modprobe: FATAL: Module /dev/115200 not found. 
Oct  5 14:35:51 taavi pppd[2152]: pppd 2.4.1 started by mjkorhon, uid 501
Oct  5 14:35:51 taavi pppd[2152]: Using interface ppp0
Oct  5 14:35:51 taavi pppd[2152]: Connect: ppp0 <--> /dev/ircomm0
Oct  5 14:35:57 taavi pppd[2152]: local  IP address 62.78.109.134
Oct  5 14:35:57 taavi pppd[2152]: remote IP address 217.78.193.130
Oct  5 14:35:57 taavi pppd[2152]: primary   DNS address 217.78.192.22
Oct  5 14:35:57 taavi pppd[2152]: secondary DNS address 217.78.192.78
Oct  5 14:38:08 taavi modprobe: FATAL: Module /dev/:0 not found. 
Oct  5 14:38:20 taavi pppd[2152]: Terminating on signal 15.
Oct  5 14:38:20 taavi pppd[2152]: Connection terminated.
Oct  5 14:38:20 taavi pppd[2152]: Connect time 2.5 minutes.
Oct  5 14:38:20 taavi pppd[2152]: Sent 125 bytes, received 64 bytes.
Oct  5 14:38:20 taavi pppd[2152]: Exit.
Oct  5 14:38:20 taavi kernel: Badness in local_bh_enable at kernel/softirq.c:119
Oct  5 14:38:20 taavi kernel: Call Trace:
Oct  5 14:38:20 taavi kernel:  [__crc_per_cpu__kstat+109679503/288634417] local_bh_enable+0x8f/0xa0
Oct  5 14:38:20 taavi kernel:  [<c012fa7f>] local_bh_enable+0x8f/0xa0
Oct  5 14:38:20 taavi kernel:  [__crc_kernel_fpu_begin+117735339/289073630] sirdev_hard_xmit+0x16c/0x400 [sir_dev]
Oct  5 14:38:20 taavi kernel:  [<e08b5a7c>] sirdev_hard_xmit+0x16c/0x400 [sir_dev]
Oct  5 14:38:20 taavi kernel:  [__crc_per_cpu__kstat+111420934/288634417] qdisc_restart+0xc6/0x300
Oct  5 14:38:20 taavi kernel:  [<c02d8cf6>] qdisc_restart+0xc6/0x300
Oct  5 14:38:20 taavi kernel:  [__crc_per_cpu__kstat+111359376/288634417] dev_queue_xmit+0x340/0x440
Oct  5 14:38:20 taavi kernel:  [<c02c9c80>] dev_queue_xmit+0x340/0x440
Oct  5 14:38:20 taavi kernel:  [__crc_per_cpu__kstat+111422528/288634417] pfifo_fast_enqueue+0x0/0x90
Oct  5 14:38:20 taavi kernel:  [<c02d9330>] pfifo_fast_enqueue+0x0/0x90
Oct  5 14:38:20 taavi kernel:  [__crc_kernel_fpu_begin+118019425/289073630] irlap_send_data_primary_poll+0x112/0x240 [irda]
Oct  5 14:38:20 taavi kernel:  [<e08fb032>] irlap_send_data_primary_poll+0x112/0x240 [irda]
Oct  5 14:38:20 taavi kernel:  [__crc_kernel_fpu_begin+118004989/289073630] irlap_state_xmit_p+0x1be/0x3d0 [irda]
Oct  5 14:38:20 taavi kernel:  [<e08f77ce>] irlap_state_xmit_p+0x1be/0x3d0 [irda]
Oct  5 14:38:20 taavi kernel:  [__crc_per_cpu__kstat+110642566/288634417] pci_pool_free+0x196/0x21e
Oct  5 14:38:20 taavi kernel:  [<c021ac76>] pci_pool_free+0x196/0x21e
Oct  5 14:38:20 taavi kernel:  [__crc_kernel_fpu_begin+117999935/289073630] irlap_do_event+0x150/0x280 [irda]
Oct  5 14:38:20 taavi kernel:  [<e08f6410>] irlap_do_event+0x150/0x280 [irda]
Oct  5 14:38:20 taavi kernel:  [__crc_kernel_fpu_begin+117990868/289073630] irlap_data_request+0x185/0x240 [irda]
Oct  5 14:38:20 taavi kernel:  [<e08f40a5>] irlap_data_request+0x185/0x240 [irda]
Oct  5 14:38:20 taavi kernel:  [__crc_kernel_fpu_begin+117983686/289073630] irlmp_state_dtr+0x1d7/0x320 [irda]
Oct  5 14:38:20 taavi kernel:  [<e08f2497>] irlmp_state_dtr+0x1d7/0x320 [irda]
Oct  5 14:38:20 taavi kernel:  [__crc_kernel_fpu_begin+117979648/289073630] irlmp_do_lsap_event+0x81/0xd0 [irda]
Oct  5 14:38:20 taavi kernel:  [<e08f14d1>] irlmp_do_lsap_event+0x81/0xd0 [irda]
Oct  5 14:38:20 taavi kernel:  [__crc_kernel_fpu_begin+117969979/289073630] irlmp_disconnect_request+0xac/0x260 [irda]
Oct  5 14:38:20 taavi kernel:  [<e08eef0c>] irlmp_disconnect_request+0xac/0x260 [irda]
Oct  5 14:38:20 taavi kernel:  [__crc_kernel_fpu_begin+118045084/289073630] irttp_disconnect_request+0xfd/0x220 [irda]
Oct  5 14:38:20 taavi kernel:  [<e090146d>] irttp_disconnect_request+0xfd/0x220 [irda]
Oct  5 14:38:20 taavi kernel:  [__crc_kernel_fpu_begin+117765958/289073630] ircomm_state_conn+0x97/0x100 [ircomm]
Oct  5 14:38:20 taavi kernel:  [<e08bd217>] ircomm_state_conn+0x97/0x100 [ircomm]
Oct  5 14:38:20 taavi kernel:  [__crc_kernel_fpu_begin+117766121/289073630] ircomm_do_event+0x3a/0x80 [ircomm]
Oct  5 14:38:20 taavi kernel:  [<e08bd2ba>] ircomm_do_event+0x3a/0x80 [ircomm]
Oct  5 14:38:20 taavi kernel:  [__crc_kernel_fpu_begin+117764005/289073630] ircomm_disconnect_request+0x76/0xb0 [ircomm]
Oct  5 14:38:20 taavi kernel:  [<e08bca76>] ircomm_disconnect_request+0x76/0xb0 [ircomm]
Oct  5 14:38:20 taavi kernel:  [__crc_kernel_fpu_begin+117807379/289073630] ircomm_tty_state_ready+0x74/0x110 [ircomm_tty]
Oct  5 14:38:20 taavi kernel:  [<e08c73e4>] ircomm_tty_state_ready+0x74/0x110 [ircomm_tty]
Oct  5 14:38:20 taavi kernel:  [__crc_kernel_fpu_begin+117807671/289073630] ircomm_tty_do_event+0x88/0xe0 [ircomm_tty]
Oct  5 14:38:20 taavi kernel:  [<e08c7508>] ircomm_tty_do_event+0x88/0xe0 [ircomm_tty]
Oct  5 14:38:20 taavi kernel:  [__crc_kernel_fpu_begin+117801967/289073630] ircomm_tty_detach_cable+0xc0/0x140 [ircomm_tty]
Oct  5 14:38:20 taavi kernel:  [<e08c5ec0>] ircomm_tty_detach_cable+0xc0/0x140 [ircomm_tty]
Oct  5 14:38:20 taavi kernel:  [__crc_kernel_fpu_begin+117797306/289073630] ircomm_tty_shutdown+0x11b/0x1d0 [ircomm_tty]
Oct  5 14:38:20 taavi kernel:  [<e08c4c8b>] ircomm_tty_shutdown+0x11b/0x1d0 [ircomm_tty]
Oct  5 14:38:20 taavi kernel:  [__crc_kernel_fpu_begin+117793284/289073630] ircomm_tty_close+0x225/0x390 [ircomm_tty]
Oct  5 14:38:20 taavi kernel:  [<e08c3cd5>] ircomm_tty_close+0x225/0x390 [ircomm_tty]
Oct  5 14:38:20 taavi kernel:  [__crc_per_cpu__kstat+110931502/288634417] tty_fasync+0x8e/0x140
Oct  5 14:38:20 taavi kernel:  [<c026151e>] tty_fasync+0x8e/0x140
Oct  5 14:38:20 taavi kernel:  [__crc_per_cpu__kstat+110929912/288634417] release_dev+0x6e8/0x740
Oct  5 14:38:20 taavi kernel:  [<c0260ee8>] release_dev+0x6e8/0x740
Oct  5 14:38:20 taavi kernel:  [__crc_per_cpu__kstat+109700048/288634417] do_timer+0xc0/0xd0
Oct  5 14:38:20 taavi kernel:  [<c0134ac0>] do_timer+0xc0/0xd0
Oct  5 14:38:20 taavi kernel:  [__crc_per_cpu__kstat+109541211/288634417] handle_IRQ_event+0x3b/0x70
Oct  5 14:38:20 taavi kernel:  [<c010de4b>] handle_IRQ_event+0x3b/0x70
Oct  5 14:38:20 taavi kernel:  [__crc_per_cpu__kstat+109542495/288634417] do_IRQ+0x12f/0x240
Oct  5 14:38:20 taavi kernel:  [<c010e34f>] do_IRQ+0x12f/0x240
Oct  5 14:38:20 taavi kernel:  [__crc_per_cpu__kstat+110931053/288634417] tty_release+0x3d/0xc0
Oct  5 14:38:20 taavi kernel:  [<c026135d>] tty_release+0x3d/0xc0
Oct  5 14:38:20 taavi kernel:  [__crc_per_cpu__kstat+109947725/288634417] __fput+0x12d/0x140
Oct  5 14:38:20 taavi kernel:  [<c017123d>] __fput+0x12d/0x140
Oct  5 14:38:20 taavi kernel:  [__crc_per_cpu__kstat+109940487/288634417] filp_close+0x57/0x80
Oct  5 14:38:20 taavi kernel:  [<c016f5f7>] filp_close+0x57/0x80
Oct  5 14:38:20 taavi kernel:  [__crc_per_cpu__kstat+109667004/288634417] put_files_struct+0x6c/0xe0
Oct  5 14:38:20 taavi kernel:  [<c012c9ac>] put_files_struct+0x6c/0xe0
Oct  5 14:38:20 taavi kernel:  [__crc_per_cpu__kstat+109671024/288634417] do_exit+0x210/0x5c0
Oct  5 14:38:20 taavi kernel:  [<c012d960>] do_exit+0x210/0x5c0
Oct  5 14:38:20 taavi kernel:  [__crc_per_cpu__kstat+109672391/288634417] do_group_exit+0x107/0x190
Oct  5 14:38:20 taavi kernel:  [<c012deb7>] do_group_exit+0x107/0x190
Oct  5 14:38:20 taavi kernel:  [__crc_per_cpu__kstat+109888664/288634417] sys_munmap+0x58/0x80
Oct  5 14:38:20 taavi kernel:  [<c0162b88>] sys_munmap+0x58/0x80
Oct  5 14:38:20 taavi kernel:  [__crc_per_cpu__kstat+109531963/288634417] syscall_call+0x7/0xb
Oct  5 14:38:20 taavi kernel:  [<c010ba2b>] syscall_call+0x7/0xb
Oct  5 14:38:20 taavi kernel: 
Oct  5 14:38:20 taavi kernel: Badness in local_bh_enable at kernel/softirq.c:119
Oct  5 14:38:20 taavi kernel: Call Trace:
Oct  5 14:38:20 taavi kernel:  [__crc_per_cpu__kstat+109679503/288634417] local_bh_enable+0x8f/0xa0
Oct  5 14:38:20 taavi kernel:  [<c012fa7f>] local_bh_enable+0x8f/0xa0
Oct  5 14:38:20 taavi kernel:  [__crc_per_cpu__kstat+111359433/288634417] dev_queue_xmit+0x379/0x440
Oct  5 14:38:20 taavi kernel:  [<c02c9cb9>] dev_queue_xmit+0x379/0x440
Oct  5 14:38:20 taavi kernel:  [__crc_per_cpu__kstat+111422528/288634417] pfifo_fast_enqueue+0x0/0x90
Oct  5 14:38:20 taavi kernel:  [<c02d9330>] pfifo_fast_enqueue+0x0/0x90
Oct  5 14:38:20 taavi kernel:  [__crc_kernel_fpu_begin+118019425/289073630] irlap_send_data_primary_poll+0x112/0x240 [irda]
Oct  5 14:38:20 taavi kernel:  [<e08fb032>] irlap_send_data_primary_poll+0x112/0x240 [irda]
Oct  5 14:38:20 taavi kernel:  [__crc_kernel_fpu_begin+118004989/289073630] irlap_state_xmit_p+0x1be/0x3d0 [irda]
Oct  5 14:38:20 taavi kernel:  [<e08f77ce>] irlap_state_xmit_p+0x1be/0x3d0 [irda]
Oct  5 14:38:20 taavi kernel:  [__crc_per_cpu__kstat+110642566/288634417] pci_pool_free+0x196/0x21e
Oct  5 14:38:20 taavi kernel:  [<c021ac76>] pci_pool_free+0x196/0x21e
Oct  5 14:38:20 taavi kernel:  [__crc_kernel_fpu_begin+117999935/289073630] irlap_do_event+0x150/0x280 [irda]
Oct  5 14:38:20 taavi kernel:  [<e08f6410>] irlap_do_event+0x150/0x280 [irda]
Oct  5 14:38:20 taavi kernel:  [__crc_kernel_fpu_begin+117990868/289073630] irlap_data_request+0x185/0x240 [irda]
Oct  5 14:38:20 taavi kernel:  [<e08f40a5>] irlap_data_request+0x185/0x240 [irda]
Oct  5 14:38:20 taavi kernel:  [__crc_kernel_fpu_begin+117983686/289073630] irlmp_state_dtr+0x1d7/0x320 [irda]
Oct  5 14:38:20 taavi kernel:  [<e08f2497>] irlmp_state_dtr+0x1d7/0x320 [irda]
Oct  5 14:38:20 taavi kernel:  [__crc_kernel_fpu_begin+117979648/289073630] irlmp_do_lsap_event+0x81/0xd0 [irda]
Oct  5 14:38:20 taavi kernel:  [<e08f14d1>] irlmp_do_lsap_event+0x81/0xd0 [irda]
Oct  5 14:38:20 taavi kernel:  [__crc_kernel_fpu_begin+117969979/289073630] irlmp_disconnect_request+0xac/0x260 [irda]
Oct  5 14:38:20 taavi kernel:  [<e08eef0c>] irlmp_disconnect_request+0xac/0x260 [irda]
Oct  5 14:38:20 taavi kernel:  [__crc_kernel_fpu_begin+118045084/289073630] irttp_disconnect_request+0xfd/0x220 [irda]
Oct  5 14:38:20 taavi kernel:  [<e090146d>] irttp_disconnect_request+0xfd/0x220 [irda]
Oct  5 14:38:20 taavi kernel:  [__crc_kernel_fpu_begin+117765958/289073630] ircomm_state_conn+0x97/0x100 [ircomm]
Oct  5 14:38:20 taavi kernel:  [<e08bd217>] ircomm_state_conn+0x97/0x100 [ircomm]
Oct  5 14:38:20 taavi kernel:  [__crc_kernel_fpu_begin+117766121/289073630] ircomm_do_event+0x3a/0x80 [ircomm]
Oct  5 14:38:20 taavi kernel:  [<e08bd2ba>] ircomm_do_event+0x3a/0x80 [ircomm]
Oct  5 14:38:20 taavi kernel:  [__crc_kernel_fpu_begin+117764005/289073630] ircomm_disconnect_request+0x76/0xb0 [ircomm]
Oct  5 14:38:20 taavi kernel:  [<e08bca76>] ircomm_disconnect_request+0x76/0xb0 [ircomm]
Oct  5 14:38:20 taavi kernel:  [__crc_kernel_fpu_begin+117807379/289073630] ircomm_tty_state_ready+0x74/0x110 [ircomm_tty]
Oct  5 14:38:20 taavi kernel:  [<e08c73e4>] ircomm_tty_state_ready+0x74/0x110 [ircomm_tty]
Oct  5 14:38:20 taavi kernel:  [__crc_kernel_fpu_begin+117807671/289073630] ircomm_tty_do_event+0x88/0xe0 [ircomm_tty]
Oct  5 14:38:20 taavi kernel:  [<e08c7508>] ircomm_tty_do_event+0x88/0xe0 [ircomm_tty]
Oct  5 14:38:20 taavi kernel:  [__crc_kernel_fpu_begin+117801967/289073630] ircomm_tty_detach_cable+0xc0/0x140 [ircomm_tty]
Oct  5 14:38:20 taavi kernel:  [<e08c5ec0>] ircomm_tty_detach_cable+0xc0/0x140 [ircomm_tty]
Oct  5 14:38:20 taavi kernel:  [__crc_kernel_fpu_begin+117797306/289073630] ircomm_tty_shutdown+0x11b/0x1d0 [ircomm_tty]
Oct  5 14:38:20 taavi kernel:  [<e08c4c8b>] ircomm_tty_shutdown+0x11b/0x1d0 [ircomm_tty]
Oct  5 14:38:20 taavi kernel:  [__crc_kernel_fpu_begin+117793284/289073630] ircomm_tty_close+0x225/0x390 [ircomm_tty]
Oct  5 14:38:20 taavi kernel:  [<e08c3cd5>] ircomm_tty_close+0x225/0x390 [ircomm_tty]
Oct  5 14:38:20 taavi kernel:  [__crc_per_cpu__kstat+110931502/288634417] tty_fasync+0x8e/0x140
Oct  5 14:38:20 taavi kernel:  [<c026151e>] tty_fasync+0x8e/0x140
Oct  5 14:38:20 taavi kernel:  [__crc_per_cpu__kstat+110929912/288634417] release_dev+0x6e8/0x740
Oct  5 14:38:20 taavi kernel:  [<c0260ee8>] release_dev+0x6e8/0x740
Oct  5 14:38:20 taavi kernel:  [__crc_per_cpu__kstat+109700048/288634417] do_timer+0xc0/0xd0
Oct  5 14:38:20 taavi kernel:  [<c0134ac0>] do_timer+0xc0/0xd0
Oct  5 14:38:20 taavi kernel:  [__crc_per_cpu__kstat+109541211/288634417] handle_IRQ_event+0x3b/0x70
Oct  5 14:38:20 taavi kernel:  [<c010de4b>] handle_IRQ_event+0x3b/0x70
Oct  5 14:38:20 taavi kernel:  [__crc_per_cpu__kstat+109542495/288634417] do_IRQ+0x12f/0x240
Oct  5 14:38:20 taavi kernel:  [<c010e34f>] do_IRQ+0x12f/0x240
Oct  5 14:38:20 taavi kernel:  [__crc_per_cpu__kstat+110931053/288634417] tty_release+0x3d/0xc0
Oct  5 14:38:20 taavi kernel:  [<c026135d>] tty_release+0x3d/0xc0
Oct  5 14:38:20 taavi kernel:  [__crc_per_cpu__kstat+109947725/288634417] __fput+0x12d/0x140
Oct  5 14:38:20 taavi kernel:  [<c017123d>] __fput+0x12d/0x140
Oct  5 14:38:20 taavi kernel:  [__crc_per_cpu__kstat+109940487/288634417] filp_close+0x57/0x80
Oct  5 14:38:20 taavi kernel:  [<c016f5f7>] filp_close+0x57/0x80
Oct  5 14:38:20 taavi kernel:  [__crc_per_cpu__kstat+109667004/288634417] put_files_struct+0x6c/0xe0
Oct  5 14:38:20 taavi kernel:  [<c012c9ac>] put_files_struct+0x6c/0xe0
Oct  5 14:38:20 taavi kernel:  [__crc_per_cpu__kstat+109671024/288634417] do_exit+0x210/0x5c0
Oct  5 14:38:20 taavi kernel:  [<c012d960>] do_exit+0x210/0x5c0
Oct  5 14:38:20 taavi kernel:  [__crc_per_cpu__kstat+109672391/288634417] do_group_exit+0x107/0x190
Oct  5 14:38:20 taavi kernel:  [<c012deb7>] do_group_exit+0x107/0x190
Oct  5 14:38:20 taavi kernel:  [__crc_per_cpu__kstat+109888664/288634417] sys_munmap+0x58/0x80
Oct  5 14:38:20 taavi kernel:  [<c0162b88>] sys_munmap+0x58/0x80
Oct  5 14:38:20 taavi kernel:  [__crc_per_cpu__kstat+109531963/288634417] syscall_call+0x7/0xb
Oct  5 14:38:20 taavi kernel:  [<c010ba2b>] syscall_call+0x7/0xb
Oct  5 14:38:20 taavi kernel: 
Oct  5 14:38:22 taavi kernel: Debug: sleeping function called from invalid context at include/asm/uaccess.h:498
Oct  5 14:38:22 taavi kernel: in_atomic():1, irqs_disabled():1
Oct  5 14:38:22 taavi kernel: Call Trace:
Oct  5 14:38:22 taavi kernel:  [__crc_per_cpu__kstat+109646988/288634417] __might_sleep+0x9c/0xc0
Oct  5 14:38:22 taavi kernel:  [<c0127b7c>] __might_sleep+0x9c/0xc0
Oct  5 14:38:22 taavi kernel:  [__crc_kernel_fpu_begin+117794782/289073630] ircomm_tty_write+0x16f/0x440 [ircomm_tty]
Oct  5 14:38:22 taavi kernel:  [<e08c42af>] ircomm_tty_write+0x16f/0x440 [ircomm_tty]
Oct  5 14:38:22 taavi kernel:  [__crc_per_cpu__kstat+110953954/288634417] write_chan+0x202/0x230
Oct  5 14:38:22 taavi kernel:  [<c0266cd2>] write_chan+0x202/0x230
Oct  5 14:38:22 taavi kernel:  [__crc_per_cpu__kstat+109636976/288634417] default_wake_function+0x0/0x30
Oct  5 14:38:22 taavi kernel:  [<c0125460>] default_wake_function+0x0/0x30
Oct  5 14:38:22 taavi kernel:  [__crc_per_cpu__kstat+109636976/288634417] default_wake_function+0x0/0x30
Oct  5 14:38:22 taavi kernel:  [<c0125460>] default_wake_function+0x0/0x30
Oct  5 14:38:22 taavi kernel:  [__crc_per_cpu__kstat+110925555/288634417] tty_write+0x293/0x3a0
Oct  5 14:38:22 taavi kernel:  [<c025fde3>] tty_write+0x293/0x3a0
Oct  5 14:38:22 taavi kernel:  [__crc_per_cpu__kstat+109698797/288634417] update_wall_time+0xd/0x40
Oct  5 14:38:22 taavi kernel:  [<c01345dd>] update_wall_time+0xd/0x40
Oct  5 14:38:22 taavi kernel:  [__crc_per_cpu__kstat+110953440/288634417] write_chan+0x0/0x230
Oct  5 14:38:22 taavi kernel:  [<c0266ad0>] write_chan+0x0/0x230
Oct  5 14:38:22 taavi kernel:  [__crc_per_cpu__kstat+109563117/288634417] timer_interrupt+0x9d/0x1e0
Oct  5 14:38:22 taavi kernel:  [<c01133dd>] timer_interrupt+0x9d/0x1e0
Oct  5 14:38:22 taavi kernel:  [__crc_per_cpu__kstat+109943597/288634417] vfs_write+0xad/0x120
Oct  5 14:38:22 taavi kernel:  [<c017021d>] vfs_write+0xad/0x120
Oct  5 14:38:22 taavi kernel:  [__crc_per_cpu__kstat+109943871/288634417] sys_write+0x3f/0x60
Oct  5 14:38:22 taavi kernel:  [<c017032f>] sys_write+0x3f/0x60
Oct  5 14:38:22 taavi kernel:  [__crc_per_cpu__kstat+109531963/288634417] syscall_call+0x7/0xb
Oct  5 14:38:22 taavi kernel:  [<c010ba2b>] syscall_call+0x7/0xb
Oct  5 14:38:22 taavi kernel: 
Oct  5 14:38:23 taavi kernel: Debug: sleeping function called from invalid context at include/asm/uaccess.h:498
Oct  5 14:38:23 taavi kernel: in_atomic():1, irqs_disabled():1
Oct  5 14:38:23 taavi kernel: Call Trace:
Oct  5 14:38:23 taavi kernel:  [__crc_per_cpu__kstat+109646988/288634417] __might_sleep+0x9c/0xc0
Oct  5 14:38:23 taavi kernel:  [<c0127b7c>] __might_sleep+0x9c/0xc0
Oct  5 14:38:23 taavi kernel:  [__crc_kernel_fpu_begin+117794782/289073630] ircomm_tty_write+0x16f/0x440 [ircomm_tty]
Oct  5 14:38:23 taavi kernel:  [<e08c42af>] ircomm_tty_write+0x16f/0x440 [ircomm_tty]
Oct  5 14:38:23 taavi kernel:  [__crc_per_cpu__kstat+109628900/288634417] recalc_task_prio+0xb4/0x1f0
Oct  5 14:38:23 taavi kernel:  [<c01234d4>] recalc_task_prio+0xb4/0x1f0
Oct  5 14:38:23 taavi kernel:  [__crc_per_cpu__kstat+110953954/288634417] write_chan+0x202/0x230
Oct  5 14:38:23 taavi kernel:  [<c0266cd2>] write_chan+0x202/0x230
Oct  5 14:38:23 taavi kernel:  [__crc_per_cpu__kstat+109636976/288634417] default_wake_function+0x0/0x30
Oct  5 14:38:23 taavi kernel:  [<c0125460>] default_wake_function+0x0/0x30
Oct  5 14:38:23 taavi kernel:  [__crc_per_cpu__kstat+109636976/288634417] default_wake_function+0x0/0x30
Oct  5 14:38:23 taavi kernel:  [<c0125460>] default_wake_function+0x0/0x30
Oct  5 14:38:23 taavi kernel:  [__crc_per_cpu__kstat+110925555/288634417] tty_write+0x293/0x3a0
Oct  5 14:38:23 taavi kernel:  [<c025fde3>] tty_write+0x293/0x3a0
Oct  5 14:38:23 taavi kernel:  [__crc_per_cpu__kstat+109698797/288634417] update_wall_time+0xd/0x40
Oct  5 14:38:23 taavi kernel:  [<c01345dd>] update_wall_time+0xd/0x40
Oct  5 14:38:23 taavi kernel:  [__crc_per_cpu__kstat+110953440/288634417] write_chan+0x0/0x230
Oct  5 14:38:23 taavi kernel:  [<c0266ad0>] write_chan+0x0/0x230
Oct  5 14:38:23 taavi kernel:  [__crc_per_cpu__kstat+109563117/288634417] timer_interrupt+0x9d/0x1e0
Oct  5 14:38:23 taavi kernel:  [<c01133dd>] timer_interrupt+0x9d/0x1e0
Oct  5 14:38:23 taavi kernel:  [__crc_per_cpu__kstat+109943597/288634417] vfs_write+0xad/0x120
Oct  5 14:38:23 taavi kernel:  [<c017021d>] vfs_write+0xad/0x120
Oct  5 14:38:23 taavi kernel:  [__crc_per_cpu__kstat+109943871/288634417] sys_write+0x3f/0x60
Oct  5 14:38:23 taavi kernel:  [<c017032f>] sys_write+0x3f/0x60
Oct  5 14:38:23 taavi kernel:  [__crc_per_cpu__kstat+109531963/288634417] syscall_call+0x7/0xb
Oct  5 14:38:23 taavi kernel:  [<c010ba2b>] syscall_call+0x7/0xb
Oct  5 14:38:23 taavi kernel: 
Oct  5 14:38:24 taavi kernel: Debug: sleeping function called from invalid context at include/asm/uaccess.h:498
Oct  5 14:38:24 taavi kernel: in_atomic():1, irqs_disabled():1
Oct  5 14:38:24 taavi kernel: Call Trace:
Oct  5 14:38:24 taavi kernel:  [__crc_per_cpu__kstat+109646988/288634417] __might_sleep+0x9c/0xc0
Oct  5 14:38:24 taavi kernel:  [<c0127b7c>] __might_sleep+0x9c/0xc0
Oct  5 14:38:24 taavi kernel:  [__crc_kernel_fpu_begin+117794782/289073630] ircomm_tty_write+0x16f/0x440 [ircomm_tty]
Oct  5 14:38:24 taavi kernel:  [<e08c42af>] ircomm_tty_write+0x16f/0x440 [ircomm_tty]
Oct  5 14:38:24 taavi kernel:  [__crc_per_cpu__kstat+110953954/288634417] write_chan+0x202/0x230
Oct  5 14:38:24 taavi kernel:  [<c0266cd2>] write_chan+0x202/0x230
Oct  5 14:38:24 taavi kernel:  [__crc_per_cpu__kstat+109636976/288634417] default_wake_function+0x0/0x30
Oct  5 14:38:24 taavi kernel:  [<c0125460>] default_wake_function+0x0/0x30
Oct  5 14:38:24 taavi kernel:  [__crc_per_cpu__kstat+109636976/288634417] default_wake_function+0x0/0x30
Oct  5 14:38:24 taavi kernel:  [<c0125460>] default_wake_function+0x0/0x30
Oct  5 14:38:24 taavi kernel:  [__crc_per_cpu__kstat+110925555/288634417] tty_write+0x293/0x3a0
Oct  5 14:38:24 taavi kernel:  [<c025fde3>] tty_write+0x293/0x3a0
Oct  5 14:38:24 taavi kernel:  [__crc_per_cpu__kstat+109698797/288634417] update_wall_time+0xd/0x40
Oct  5 14:38:24 taavi kernel:  [<c01345dd>] update_wall_time+0xd/0x40
Oct  5 14:38:24 taavi kernel:  [__crc_per_cpu__kstat+110953440/288634417] write_chan+0x0/0x230
Oct  5 14:38:24 taavi kernel:  [<c0266ad0>] write_chan+0x0/0x230
Oct  5 14:38:24 taavi kernel:  [__crc_per_cpu__kstat+109563117/288634417] timer_interrupt+0x9d/0x1e0
Oct  5 14:38:24 taavi kernel:  [<c01133dd>] timer_interrupt+0x9d/0x1e0
Oct  5 14:38:24 taavi kernel:  [__crc_per_cpu__kstat+109943597/288634417] vfs_write+0xad/0x120
Oct  5 14:38:24 taavi kernel:  [<c017021d>] vfs_write+0xad/0x120
Oct  5 14:38:24 taavi kernel:  [__crc_per_cpu__kstat+109943871/288634417] sys_write+0x3f/0x60
Oct  5 14:38:24 taavi kernel:  [<c017032f>] sys_write+0x3f/0x60
Oct  5 14:38:24 taavi kernel:  [__crc_per_cpu__kstat+109531963/288634417] syscall_call+0x7/0xb
Oct  5 14:38:24 taavi kernel:  [<c010ba2b>] syscall_call+0x7/0xb
Oct  5 14:38:24 taavi kernel: 
Oct  5 14:38:26 taavi kernel: Debug: sleeping function called from invalid context at include/asm/uaccess.h:498
Oct  5 14:38:26 taavi kernel: in_atomic():1, irqs_disabled():1
Oct  5 14:38:26 taavi kernel: Call Trace:
Oct  5 14:38:26 taavi kernel:  [__crc_per_cpu__kstat+109646988/288634417] __might_sleep+0x9c/0xc0
Oct  5 14:38:26 taavi kernel:  [<c0127b7c>] __might_sleep+0x9c/0xc0
Oct  5 14:38:26 taavi kernel:  [__crc_kernel_fpu_begin+117794782/289073630] ircomm_tty_write+0x16f/0x440 [ircomm_tty]
Oct  5 14:38:26 taavi kernel:  [<e08c42af>] ircomm_tty_write+0x16f/0x440 [ircomm_tty]
Oct  5 14:38:26 taavi kernel:  [__crc_per_cpu__kstat+110953954/288634417] write_chan+0x202/0x230
Oct  5 14:38:26 taavi kernel:  [<c0266cd2>] write_chan+0x202/0x230
Oct  5 14:38:26 taavi kernel:  [__crc_per_cpu__kstat+109636976/288634417] default_wake_function+0x0/0x30
Oct  5 14:38:26 taavi kernel:  [<c0125460>] default_wake_function+0x0/0x30
Oct  5 14:38:26 taavi kernel:  [__crc_per_cpu__kstat+109636976/288634417] default_wake_function+0x0/0x30
Oct  5 14:38:26 taavi kernel:  [<c0125460>] default_wake_function+0x0/0x30
Oct  5 14:38:26 taavi kernel:  [__crc_per_cpu__kstat+110925555/288634417] tty_write+0x293/0x3a0
Oct  5 14:38:26 taavi kernel:  [<c025fde3>] tty_write+0x293/0x3a0
Oct  5 14:38:26 taavi kernel:  [__crc_per_cpu__kstat+110953440/288634417] write_chan+0x0/0x230
Oct  5 14:38:26 taavi kernel:  [<c0266ad0>] write_chan+0x0/0x230
Oct  5 14:38:26 taavi kernel:  [__crc_per_cpu__kstat+109943597/288634417] vfs_write+0xad/0x120
Oct  5 14:38:26 taavi kernel:  [<c017021d>] vfs_write+0xad/0x120
Oct  5 14:38:26 taavi kernel:  [__crc_per_cpu__kstat+109943871/288634417] sys_write+0x3f/0x60
Oct  5 14:38:26 taavi kernel:  [<c017032f>] sys_write+0x3f/0x60
Oct  5 14:38:26 taavi kernel:  [__crc_per_cpu__kstat+109531963/288634417] syscall_call+0x7/0xb
Oct  5 14:38:26 taavi kernel:  [<c010ba2b>] syscall_call+0x7/0xb
Oct  5 14:38:26 taavi kernel: 
Oct  5 14:38:27 taavi kernel: Debug: sleeping function called from invalid context at include/asm/uaccess.h:498
Oct  5 14:38:27 taavi kernel: in_atomic():1, irqs_disabled():1
Oct  5 14:38:27 taavi kernel: Call Trace:
Oct  5 14:38:27 taavi kernel:  [__crc_per_cpu__kstat+109646988/288634417] __might_sleep+0x9c/0xc0
Oct  5 14:38:27 taavi kernel:  [<c0127b7c>] __might_sleep+0x9c/0xc0
Oct  5 14:38:27 taavi kernel:  [__crc_kernel_fpu_begin+117794782/289073630] ircomm_tty_write+0x16f/0x440 [ircomm_tty]
Oct  5 14:38:27 taavi kernel:  [<e08c42af>] ircomm_tty_write+0x16f/0x440 [ircomm_tty]
Oct  5 14:38:27 taavi kernel:  [__crc_per_cpu__kstat+109628520/288634417] kernel_map_pages+0x28/0x5c
Oct  5 14:38:27 taavi kernel:  [<c0123358>] kernel_map_pages+0x28/0x5c
Oct  5 14:38:27 taavi kernel:  [__crc_per_cpu__kstat+110953954/288634417] write_chan+0x202/0x230
Oct  5 14:38:27 taavi kernel:  [<c0266cd2>] write_chan+0x202/0x230
Oct  5 14:38:27 taavi kernel:  [__crc_per_cpu__kstat+109636976/288634417] default_wake_function+0x0/0x30
Oct  5 14:38:27 taavi kernel:  [<c0125460>] default_wake_function+0x0/0x30
Oct  5 14:38:27 taavi kernel:  [__crc_per_cpu__kstat+109636976/288634417] default_wake_function+0x0/0x30
Oct  5 14:38:27 taavi kernel:  [<c0125460>] default_wake_function+0x0/0x30
Oct  5 14:38:27 taavi kernel:  [__crc_per_cpu__kstat+110925555/288634417] tty_write+0x293/0x3a0
Oct  5 14:38:27 taavi kernel:  [<c025fde3>] tty_write+0x293/0x3a0
Oct  5 14:38:27 taavi kernel:  [__crc_per_cpu__kstat+110953440/288634417] write_chan+0x0/0x230
Oct  5 14:38:27 taavi kernel:  [<c0266ad0>] write_chan+0x0/0x230
Oct  5 14:38:27 taavi kernel:  [__crc_per_cpu__kstat+109943597/288634417] vfs_write+0xad/0x120
Oct  5 14:38:27 taavi kernel:  [<c017021d>] vfs_write+0xad/0x120
Oct  5 14:38:27 taavi kernel:  [__crc_per_cpu__kstat+109943871/288634417] sys_write+0x3f/0x60
Oct  5 14:38:27 taavi kernel:  [<c017032f>] sys_write+0x3f/0x60
Oct  5 14:38:27 taavi kernel:  [__crc_per_cpu__kstat+109531963/288634417] syscall_call+0x7/0xb
Oct  5 14:38:27 taavi kernel:  [<c010ba2b>] syscall_call+0x7/0xb
Oct  5 14:38:27 taavi kernel: 
Oct  5 14:38:28 taavi modprobe: FATAL: Module /dev/115200 not found. 
Oct  5 14:38:28 taavi pppd[2205]: pppd 2.4.1 started by mjkorhon, uid 501
Oct  5 14:38:28 taavi pppd[2205]: Using interface ppp0
Oct  5 14:38:28 taavi pppd[2205]: Connect: ppp0 <--> /dev/ircomm0
Oct  5 14:38:33 taavi pppd[2205]: local  IP address 62.78.120.205
Oct  5 14:38:33 taavi pppd[2205]: remote IP address 217.78.193.146
Oct  5 14:38:33 taavi pppd[2205]: primary   DNS address 217.78.192.22
Oct  5 14:38:33 taavi pppd[2205]: secondary DNS address 217.78.192.78

--------------090108070806020805010009--


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266910AbUHJP3C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266910AbUHJP3C (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 11:29:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267480AbUHJP3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 11:29:01 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:10931 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S266910AbUHJP0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 11:26:19 -0400
Message-ID: <4118E921.7040902@oracle.com>
Date: Tue, 10 Aug 2004 17:26:25 +0200
From: Alessandro Suardi <alessandro.suardi@oracle.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040323
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [OT] Cisco 4.0.5 VPN client prints non-fatal stack
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

...and works, as I'm currently connected via a 4.0.5 VPN tunnel.

VPN client 4.0.4.B works without printing the kernel messages.

Problem happens with 4.0.5 on both 2.6.8-rc3-bk4 and 2.6.8-rc4,
  didn't test earlier kernels.

Since I know Cisco people are reading this list, and in case
  someone else may be interested... I'm aware this may not be a
  Linux kernel problem at all, but just in case - h
ere it goes:

cisco_ipsec: module license 'Proprietary' taints kernel.
Cisco Systems VPN Client Version 4.0.5 (Rel) kernel module loaded
Badness in local_bh_enable at kernel/softirq.c:136
  [<c011942d>] local_bh_enable+0x62/0x81
  [<f9cfbf19>] handle_vpnup+0x8d/0x1b7 [cisco_ipsec]
  [<f9cfbca4>] interceptor_ioctl+0x133/0x161 [cisco_ipsec]
  [<c031e962>] dev_ifsioc+0x133/0x43d
  [<c031ee4b>] dev_ioctl+0x1df/0x336
  [<c0314cfd>] sock_ioctl+0x100/0x2c4
  [<c015f4e8>] sys_ioctl+0x148/0x280
  [<c0110620>] do_page_fault+0x0/0x570
  [<c0103d7d>] sysenter_past_esp+0x52/0x71
Badness in local_bh_enable at kernel/softirq.c:136
  [<c011942d>] local_bh_enable+0x62/0x81
  [<c031c712>] dev_remove_pack+0xf/0x17
  [<f9cfbf47>] handle_vpnup+0xbb/0x1b7 [cisco_ipsec]
  [<f9cfbca4>] interceptor_ioctl+0x133/0x161 [cisco_ipsec]
  [<c031e962>] dev_ifsioc+0x133/0x43d
  [<c031ee4b>] dev_ioctl+0x1df/0x336
  [<c0314cfd>] sock_ioctl+0x100/0x2c4
  [<c015f4e8>] sys_ioctl+0x148/0x280
  [<c0110620>] do_page_fault+0x0/0x570
  [<c0103d7d>] sysenter_past_esp+0x52/0x71
bad: scheduling while atomic!
  [<c038c99c>] schedule+0x498/0x4cb
  [<c0103f3c>] common_interrupt+0x18/0x20
  [<c011007b>] show_mem+0xb3/0x121
  [<c038ca83>] wait_for_completion+0x76/0xd0
  [<c01123b5>] default_wake_function+0x0/0x12
  [<c0124f1b>] __kernel_text_address+0x28/0x36
  [<c01123b5>] default_wake_function+0x0/0x12
  [<c010421f>] show_trace+0x5c/0x8e
  [<c0124a7b>] synchronize_kernel+0x31/0x36
  [<c0104304>] dump_stack+0x1c/0x20
  [<c0124a3e>] wakeme_after_rcu+0x0/0xc
  [<c031c712>] dev_remove_pack+0xf/0x17
  [<f9cfbf47>] handle_vpnup+0xbb/0x1b7 [cisco_ipsec]
  [<f9cfbca4>] interceptor_ioctl+0x133/0x161 [cisco_ipsec]
  [<c031e962>] dev_ifsioc+0x133/0x43d
  [<c031ee4b>] dev_ioctl+0x1df/0x336
  [<c0314cfd>] sock_ioctl+0x100/0x2c4
  [<c015f4e8>] sys_ioctl+0x148/0x280
  [<c0110620>] do_page_fault+0x0/0x570
  [<c0103d7d>] sysenter_past_esp+0x52/0x71


--alessandro

  "Practice is more important than theory. A _lot_ more important."
     (Linus Torvalds on lkml, 1 June 2004)


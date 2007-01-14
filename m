Return-Path: <linux-kernel-owner+w=401wt.eu-S1751177AbXANJtf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbXANJtf (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 04:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbXANJtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 04:49:35 -0500
Received: from www17.your-server.de ([213.133.104.17]:4723 "EHLO
	www17.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751177AbXANJte (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 04:49:34 -0500
Message-ID: <45A9FC73.2000105@m3y3r.de>
Date: Sun, 14 Jan 2007 10:48:35 +0100
From: Thomas Meyer <thomas@m3y3r.de>
User-Agent: Thunderbird 1.5.0.9 (X11/20061222)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: KVM: vmwrite error in
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: thomas@m3y3r.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I have a few of these entries in my log buffer:
vmwrite error: reg 6802 value d19e0464 (err 26626)
 [<c02413bf>] kvm_mmu_zap_page+0x8f/0x1d7
 [<c014c2cb>] __pagevec_free+0x18/0x22
 [<c0241517>] free_mmu_pages+0x10/0x81
 [<c02415c4>] kvm_mmu_destroy+0x3c/0x56
 [<c023f3a3>] kvm_free_vcpu+0x8/0x15
 [<c023f429>] kvm_dev_release+0x13/0x37
 [<c01640c9>] __fput+0xa5/0x14d
 [<c0161cb1>] filp_close+0x51/0x58
 [<c012104b>] put_files_struct+0x5f/0xa2
 [<c0122035>] do_exit+0x207/0x6ea
 [<c012897a>] __dequeue_signal+0xff/0x14e
 [<c012258d>] sys_exit_group+0x0/0xd
 [<c012a242>] get_signal_to_deliver+0x39f/0x3cb
 [<c0102499>] do_notify_resume+0x84/0x5f9
 [<c0106fc7>] convert_fxsr_from_user+0x1c/0xdc
 [<c01075a1>] restore_i387+0x74/0xcd
 [<c012850c>] sigprocmask+0xa1/0xc5
 [<c012a6d2>] sys_rt_sigprocmask+0x4b/0xc5
 [<c012a6d2>] sys_rt_sigprocmask+0x4b/0xc5
 [<c0102e87>] work_notifysig+0x13/0x18
 =======================

Look's like a stack trace, but no oops. What does this mean? this 
happens with kernel 2.6.20-rc4-gd39c9400 (two commits missing before 
rc5, nothing kvm related, so...)

-- 
Jabber-ID: thomas.mey@jabber.ccc.de


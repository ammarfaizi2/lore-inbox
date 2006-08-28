Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964801AbWH1WNR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbWH1WNR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 18:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964807AbWH1WNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 18:13:17 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:36784 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S964801AbWH1WNQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 18:13:16 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.18-rc4-mm3
Date: Tue, 29 Aug 2006 00:16:55 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
References: <20060826160922.3324a707.akpm@osdl.org>
In-Reply-To: <20060826160922.3324a707.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608290016.55410.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 27 August 2006 01:09, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm3/

I get things like the appended one on a regular basis at the system startup.

IIRC it has been reported for one of the previous -mm kernels, but it's still
there.


Adding 2104504k swap on /dev/hdc3.  Priority:-1 extents:1 across:2104504k
skge eth0: enabling interface
BUG: MAX_STACK_TRACE_ENTRIES too low!
turning off the locking correctness validator.

Call Trace:
 [<ffffffff8020b119>] dump_trace+0xb9/0x3d0
 [<ffffffff8020b473>] show_trace+0x43/0x60
 [<ffffffff8020b785>] dump_stack+0x15/0x20
 [<ffffffff802489a6>] save_trace+0xd6/0xf0
 [<ffffffff80248ad1>] add_lock_to_list+0x91/0xc0
 [<ffffffff8024ad31>] __lock_acquire+0xb01/0xd30
 [<ffffffff8024b2fb>] lock_acquire+0x8b/0xc0
 [<ffffffff80475b05>] _spin_lock_irq+0x35/0x50
 [<ffffffff80472aec>] schedule+0x16c/0x5ef
 [<ffffffff804734b7>] preempt_schedule_irq+0x57/0x90
 [<ffffffff8020a3f6>] retint_kernel+0x26/0x30
 [<ffffffff804740fb>] __mutex_lock_slowpath+0x23b/0x270
 [<ffffffff80474139>] mutex_lock+0x9/0x10
 [<ffffffff8821801a>] :snd_seq_device:snd_seq_device_info+0x1a/0xd0
 [<ffffffff8806be5e>] :snd:snd_info_entry_open+0x27e/0x360
 [<ffffffff8028d19c>] __dentry_open+0x13c/0x290
 [<ffffffff8028d39d>] nameidata_to_filp+0x2d/0x50
 [<ffffffff8028d3fd>] do_filp_open+0x3d/0x50
 [<ffffffff8028d46a>] do_sys_open+0x5a/0xf0
 [<ffffffff8028d52b>] sys_open+0x1b/0x20
 [<ffffffff80209d2e>] system_call+0x7e/0x83
 [<00002ab9c19f1722>]
 [<ffffffff802489a6>] save_trace+0xd6/0xf0
 [<ffffffff80248ad1>] add_lock_to_list+0x91/0xc0
 [<ffffffff8024ad31>] __lock_acquire+0xb01/0xd30
 [<ffffffff80472aec>] schedule+0x16c/0x5ef
 [<ffffffff8024b2fb>] lock_acquire+0x8b/0xc0
 [<ffffffff80472aec>] schedule+0x16c/0x5ef
 [<ffffffff80475b05>] _spin_lock_irq+0x35/0x50
 [<ffffffff80472aec>] schedule+0x16c/0x5ef
 [<ffffffff8024b3a9>] mark_held_locks+0x79/0xa0
 [<ffffffff804734b1>] preempt_schedule_irq+0x51/0x90
 [<ffffffff804734b7>] preempt_schedule_irq+0x57/0x90
 [<ffffffff8020a3f6>] retint_kernel+0x26/0x30
 [<ffffffff804740fb>] __mutex_lock_slowpath+0x23b/0x270
 [<ffffffff8047411d>] __mutex_lock_slowpath+0x25d/0x270
 [<ffffffff80474139>] mutex_lock+0x9/0x10
 [<ffffffff8821801a>] :snd_seq_device:snd_seq_device_info+0x1a/0xd0
 [<ffffffff8806be5e>] :snd:snd_info_entry_open+0x27e/0x360
 [<ffffffff8806bbe0>] :snd:snd_info_entry_open+0x0/0x360
 [<ffffffff8028d19c>] __dentry_open+0x13c/0x290
 [<ffffffff8028d39d>] nameidata_to_filp+0x2d/0x50
 [<ffffffff8028d3fd>] do_filp_open+0x3d/0x50
 [<ffffffff80475960>] _spin_unlock+0x30/0x60
 [<ffffffff8028cb58>] get_unused_fd+0xf8/0x110
 [<ffffffff803581fa>] strncpy_from_user+0x3a/0x50
 [<ffffffff8028d46a>] do_sys_open+0x5a/0xf0
 [<ffffffff8028d52b>] sys_open+0x1b/0x20
 [<ffffffff80209d2e>] system_call+0x7e/0x83

NET: Registered protocol family 17

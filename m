Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965024AbWHHSjG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965024AbWHHSjG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 14:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965028AbWHHSjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 14:39:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5051 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965024AbWHHSjD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 14:39:03 -0400
Date: Tue, 8 Aug 2006 14:38:56 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: lockdep spew
Message-ID: <20060808183856.GA4880@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I don't think I've seen this one reported yet.
This kernel was a 2.6.18rc3-gitSomething, but I don't think
anything has changed recently that would explain this?

		Dave

-- 
http://www.codemonkey.org.uk

--VbJkn9YxBvnuCH5J
Content-Type: message/rfc822
Content-Disposition: inline

Return-Path: <kernel-maint-admin@redhat.com>
X-Spam-Checker-Version: SpamAssassin 3.1.4 (2006-07-25) on 
	nwo.kernelslacker.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=5.0 tests=AWL,BAYES_00,NO_REAL_NAME,
	UNPARSEABLE_RELAY autolearn=no version=3.1.4
Received: from pobox.devel.redhat.com [10.11.255.8]
	by nwo.kernelslacker.org with IMAP (fetchmail-6.3.4)
	for <davej@localhost> (single-drop); Tue, 08 Aug 2006 11:52:12 -0400 (EDT)
Received: from pobox.devel.redhat.com ([unix socket])
	 by pobox.devel.redhat.com (Cyrus v2.2.12-Invoca-RPM-2.2.12-3.RHEL4.1) with LMTPA;
	 Tue, 08 Aug 2006 11:51:56 -0400
X-Sieve: CMU Sieve 2.2
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by pobox.devel.redhat.com (8.13.1/8.13.1) with ESMTP id k78FpuH5022032;
	Tue, 8 Aug 2006 11:51:56 -0400
Received: from post-office.corp.redhat.com (post-office.corp.redhat.com [172.16.52.227])
	by int-mx1.corp.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k78FpsGv001323;
	Tue, 8 Aug 2006 11:51:54 -0400
Received: from post-office.corp.redhat.com (localhost.localdomain [127.0.0.1])
	by post-office.corp.redhat.com (8.11.6/8.11.6) with ESMTP id k78FpsR21709;
	Tue, 8 Aug 2006 11:51:54 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by post-office.corp.redhat.com (8.11.6/8.11.6) with ESMTP id k78FaZR19518
	for <kernel-maint@post-office.corp.redhat.com>; Tue, 8 Aug 2006 11:36:35 -0400
Received: from mx1.redhat.com (mx1.redhat.com [172.16.48.31])
	by int-mx1.corp.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k78FaZ6q028664
	for <kernel-maint@redhat.com>; Tue, 8 Aug 2006 11:36:35 -0400
Received: from bugzilla.redhat.com (bugzilla.redhat.com [172.16.48.198])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k78FaYUl013200
	for <kernel-maint@redhat.com>; Tue, 8 Aug 2006 11:36:34 -0400
Received: from bugzilla.redhat.com (localhost.localdomain [127.0.0.1])
	by bugzilla.redhat.com (8.13.1/8.13.1) with ESMTP id k78FaY0M014528
	for <kernel-maint@redhat.com>; Tue, 8 Aug 2006 11:36:34 -0400
Received: (from apache@localhost)
	by bugzilla.redhat.com (8.13.1/8.12.11/Submit) id k78FaYnH014527;
	Tue, 8 Aug 2006 11:36:34 -0400
From: bugzilla@redhat.com
To: kernel-maint@redhat.com
Subject: [Bug 201726] New: massive kernel spewage with DWARF2 unwinder errors
Content-type: text/plain; charset=utf-8
Message-ID: <bug-201726-176318@bugzilla.redhat.com>
X-Loop: bugzilla@redhat.com
X-BeenThere: bugzilla@redhat.com
X-Bugzilla-Product: Fedora Core
X-Bugzilla-Version: fc6test2
X-Bugzilla-Component: kernel
X-Bugzilla-Comment: Public
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Changed-Fields: New
Sender: kernel-maint-admin@redhat.com
Errors-To: kernel-maint-admin@redhat.com
X-BeenThere: kernel-maint@redhat.com
X-Mailman-Version: 2.0.13
Precedence: bulk
List-Help: <mailto:kernel-maint-request@redhat.com?subject=help>
List-Post: <mailto:kernel-maint@redhat.com>
List-Subscribe: <http://post-office.corp.redhat.com/mailman/listinfo/kernel-maint>,
	<mailto:kernel-maint-request@redhat.com?subject=subscribe>
List-Id: <kernel-maint.redhat.com>
List-Unsubscribe: <http://post-office.corp.redhat.com/mailman/listinfo/kernel-maint>,
	<mailto:kernel-maint-request@redhat.com?subject=unsubscribe>
List-Archive: <http://post-office.corp.redhat.com/mailman/private/kernel-maint/>
Date: Tue, 8 Aug 2006 11:36:34 -0400

Please do not reply directly to this email. All additional
comments should be made in the comments box of this bug report.




https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=201726

           Summary: massive kernel spewage with DWARF2 unwinder errors
           Product: Fedora Core
           Version: fc6test2
          Platform: x86_64
        OS/Version: Linux
            Status: NEW
          Severity: high
          Priority: normal
         Component: kernel
        AssignedTo: kernel-maint@redhat.com
        ReportedBy: netllama@gmail.com
         QAContact: bbrock@redhat.com
                CC: wtogami@redhat.com


Description of problem:


Version-Release number of selected component (if applicable):
2.6.17-1.2517.fc6 and 2.6.17-1.2530.fc6

How reproducible:


Steps to Reproduce:
1. Boot, and the fireworks begin early on at "checking if image is initramfs..."
2. Even after booting, there's a ton more spewage, seemingly at random when
doing things as simple as ssh/scp, and also when running the attached sysreport.

  
Actual results:

#######
checking if image is initramfs...
=============================================
[ INFO: possible recursive locking detected ]
---------------------------------------------
swapper/1 is trying to acquire lock:
 (&nc->lock){....}, at: [<ffffffff8020782c>] kmem_cache_free+0x1a1/0x26c

but task is already holding lock:
 (&nc->lock){....}, at: [<ffffffff8020b47e>] kfree+0x1b3/0x27e

other info that might help us debug this:
2 locks held by swapper/1:
 #0:  (&nc->lock){....}, at: [<ffffffff8020b47e>] kfree+0x1b3/0x27e
 #1:  (&parent->list_lock){....}, at: [<ffffffff802dae22>]
__drain_alien_cache+0x37/0
x77

stack backtrace:

Call Trace:
 [<ffffffff8026e77d>] show_trace+0xae/0x30e
 [<ffffffff8026e9f2>] dump_stack+0x15/0x17
 [<ffffffff802a7f23>] __lock_acquire+0x135/0xa54
 [<ffffffff802a8de3>] lock_acquire+0x4b/0x69
 [<ffffffff8026774b>] _spin_lock+0x25/0x31
 [<ffffffff8020782c>] kmem_cache_free+0x1a1/0x26c
 [<ffffffff802da9a8>] slab_destroy+0x12b/0x138
 [<ffffffff802dab5f>] free_block+0x1aa/0x1ee
 [<ffffffff802dae48>] __drain_alien_cache+0x5d/0x77
 [<ffffffff8020b49b>] kfree+0x1d0/0x27e
 [<ffffffff80968444>] free+0x9/0xb
 [<ffffffff80968461>] huft_free+0x1b/0x27
 [<ffffffff8096961c>] inflate_dynamic+0x4f0/0x525
 [<ffffffff80969b18>] unpack_to_rootfs+0x4c7/0x930
 [<ffffffff80969fe6>] populate_rootfs+0x65/0xe7
 [<ffffffff8026d710>] init+0x190/0x3cd
 [<ffffffff8026135e>] child_rip+0x8/0x12
DWARF2 unwinder stuck at child_rip+0x8/0x12
Leftover inexact backtrace:
 [<ffffffff80267a32>] _spin_unlock_irq+0x2b/0x31
 [<ffffffff8026099c>] restore_args+0x0/0x30
 [<ffffffff8036c696>] acpi_os_acquire_lock+0x9/0xb
 [<ffffffff8026d580>] init+0x0/0x3cd
 [<ffffffff80261356>] child_rip+0x0/0x12

 it is
##############

############
                                                       sibling
  task                 PC          pid father child younger older
init          S ffff8101442eda08     0     1      0     2               (NOTLB)
 ffff8101442eda08 ffff8101442ed988 ffffffff806c0d80 0000000000000008
 ffff81013fc6a040 ffffffff80567e80 000000a047ea2983 0000000000015fe9
 ffff81013fc6a228 ffff810100000000 ffffffff806c0d80 ffff8101442eda08
Call Trace:
 [<ffffffff80265886>] schedule_timeout+0x8c/0xb3
 [<ffffffff8021204c>] do_select+0x470/0x4de
 [<ffffffff802e705b>] core_sys_select+0x1b7/0x266
 [<ffffffff80217106>] sys_select+0x147/0x172
 [<ffffffff8026040e>] system_call+0x7e/0x83
DWARF2 unwinder stuck at system_call+0x7e/0x83
Leftover inexact backtrace:

migration/0   S ffff81013fc77e98     0     2      1             3       (L-TLB)
 ffff81013fc77e98 0000000100000296 0000000000000002 0000000000000001
 ffff8101442ea040 ffffffff80567e80 000000a0598b50f5 000000000000119a
 ffff8101442ea228 ffff810100000000 0000000000000046 ffff81013fc77e78
Call Trace:
 [<ffffffff80246a22>] migration_thread+0x1a2/0x23f
 [<ffffffff802353fe>] kthread+0x100/0x136
 [<ffffffff8026135e>] child_rip+0x8/0x12
DWARF2 unwinder stuck at child_rip+0x8/0x12
Leftover inexact backtrace:
 [<ffffffff80267a32>] _spin_unlock_irq+0x2b/0x31
 [<ffffffff8026099c>] restore_args+0x0/0x30
 [<ffffffff802352fe>] kthread+0x0/0x136
 [<ffffffff80261356>] child_rip+0x0/0x12
#########

Expected results:
No spewage

Additional info:
I'm seeing all of this behavior on an HP xw9300 workstation

------- Additional Comments From netllama@gmail.com  2006-08-08 11:27 EST -------
Created an attachment (id=133794)
 --> (https://bugzilla.redhat.com/bugzilla/attachment.cgi?id=133794&action=view)
dmesg which includes the copious backtraces


-- 
Configure bugmail: https://bugzilla.redhat.com/bugzilla/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.

--VbJkn9YxBvnuCH5J--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262719AbUJ0Uym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262719AbUJ0Uym (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 16:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbUJ0Uwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 16:52:45 -0400
Received: from zamok.crans.org ([138.231.136.6]:64712 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id S262710AbUJ0UhG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 16:37:06 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: axboe@suse.de, jfannin1@columbus.rr.com, agk@redhat.com,
       christophe@saout.de, linux-kernel@vger.kernel.org, bzolnier@gmail.com
Subject: Re: 2.6.9-mm1: LVM stopped working (dio-handle-eof.patch)
References: <87oeitdogw.fsf@barad-dur.crans.org>
	<1098731002.14877.3.camel@leto.cs.pocnet.net>
	<20041026123651.GA2987@zion.rivenstone.net>
	<20041026135955.GA9937@agk.surrey.redhat.com>
	<20041026213703.GA6174@rivenstone.net>
	<20041026151559.041088f1.akpm@osdl.org>
	<87hdogvku7.fsf@barad-dur.crans.org>
	<20041026222650.596eddd8.akpm@osdl.org>
	<20041027054741.GB15910@suse.de> <20041027064146.GG15910@suse.de>
	<877jpcgolt.fsf@barad-dur.crans.org>
	<20041027132422.760d5f5e.akpm@osdl.org>
From: Mathieu Segaud <matt@minas-morgul.org>
Date: Wed, 27 Oct 2004 22:37:04 +0200
In-Reply-To: <20041027132422.760d5f5e.akpm@osdl.org> (Andrew Morton's message
	of "Wed, 27 Oct 2004 13:24:22 -0700")
Message-ID: <87fz3zkidr.fsf@barad-dur.crans.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> disait dernièrement que :

> Could someone pleeeeze send out a simple recipe for repeating this problem?

Well, as soon as the boot scripts "initializes" an LVM2 volume group;

just create one with vgcreate(8) from the lvm2 tools (I guess it'd fail under
faulty kernels like the latest -mm's).
Then boot 2.6.9-mm1 or 2.6.10-rc1-mm1, either the distro specific init scripts
will yield an error (No volume groups found), or just issue 'vgchange -a y',
to activate all available volume groups, and it will fail with the above error.

In my case, no kernel messages in dmesg related to these errors.
-- 
printk("----------- [cut here ] --------- [please bite here ] ---------\n");
        linux-2.6.6/arch/x86_64/kernel/traps.


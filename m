Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265110AbTFMDXa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 23:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265113AbTFMDXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 23:23:30 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:55717 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S265110AbTFMDX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 23:23:29 -0400
Date: Fri, 13 Jun 2003 13:37:03 +1000
From: CaT <cat@zip.com.au>
To: swsusp@lister.fornax.hu
Cc: linux-kernel@vger.kernel.org, pavel@suse.cz
Subject: 2.5.70-bk16 - nfs interferes with s4bios suspend
Message-ID: <20030613033703.GA526@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not too sure which list to send this to exactly so here goes. I go
my laptop back from warranty repair and it was returned with an old
version of the bios that still had suspend-2-disk capability in it.
Having set everything up I hit the suspend button and all seemed to
go ok upto a point:

==mutt entered refrigerator
=mutt entered refrigerator
=mutt entered refrigerator
=mutt entered refrigerator
=mutt entered refrigerator
=mutt entered refrigerator
=mutt entered refrigerator
=tail entered refrigerator
=
 stopping tasks failed (2 tasks remaining)
Suspend failed: Not all processes stopped!
Restarting tasks...<6> Strange, rpciod not stopped
 Strange, lockd not stopped
XFree86 left refrigerator
init left refrigerator
khubd left refrigerator

then it kept unfreezing my tasks till the following debug stuff 
came up:

tail left refrigerator
pdflush left refrigerator
 done
Debug: sleeping function called from illegal context at include/linux/rwsem.h:43
Call Trace:
 [<c011a2a3>] __might_sleep+0x5f/0x6c
 [<c01179b6>] do_page_fault+0x76/0x40a
 [<c0117940>] do_page_fault+0x0/0x40a
 [<c0142d1f>] shmem_nopage+0x33/0x68
 [<c01416a7>] pte_chain_alloc+0x1b/0x84
 [<c01fcbc8>] __copy_from_user_ll+0x60/0x78
 [<c010b0f0>] sys_vm86old+0xfc/0x10c
 [<c0108fe9>] error_code+0x2d/0x38
 [<c0108e3f>] syscall_call+0x7/0xb

Debug: sleeping function called from illegal context at include/linux/rwsem.h:43
Call Trace:
 [<c011a2a3>] __might_sleep+0x5f/0x6c
 [<c01179b6>] do_page_fault+0x76/0x40a
 [<c0117940>] do_page_fault+0x0/0x40a
 [<c0142d1f>] shmem_nopage+0x33/0x68
 [<c01416a7>] pte_chain_alloc+0x1b/0x84
 [<c01fcbc8>] __copy_from_user_ll+0x60/0x78
 [<c010b0f0>] sys_vm86old+0xfc/0x10c
 [<c0108fe9>] error_code+0x2d/0x38
 [<c0108e3f>] syscall_call+0x7/0xb

Laptop seems to be working fine still. X and networking are going ok. The
nfs mounts still function (laptop is a client with 3 nfs mounts).

-- 
Martin's distress was in contrast to the bitter satisfaction of some
of his fellow marines as they surveyed the scene. "The Iraqis are sick
people and we are the chemotherapy," said Corporal Ryan Dupre. "I am
starting to hate this country. Wait till I get hold of a friggin' Iraqi.
No, I won't get hold of one. I'll just kill him."
	- http://www.informationclearinghouse.info/article2479.htm

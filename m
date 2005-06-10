Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262524AbVFJNxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262524AbVFJNxZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 09:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262525AbVFJNxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 09:53:25 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:26530 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S262524AbVFJNxQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 09:53:16 -0400
Date: Fri, 10 Jun 2005 14:53:10 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PATCH] drm fixes needed before 2.6.12 gets released..
Message-ID: <Pine.LNX.4.58.0506101443410.11775@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've created a tree with two patches, one is a new PCI ID for i945G
chipset, the other fixes a bug in the IRQ handler for Radeon (a more
complete fix is worked out but this is the most I'm willing to commit
without more testing...

Please pull from:

rsync://rsync.kernel.org/pub/scm/linux/kernel/git/airlied/drm-2.6.git

I'll reply to this mail with the patch for completeness.

Dave.

 drm_pciids.h |    1 +
 radeon_irq.c |    5 -----
 2 files changed, 1 insertion(+), 5 deletions(-)

commit 74e8ebc55d85ca1acb3e73610965bea63cc39054
tree 7408fb2a44074fc8d7b7d1458e4b4c260b3fa41a
parent e98ded32f37a538b906d98059b3db71be36405a7
author Dave Airlie <airlied@starflyer.(none)> Fri, 10 Jun 2005 19:27:51 +1000
committer Dave Airlie <airlied@linux.ie> Fri, 10 Jun 2005 19:27:51 +1000

[PATCH] remove bogus hack from radeon IRQ handler

This removes a bogus hack from the radeon IRQ handler.
There is a better fix from myself and benh in DRM CVS but I'll wait
until 2.6.13-rc so it gets more testing.

Signed-off-by: Dave Airlie <airlied@linux.ie>

--------------------------
commit e98ded32f37a538b906d98059b3db71be36405a7
tree 7cfd5a685b0ddc1f83a2087b918a184cfca3d073
parent 8be3de3fd8469154a2b3e18a4712032dac5b4a53
author Dave Airlie <airlied@starflyer.(none)> Fri, 10 Jun 2005 18:47:38 +1000
committer Dave Airlie <airlied@linux.ie> Fri, 10 Jun 2005 18:47:38 +1000

[PATCH] drm add i945G pci id

Add pci identifier for i945G chipset

Signed-off-by: Dave Airlie <airlied@linux.ie>

--------------------------

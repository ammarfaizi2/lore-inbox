Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261523AbVF1Xni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261523AbVF1Xni (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 19:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262221AbVF1Xmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 19:42:39 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:21276 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S261523AbVF1XDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 19:03:51 -0400
X-IronPort-AV: i="3.93,240,1115017200"; 
   d="scan'208"; a="195037086:sNHT26254680"
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH 00/16] Add InfiniBand userspace verbs (direct userspace access)
X-Mailer: Roland's Patchbomber
Date: Tue, 28 Jun 2005 16:03:43 -0700
Message-Id: <2005628163.H103BaveG8tYGzYQ@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <rolandd@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a series of patches that adds support for direct userspace access to
InfiniBand hardware -- so-called "userspace verbs."  I believe these patches
are ready to merge, but a final review would be useful.

These patches should incorporate all of the feedback from the discussion when
I posted an earlier version back in April (see
http://lkml.org/lkml/2005/4/4/267 for the start of the thread).  In
particular, memory pinned for use by userspace is accounted for in
current->mm->vm_locked and requests to pin memory are checked against
RLIMIT_MEMLOCK.

Thanks,
  Roland

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbUDHNlt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 09:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbUDHNlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 09:41:49 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:46417 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261785AbUDHNlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 09:41:37 -0400
Date: Thu, 8 Apr 2004 14:41:34 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrea Arcangeli <andrea@suse.de>
cc: parisc-linux@parisc-linux.org, <linux-kernel@vger.kernel.org>
Subject: rmap: parisc __flush_dcache_page
Message-ID: <Pine.LNX.4.44.0404081422380.7010-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Something to notice about that parisc __flush_dcache_page I sent you:
there's no locking around searching the tree for vmas; there was never
any locking around searching the list for vmas.  arm is similar, but
at least has no CONFIG_SMP, just a preemption issue.  Any ideas?

Thanks,
Hugh


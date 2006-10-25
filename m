Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161315AbWJYA6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161315AbWJYA6i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 20:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161317AbWJYA6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 20:58:38 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:14209
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1161315AbWJYA6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 20:58:37 -0400
Date: Tue, 24 Oct 2006 17:57:51 -0700 (PDT)
Message-Id: <20061024.175751.07640578.davem@davemloft.net>
To: linux-kernel@vger.kernel.org
Subject: ext3 oops on shutdown
From: David Miller <davem@davemloft.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just started to see the following ext3 umount() oops on
shutdown, it happens every shutdown, has anyone else seen
it?

I'll start bisecting soon... this was on sparc64.

free_block()+0x50/0x190
cache_flusharray()+0x74/0xa0
kmem_cache_free()
journal_destroy_revoke()
journal_destroy()
ext3_put_super()
generic_shutdown_super()
kill_block_super()
deactivate_super()
sys_umount()

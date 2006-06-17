Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932439AbWFQHRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbWFQHRM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 03:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbWFQHRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 03:17:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:40121 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932439AbWFQHRM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 03:17:12 -0400
Date: Sat, 17 Jun 2006 09:17:00 +0200
From: Nick Piggin <npiggin@suse.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: kiran@scalex86.org, cgrunden@kilgore.edu
Subject: lockless pagecache patch for 2.6.17-rc6
Message-ID: <20060617071700.GC14452@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've uploaded my latest lockless pagecache patch for 2.6.17-rc6.

This includes a couple of fixes for lockless radix-tree bugs that
we think the ScaleMP guys ran into (unconfirmed, but they do fix
real bugs). The issue was just that some of the gang lookups
were using the unsafe root->height rather than the lock-free-safe
node->height fields.

ftp://ftp.kernel.org/pub/linux/kernel/people/npiggin/patches/lockless/2.6.17-rc6/lockless.patch

Thanks,
Nick


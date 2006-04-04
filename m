Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932424AbWDDJbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbWDDJbq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 05:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbWDDJbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 05:31:46 -0400
Received: from mail.suse.de ([195.135.220.2]:45745 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932424AbWDDJbp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 05:31:45 -0400
From: Nick Piggin <npiggin@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Nick Piggin <npiggin@suse.de>,
       Linux Memory Management <linux-mm@kvack.org>
Message-Id: <20060219020140.9923.43378.sendpatchset@linux.site>
Subject: [patch 0/3] lockless pagecache
Date: Tue,  4 Apr 2006 11:31:42 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'd like to submit the lockless pagecache for -mm. A scan through -mm
reveals that there shouldn't be any problems, except for reiser4, which
looks like it has a broken ->releasepage (it shouldn't be removing the
page from pagecache itself).

Thanks,
Nick

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261911AbTCQUhw>; Mon, 17 Mar 2003 15:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261914AbTCQUhw>; Mon, 17 Mar 2003 15:37:52 -0500
Received: from comtv.ru ([217.10.32.4]:35549 "EHLO comtv.ru")
	by vger.kernel.org with ESMTP id <S261911AbTCQUhv>;
	Mon, 17 Mar 2003 15:37:51 -0500
X-Comment-To: Andrew Morton
To: Andrew Morton <akpm@digeo.com>
Cc: Matthew Wilcox <willy@debian.org>, adilger@clusterfs.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] [PATCH] distributed counters for ext2 to avoid group scaning
References: <m3el5773to.fsf@lexa.home.net>
	<20030316104447.D12806@schatzie.adilger.int>
	<m3bs0bugca.fsf@lexa.home.net>
	<20030317151108.GC28607@parcelfarce.linux.theplanet.co.uk>
	<m3ptoqjagt.fsf@lexa.home.net>
	<20030317152719.GD28607@parcelfarce.linux.theplanet.co.uk>
	<20030317122357.41df48a9.akpm@digeo.com>
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: 17 Mar 2003 23:40:12 +0300
In-Reply-To: <20030317122357.41df48a9.akpm@digeo.com>
Message-ID: <m3of49682b.fsf@lexa.home.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi!

>>>>> Andrew Morton (AM) writes:

 AM> Which is why I'm waiting to see some profiles and benchmarks.
 AM> Judging from the last set of profiles, in which
 AM> ext2_count_free_blocks() was not present, this may not be
 AM> justified.

first of all, ext2_count_free_blocks() is used by orlov allocator
only which in turn is used to create dirs only. so, I do not think
dbench may show possible improvement. also, I understand it isn't
bottleneck absolutely, but I think it may reduce memory footprint.
Probably, we may use dcounters for huge fs only (i.e. make it
optional).

with best regards, Alex


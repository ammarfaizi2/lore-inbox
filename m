Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261715AbTCQPH1>; Mon, 17 Mar 2003 10:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261720AbTCQPH1>; Mon, 17 Mar 2003 10:07:27 -0500
Received: from comtv.ru ([217.10.32.4]:55765 "EHLO comtv.ru")
	by vger.kernel.org with ESMTP id <S261715AbTCQPH0>;
	Mon, 17 Mar 2003 10:07:26 -0500
X-Comment-To: Matthew Wilcox
To: Matthew Wilcox <willy@debian.org>
Cc: Andreas Dilger <adilger@clusterfs.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, Andrew Morton <akpm@digeo.com>
Subject: Re: [Ext2-devel] [PATCH] distributed counters for ext2 to avoid group scaning
References: <m3el5773to.fsf@lexa.home.net>
	<20030316104447.D12806@schatzie.adilger.int>
	<m3bs0bugca.fsf@lexa.home.net>
	<20030317151108.GC28607@parcelfarce.linux.theplanet.co.uk>
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: 17 Mar 2003 18:09:54 +0300
In-Reply-To: <20030317151108.GC28607@parcelfarce.linux.theplanet.co.uk>
Message-ID: <m3ptoqjagt.fsf@lexa.home.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Matthew Wilcox (MW) writes:
 MW> And then we have 3 of these (an additional 3k..).  Per
 MW> blockgroup.  My 4GB / has 30 blockgroups; my 30GB /home has 232.
 MW> So that's a little under 8 per GB.  My _laptop_ has a 40GB drive,
 MW> so that's on the order of 320 blockgroups -- almost an additional
 MW> megabyte of ram consumed for these counters.

no-no!

_one_ dcounter to maintain number of free blocks _per_ fs.
_one_ dcounter to maintain number of inode blocks _per_ fs.
_one_ dcounter to maintain number of dirs _per_ fs.

3 dcounter per fs. no more.





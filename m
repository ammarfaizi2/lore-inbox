Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262621AbTCNVLv>; Fri, 14 Mar 2003 16:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262622AbTCNVLv>; Fri, 14 Mar 2003 16:11:51 -0500
Received: from comtv.ru ([217.10.32.4]:40859 "EHLO comtv.ru")
	by vger.kernel.org with ESMTP id <S262621AbTCNVLv>;
	Fri, 14 Mar 2003 16:11:51 -0500
X-Comment-To: Andreas Dilger
To: Andreas Dilger <adilger@clusterfs.com>
Cc: Alex Tomas <bzzz@tmi.comex.ru>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] concurrent block allocation for ext2 against 2.5.64
References: <m3el5bmyrf.fsf@lexa.home.net>
	<20030313015840.1df1593c.akpm@digeo.com>
	<m3of4fgjob.fsf@lexa.home.net>
	<20030313165641.H12806@schatzie.adilger.int>
	<m38yvixvlz.fsf@lexa.home.net>
	<20030314135910.P12806@schatzie.adilger.int>
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: 15 Mar 2003 00:14:36 +0300
In-Reply-To: <20030314135910.P12806@schatzie.adilger.int>
Message-ID: <m31y198xc3.fsf@lexa.home.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Andreas Dilger (AD) writes:

 AD> Could you make it a pre-requisite to the concurrent-alloc patch?
 AD> That would make it a shoo-in to being accepted (cleans up code
 AD> nicely).

Andrew already asked to wait until next -mm

 AD> The point of having the reserved blocks is to reduce
 AD> fragmentation in file allocation.  Having per-group reserved
 AD> blocks is a good idea, because it keeps the reserved "slack" per
 AD> group, and helps file allocations within that group have a bit of
 AD> free space in which to grow.  If you are reserving all of the
 AD> blocks at the end of the filesystem, then the earlier groups will
 AD> become 100% allocated prematurely and lose any ability to keep
 AD> files there contiguous.

well. looks like I miss something here. I thought reservation is not
allocation policy, but mechanism to protect some user (root, usually)
from fs overflow


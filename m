Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263818AbUDOGXd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 02:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263843AbUDOGXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 02:23:33 -0400
Received: from citrine.spiritone.com ([216.99.193.133]:8367 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S263832AbUDOGXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 02:23:33 -0400
Date: Wed, 14 Apr 2004 23:23:23 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       Andrea Arcangeli <andrea@suse.de>
cc: Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] anobjrmap 9 priority mjb tree
Message-ID: <35840000.1082010202@[10.10.2.4]>
In-Reply-To: <Pine.GSO.4.58.0404142323160.21462@sapphire.engin.umich.edu>
References: <Pine.LNX.4.44.0404122006050.10504-100000@localhost.localdomain><Pine.LNX.4.58.0404121531580.15512@red.engin.umich.edu> <69200000.1081804458@flay><Pine.LNX.4.58.0404141616530.25848@rust.engin.umich.edu><20040415000529.GX2150@dualathlon.random> <Pine.GSO.4.58.0404142323160.21462@sapphire.engin.umich.edu>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Wherease my solution will allow multiple modifications at the same
> time (if possible) with only one pageout routine at a time. I chose
> this solution because Martin's SDET took big hit in common cases of
> adding and removing vmas from the i_mmap{_shared} data structure.

FYI, even without prio-tree, I get a 12% boost from converting i_shared_sem
into a spinlock. I'll try doing the same on top of prio-tree next.

M.


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287467AbRLaIyj>; Mon, 31 Dec 2001 03:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287474AbRLaIy2>; Mon, 31 Dec 2001 03:54:28 -0500
Received: from [202.54.26.202] ([202.54.26.202]:49871 "EHLO hindon.hss.co.in")
	by vger.kernel.org with ESMTP id <S287468AbRLaIyO>;
	Mon, 31 Dec 2001 03:54:14 -0500
X-Lotus-FromDomain: HSS
From: alad@hss.hns.com
To: linux-kernel@vger.kernel.org
Message-ID: <65256B33.0030D102.00@sandesh.hss.hns.com>
Date: Mon, 31 Dec 2001 14:18:28 +0530
Subject: max_mapped logic in shrink_cache()
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,
we have in vmscan.c::shrink_cache() --
max_mapped = nr_pages << (9 - priority);

Here is the basic logic, in the time of high memory loads priority shall be
less, consequently max_mapped shall be more.
Thus in case of high memory pressure, instead of decreasing max_mapped we are
increasing it, thus invoking out_of_memory() when we could easily have called
swap_out().

what is the logic of increasing max_mapped when priority is decreased..

-- Amol




Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262837AbTCKFFu>; Tue, 11 Mar 2003 00:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262839AbTCKFFu>; Tue, 11 Mar 2003 00:05:50 -0500
Received: from holomorphy.com ([66.224.33.161]:31672 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262837AbTCKFFt>;
	Tue, 11 Mar 2003 00:05:49 -0500
Date: Mon, 10 Mar 2003 21:15:11 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: pgcl-2.5.64-[345]
Message-ID: <20030311051511.GM465@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pgcl-2.5.64-3:
(1) remove some debug checks from rmap and highmem functions
(2) mitigate anonymous page fragmentation in do_anonymous_page()
	this heuristic is still not entirely effective

pgcl-2.5.64-4:
(1) edit all PTE's pointed at a given page at swap fault time
(2) comment some TODO items
(3) remove WARN_ON()'s triggered by PTE allocation fallback to lowmem

pgcl-2.5.64-5:
(1) re-sweep arch/i386/kernel/cpu/mtrr/ for PAGE_SIZE vs. MMUPAGE_SIZE
	MTRR code basically wants MMUPAGE_SIZE in all cases

As usual, available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/wli/vm/pgcl/

The fault-time antifragmentation heuristics here are largely ineffective.
Most of this will have to be revisited, but if you were seeing issues with
MTRR's or spurious WARN_ON()'s from PTE allocation fallback to ZONE_NORMAL,
these updates should help. Incremental atop prior 2.5.64 pgcl patches.

-- wli

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267268AbTCEQNd>; Wed, 5 Mar 2003 11:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267274AbTCEQNd>; Wed, 5 Mar 2003 11:13:33 -0500
Received: from holomorphy.com ([66.224.33.161]:12190 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267268AbTCEQNc>;
	Wed, 5 Mar 2003 11:13:32 -0500
Date: Wed, 5 Mar 2003 08:23:49 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: pgcl-2.5.64-[12]
Message-ID: <20030305162349.GF1399@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pgcl-2.5.64-1 includes the mprotect() fix from 2.5.63-based patches,
as well as an initial attempt at restoring swap functionality.

pgcl-2.5.64-2 fixes up the initial attempt at swapping so it actually
passes touch testing. Whether shmem.c handles this properly is
uncertain, but nothing obvious stands out as being in need of repair.

I bumped down PAGE_SIZE to 32K, 64K appeared to trigger issues with
qlogicisp.c on NUMA-Q. That may or may not eventually get fixed. It'd
certainly be interesting to go beyond the limits of the 2.4 patch.
Dealing with q->max_sectors*512 < PAGE_SIZE in a generic fashion looks
painful, and the driver is crusty, so swapping hardware sound good.

If this really holds up and there aren't enough fs or driver issues
to keep me occupied I might actually start dealing with performance
issues wrt. fragmentation of anonymous memory and L3 pagetables.
(Well, they're L2 pagetables in the nomenclature starting at L0.)

As usual, available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/wli/vm/pgcl/


-- wli

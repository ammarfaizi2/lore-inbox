Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263214AbUCSAiv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 19:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263201AbUCSAed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 19:34:33 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:42881
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263196AbUCSAcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 19:32:25 -0500
Date: Fri, 19 Mar 2004 01:33:10 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.5-rc1-aa2
Message-ID: <20040319003310.GA3135@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There was one smp race condition in anon_vma plus bugs in shmfs
truncate, now it seems stable.

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.6/2.6.5-rc1-aa2.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.6/2.6.5-rc1-aa2/

Only in 2.6.5-rc1-aa1: 00000_extraversion-1
Only in 2.6.5-rc1-aa2: 00000_extraversion-2

	Rediffed.

Only in 2.6.5-rc1-aa1: 00101_anon_vma-1.gz
Only in 2.6.5-rc1-aa2: 00101_anon_vma-2.gz

	Fixed race condition during swapping, manage the PG_anon inside
	page_map_lock always.

	Merged Hugh's fixes for truncate.

	Changed my mind the second time and removed the union
	(per Hugh's suggestion), to reduce the size of the patch.

	Dropped some dozen of BUG_TO now that the code is (apparently) rock
	solid.

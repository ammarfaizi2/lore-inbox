Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131937AbRCVDMZ>; Wed, 21 Mar 2001 22:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131938AbRCVDMP>; Wed, 21 Mar 2001 22:12:15 -0500
Received: from nrg.org ([216.101.165.106]:10596 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S131937AbRCVDMA>;
	Wed, 21 Mar 2001 22:12:00 -0500
Date: Wed, 21 Mar 2001 19:11:19 -0800 (PST)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: linux-kernel@vger.kernel.org
Subject: lock_kernel() usage and sync_*() functions
Message-ID: <Pine.LNX.4.05.10103211901070.705-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why is the kernel lock held around sync_supers() and sync_inodes() in
sync_old_buffers() and fsync_dev(), but not in sync_dev()?  Is it just
to serialize calls to these functions, or is there some other reason?

Since this use of the BKL is one of the causes of high preemption
latency in a preemptible kernel, I'm hoping it would be OK to replace
them with a semaphore.  Please let me know if this is not the case.

Thanks!

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

MontaVista Software                             nigel@mvista.com


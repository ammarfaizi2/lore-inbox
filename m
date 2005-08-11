Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbVHKCNT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbVHKCNT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 22:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbVHKCNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 22:13:19 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:41613 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932205AbVHKCNT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 22:13:19 -0400
Subject: [RFC - 0/9] Generic timekeeping subsystem  (v. B5)
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: George Anzinger <george@mvista.com>, frank@tuxrocks.com,
       Anton Blanchard <anton@samba.org>, benh@kernel.crashing.org,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
In-Reply-To: <1123723279.30963.267.camel@cog.beaverton.ibm.com>
References: <1123723279.30963.267.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Wed, 10 Aug 2005 19:13:14 -0700
Message-Id: <1123726394.32531.33.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	Here's the next rev in my rework of the current timekeeping subsystem.
No major changes, only some cleanups and further splitting the larger
patches into smaller ones.

The goal of this patch set is to provide a simplified and streamlined
common timekeeping infrastructure that architectures can optionally use
to avoid duplicating code with other architectures.

This generic timekeeping subsystem is designed around systems that have
continuous timesources to insure correctness and avoid interpolation
errors. Additionally it allows the timekeeping to correctly function
independently from timer interrupts.

For systems that do not have a continuous timesource, no changes are
necessary, the existing tick-based timekeeping still remains. This code
just avoids needless duplication in the arches that do.

For another description on the rework, see here: 
http://lwn.net/Articles/120850/ (Many thanks to the LWN team for that
easy to understand writeup!)

I'd like to thank the following people who have contributed ideas,
criticism, testing and code that has helped shape this work:

	George Anzinger, Nish Aravamudan, Max Asbock, Dominik Brodowski, Darren
Hart, Christoph Lameter, Matt Mackal, Keith Mannthey, Ingo Oeser, Martin
Schwidefsky, Frank Sorenson, Ulrich Windl, Darrick Wong, Roman Zippel
and any others whom I've accidentally forgotten.

thanks
-john



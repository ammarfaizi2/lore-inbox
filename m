Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261454AbUKVQ1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbUKVQ1p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 11:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbUKVQ1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 11:27:45 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:43203 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261454AbUKVPNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 10:13:31 -0500
Cc: openib-general@openib.org
In-Reply-To: 
X-Mailer: roland_patchbomb
Date: Mon, 22 Nov 2004 07:13:24 -0800
Message-Id: <20041122713.Nh0zRPbm8qA0VBxj@topspin.com>
Mime-Version: 1.0
To: linux-kernel@vger.kernel.org
From: Roland Dreier <roland@topspin.com>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH][RFC/v1][0/12] Initial submission of InfiniBand patches for review
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 22 Nov 2004 15:13:29.0431 (UTC) FILETIME=[D293F670:01C4D0A5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm very happy to be able to post an initial version of InfiniBand
patches for review.  Although this code should be far closer to kernel
coding standards than previous open source InfiniBand drivers, this
initial posting should be treated as a request for comments and not a
request for inclusion; our ultimate goal is to have these drivers
included in the mainline kernel, but we expect that fixes and
improvements will need to be made before the code is completely
acceptable.

These patches add a minimal but complete level of InfiniBand support,
including an IB midlayer, a low-level driver for Mellanox HCAs, an
IP-over-InfiniBand driver, and a mechanism for MADs (management
datagrams) to be passed to and from userspace.  This means that these
patches are all that is required for the kernel to bring up and use an
IP-over-InfiniBand link.  (The OpenSM subnet manager has not been
ported to this kernel API yet, although this work is underway.  This
means that at the moment, a kernel with these patches cannot be used
to bring up a fabric; however, the kernel side is complete)

The code has not been through extreme stress testing yet, but it has
been used successfully on i386, x86_64, ppc64, ia64 and sparc64
systems, including mixed 32/64 systems.

Feedback on both details of the code as well as the high-level
organization of the code will be very much appreciated.  For example,
the current set of patches puts include files in driver/infiniband/include;
would it be preferred to put include files in include/linux/infiniband/,
directly in include/linux, or perhaps in include/infiniband?

We would also like to explore the best avenue for having these patches
merged.  It may be desirable for the patches to spend some time in -mm
before moving into Linus's kernel; on the other hand, the patches make
only very minimal and safe changes outside of drivers/infiniband, so
it is quite reasonable to merge them directly into the mainline
kernel.  Although 2.6.10 is now closed, 2.6.11 will probably be open
by the time the review process is complete.

We look forward to the community's comments and criticisms!

Thanks,
  Roland Dreier
  OpenIB Alliance
  www.openib.org


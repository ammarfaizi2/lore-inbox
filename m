Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161351AbWALWHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161351AbWALWHQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 17:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161332AbWALWHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 17:07:15 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:23901 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1161351AbWALWHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 17:07:13 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, airlied@linux.ie,
       linux-kernel@vger.kernel.org, "Brown, Len" <len.brown@intel.com>,
       David Woodhouse <dwmw2@infradead.org>, Jens Axboe <axboe@suse.de>,
       Steven French <sfrench@us.ibm.com>, Roland Dreier <rolandd@cisco.com>,
       Wim Van Sebroeck <wim@iguana.be>, Anton Altaparmakov <aia21@cantab.net>,
       Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: git status
X-Message-Flag: Warning: May contain useful information
References: <Pine.LNX.4.58.0601120948270.1552@skynet>
	<Pine.LNX.4.64.0601121016020.3535@g5.osdl.org>
	<20060112134255.29074831.akpm@osdl.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 12 Jan 2006 14:07:04 -0800
In-Reply-To: <20060112134255.29074831.akpm@osdl.org> (Andrew Morton's
 message of "Thu, 12 Jan 2006 13:42:55 -0800")
Message-ID: <adawth55cdz.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 12 Jan 2006 22:07:11.0938 (UTC) FILETIME=[89C9F220:01C617C4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 465768				git-infiniband.patch

> infiniband: Roland, you need to resend the pull request asap, please.

I am planning on sending a request by Friday, but note that I think
you're looking my patches for -mm.  That includes the driver for IBM
eHCA hardware, which is not going upstream now.  Without that, the
queue is much smaller -- my branch for 2.6.16-rc1 looks like:

 drivers/infiniband/core/cm.c                   |   29 +----
 drivers/infiniband/core/sysfs.c                |   22 +---
 drivers/infiniband/core/uverbs_cmd.c           |    2
 drivers/infiniband/hw/mthca/mthca_eq.c         |   28 +++--
 drivers/infiniband/hw/mthca/mthca_provider.c   |  122 ++++++++++++++-----------
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c |   28 +++--
 drivers/infiniband/ulp/srp/ib_srp.c            |   23 ----
 include/rdma/ib_verbs.h                        |    2
 8 files changed, 119 insertions(+), 137 deletions(-)

with a few more patches still to decide on.

 - R.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261270AbVDDWtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbVDDWtv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 18:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261459AbVDDWtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 18:49:51 -0400
Received: from webmail.topspin.com ([12.162.17.3]:9259 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S261270AbVDDWeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 18:34:21 -0400
Subject: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
In-Reply-To: 
X-Mailer: Roland's Patchbomber
Date: Mon, 4 Apr 2005 15:09:00 -0700
Message-Id: <200544159.Ahk9l0puXy39U6u6@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, openib-general@openib.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 04 Apr 2005 22:09:00.0335 (UTC) FILETIME=[E77EC3F0:01C53962]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is an initial implementation of InfiniBand userspace verbs.  I
plan to commit this code to the OpenIB repository shortly, and submit
it for inclusion during the 2.6.13 cycle, so I am posting it early for
comments.

This code, in conjunction with the libibverbs and libmthca userspace
libraries available from the subversion trees at

    https://openib.org/svn/gen2/branches/roland-uverbs/src/userspace/libibverbs
    https://openib.org/svn/gen2/branches/roland-uverbs/src/userspace/libmthca

enables userspace processes to access InfiniBand HCAs directly.

For those not familiar with the InfiniBand architecture, this
so-called "userspace verbs" support allows userspace to post data path
commands directly to the HCA.  Resource allocation and other control
path operations still go through the kernel driver.

Please take a look at this code if you have a chance.  I would
appreciate high-level criticism of the design and implementation as
well as nitpicky complaints about coding style and typos.

In particular, the memory pinning code in in uverbs_mem.c could stand
a looking over.  In addition, a sanity check of the write()-based
scheme for passing commands into the kernel in uverbs_main.c and
uverbs_cmd.c is probably worthwhile.

Thanks,
  Roland



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262709AbVCJBtc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbVCJBtc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 20:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262611AbVCJBrC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 20:47:02 -0500
Received: from fmr23.intel.com ([143.183.121.15]:30671 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S262718AbVCJBpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 20:45:05 -0500
Message-Id: <200503100144.j2A1isg28121@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Andrew Morton'" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <axboe@suse.de>
Subject: RE: Direct io on block device has performance regression on 2.6.x kernel
Date: Wed, 9 Mar 2005 17:44:54 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcUlEUiJXG7NNZKzRr2d0jQxLsIaVQAAIIbw
In-Reply-To: <20050309173351.0d69de25.akpm@osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote on Wednesday, March 09, 2005 5:34 PM
> What are these percentages?  Total CPU time?  The direct-io stuff doesn't
> look too bad.  It's surprising that tweaking the direct-io submission code
> makes much difference.

Percentage is relative to total kernel time.  There are three DIO functions
showed up in the profile:

__blockdev_direct_IO	4.97%
dio_bio_end_io		2.70%
dio_bio_complete		1.20%

> hm.  __blockdev_direct_IO() doesn't actually do much.  I assume your damn
> compiler went and inlined direct_io_worker() on us.

We are using gcc version 3.4.3.  I suppose I can finger point gcc ? :-P

- Ken



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262274AbULOMDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262274AbULOMDb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 07:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262340AbULOMDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 07:03:31 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:5565 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262274AbULOMD2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 07:03:28 -0500
Date: Wed, 15 Dec 2004 13:03:27 +0100
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Time sliced cfq ver14
Message-ID: <20041215120323.GT3157@suse.de>
References: <20041215082004.GO3157@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041215082004.GO3157@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2.6.10-rc3-mm1 patch:

http://www.kernel.org/pub/linux/kernel/people/axboe/patches/v2.6/2.6.10-rc3-mm1/cfq-time-slices-14-2.6.10-rc3-mm1.gz

2.6-BK patch:

http://www.kernel.org/pub/linux/kernel/people/axboe/patches/v2.6/2.6.10-rc3/cfq-time-slices-14.gz

Changes:

- Fix leak of queue

- Better balance when to preempt. On 8 client read workload, aggregate
  bandwidth would take a few seconds to build up, due to initial massive
  preempt generation more seeks than it should. Priority check was also
  reverse which showed bad results on multi-prio work loads.

- Fix reversed priority check in preemption check, oops.

-- 
Jens Axboe


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261517AbULOIUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbULOIUL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 03:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261632AbULOIUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 03:20:11 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:57271 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261517AbULOIUG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 03:20:06 -0500
Date: Wed, 15 Dec 2004 09:20:05 +0100
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Time sliced cfq ver13
Message-ID: <20041215082004.GO3157@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2.6.10-rc3-mm1 patch:

http://www.kernel.org/pub/linux/kernel/people/axboe/patches/v2.6/2.6.10-rc3-mm1/cfq-time-slices-13-2.6.10-rc3-mm1.gz

2.6-BK patch:

http://www.kernel.org/pub/linux/kernel/people/axboe/patches/v2.6/2.6.10-rc3/cfq-time-slices-13.gz

Changes:

- Fixup the RCU usage. Also uncovered a bug if the process exiting was
  active on several disks, only the first would get kicked.

- Fix problem with CFQ as default at boot for IDE. IDE asks for the same
  request several times, this disturbed the CFQ max_depth logic. Check
  if a request is already in flight and allow it.

-- 
Jens Axboe


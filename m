Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273484AbRIQFpD>; Mon, 17 Sep 2001 01:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273485AbRIQFox>; Mon, 17 Sep 2001 01:44:53 -0400
Received: from 65-45-81-178.customer.algx.net ([65.45.81.178]:17672 "EHLO
	master.aslab.com") by vger.kernel.org with ESMTP id <S273484AbRIQFok>;
	Mon, 17 Sep 2001 01:44:40 -0400
Date: Sun, 16 Sep 2001 22:30:23 -0700 (PDT)
From: Andre Hedrick <andre@aslab.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux Support for 48-bit ATA
Message-ID: <Pine.LNX.4.31.0109162213530.30719-100000@postbox.aslab.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I will be posting a patch for current kernels to use.
ASL and LAD will publish the patch in various locations.
Since this code require a partial rewrite and migration to the new driver
model do not expect it to be adopted anytime soon.

The following are currently broken options:
	CONFIG_IDEDISK_STROKE		48-bit broke it.
	CONFIG_IDE_TASKFILE_IO		New driver breaks multimode pio

Note that "multimode pio" works in the diag. tool suite but the new driver
does not handle the pre-data push correcty out of the block layer yet.

If you need CONFIG_IDEDISK_STROKE, do not use patch, period !!
If you need "multimode pio", do not set CONFIG_IDE_TASKFILE_IO !!

An announcement locations for this patch will be posted on ASL's
web pages early this coming week.

Currently Maxtor is shipping their 160GB Ultra133 drives now.

Linux currently has no support for this transfer rate as the new HOST
cards/controllers require a more extensive driver rewrite.  MMIO ATA/ATAPI
is required.

Regards,

Andre Hedrick
CTO ASL, Inc.
Linux ATA Development
-----------------------------------------------------------------------------
ASL, Inc.                                    Tel: (510) 857-0055 x103
38875 Cherry Street                          Fax: (510) 857-0010
Newark, CA 94560                             Web: www.aslab.com



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266212AbUFJJwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266212AbUFJJwb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 05:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266176AbUFJJvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 05:51:53 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:15009 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S264206AbUFJJkg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 05:40:36 -0400
Date: Thu, 10 Jun 2004 10:40:34 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [bk pull] drm update
Message-ID: <Pine.LNX.4.58.0406101039070.12229@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

Please do a

	bk pull bk://drm.bkbits.net/drm-2.6

This will include the latest DRM changes and will update the following files:

 drivers/char/drm/drm_ioctl.h |    7 ++++++
 drivers/char/drm/gamma_dma.c |   45 +++++++++++++++++++++++++++++++++++++------
 2 files changed, 46 insertions(+), 6 deletions(-)

through these ChangeSets:

<airlied@starflyer.(none)> (04/06/11 1.1752.17.3)
   gamma_dma_priority and gamma_dma_send_buffers both deref d->send_indices
   and/or d->send_sizes.  When these functions are called from gamma_dma,
   these pointers are user pointers and are thus not safe to deref.  This patch
   copies over the pointers inside gamma_dma_priority and
   gamma_dma_send_buffers.

   Submitted-by: Robert T. Johnson <rtjohnso@eecs.berkeley.edu>
   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (04/06/08 1.1752.17.2)
   The dev->devname being passed to request_irq in drm_irq.h is null.
   With the old DRM interface, the devname was set in DRM(setunique),
   but with the current DRM interface >=1.1 the devname is not being
   set in DRM(set_busid).

   From: Alan Swanson
   Approved-by: Dave Airlie <airlied@linux.ie>

Thanks,
Dave.


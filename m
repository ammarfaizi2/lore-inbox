Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751704AbVJTCmC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704AbVJTCmC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 22:42:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751706AbVJTCmC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 22:42:02 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:48821 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751704AbVJTCmB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 22:42:01 -0400
Date: Thu, 20 Oct 2005 03:41:56 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] fix MGA DRM regression before 2.6.14
In-Reply-To: <Pine.LNX.4.58.0510200313410.24156@skynet>
Message-ID: <Pine.LNX.4.58.0510200340140.24156@skynet>
References: <Pine.LNX.4.58.0510200313410.24156@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


And a follow-on patch on top of the last one:

another one liner missing from the old init path, hopefully that is all of
them... need to buy some more MGA cards...

Signed-off-by: Dave Airlie <airlied@linux.ie>

diff --git a/drivers/char/drm/mga_dma.c b/drivers/char/drm/mga_dma.c
--- a/drivers/char/drm/mga_dma.c
+++ b/drivers/char/drm/mga_dma.c
@@ -825,6 +825,7 @@ static int mga_do_init_dma( drm_device_t

 	if (! dev_priv->used_new_dma_init) {

+		dev_priv->dma_access = MGA_PAGPXFER;
 		dev_priv->wagp_enable = MGA_WAGP_ENABLE;

 		dev_priv->status = drm_core_findmap(dev, init->status_offset);

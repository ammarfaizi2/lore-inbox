Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264562AbUFJJ4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264562AbUFJJ4N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 05:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266013AbUFJJx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 05:53:29 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:45473 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S264562AbUFJJqN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 05:46:13 -0400
Date: Thu, 10 Jun 2004 10:46:12 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
Cc: dri-devel@lists.sourceforge.net,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: 2.6.7-rc3 drivers/char/drm/gamma_dma.c: several user/kernel
 pointer bugs
In-Reply-To: <1086821620.32053.120.camel@dooby.cs.berkeley.edu>
Message-ID: <Pine.LNX.4.58.0406101044130.12229@skynet>
References: <1086821620.32053.120.camel@dooby.cs.berkeley.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> gamma_dma_priority and gamma_dma_send_buffers both deref d->send_indices
> and/or d->send_sizes.  When these functions are called from gamma_dma,
> these pointers are user pointers and are thus not safe to deref.  This patch
> copies over the pointers inside gamma_dma_priority and
> gamma_dma_send_buffers.  Let me know if you have any questions or if I've
> made a mistake.

okay I've checked this into the drm bk tree and DRM CVS, I've no way to
test it apart from visual inspection and it compiles, I've asked Linus to
sync the drm tree again, I probably need to add some __user annotations in
a few places..

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person


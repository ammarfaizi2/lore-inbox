Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264513AbUFJJe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264513AbUFJJe5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 05:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264206AbUFJJe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 05:34:57 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:52377 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S264513AbUFJIfy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 04:35:54 -0400
Date: Thu, 10 Jun 2004 09:35:50 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>, faith@valinux.com,
       dri-devel@lists.sourceforge.net,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: 2.6.7-rc3 drivers/char/drm/gamma_dma.c: several user/kernel
 pointer bugs
In-Reply-To: <20040610020332.GC12308@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0406100935200.12229@skynet>
References: <1086821620.32053.120.camel@dooby.cs.berkeley.edu>
 <20040610020332.GC12308@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'll fix this in the DRM bk tree and push to Linus...

Dave.

On Thu, 10 Jun 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:

> On Wed, Jun 09, 2004 at 03:53:40PM -0700, Robert T. Johnson wrote:
> > gamma_dma_priority and gamma_dma_send_buffers both deref d->send_indices
> > and/or d->send_sizes.  When these functions are called from gamma_dma,
> > these pointers are user pointers and are thus not safe to deref.  This patch
> > copies over the pointers inside gamma_dma_priority and
> > gamma_dma_send_buffers.  Let me know if you have any questions or if I've
> > made a mistake.
>
> ACK.
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: GNOME Foundation
> Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
> GNOME Users and Developers European Conference, 28-30th June in Norway
> http://2004/guadec.org
> --
> _______________________________________________
> Dri-devel mailing list
> Dri-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/dri-devel
>

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person


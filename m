Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbVJaWVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbVJaWVy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 17:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbVJaWVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 17:21:54 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:53228 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751305AbVJaWVx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 17:21:53 -0500
Date: Mon, 31 Oct 2005 22:21:45 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: LKML <linux-kernel@vger.kernel.org>, dri-devel@lists.sourceforge.net,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] DRM: 64-bit warning in compilation: wrong param size in
 DRM or harmless?
In-Reply-To: <200510301353.02993.blaisorblade@yahoo.it>
Message-ID: <Pine.LNX.4.58.0510312217420.22770@skynet>
References: <200510301353.02993.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I got a warning and while going to fix it, I discovered some issues with the
> code (including raciness).
>
> While compiling 2.6.14 for x86_64, I got:
>
>   CC [M]  drivers/char/drm/drm_bufs.o
> /home/paolo/Admin/kernel/6/VCS/linux-2.6.14/drivers/char/drm/drm_bufs.c: In
> function `drm_addmap_ioctl':
> /home/paolo/Admin/kernel/6/VCS/linux-2.6.14/drivers/char/drm/drm_bufs.c:309:
> warning: cast to pointer from integer of different size
> /home/paolo/Admin/kernel/6/VCS/linux-2.6.14/drivers/char/drm/drm_bufs.c:309:
> warning: cast to pointer from integer of different size
> /home/paolo/Admin/kernel/6/VCS/linux-2.6.14/drivers/char/drm/drm_bufs.c:309:
> warning: cast to pointer from integer of different size
> /home/paolo/Admin/kernel/6/VCS/linux-2.6.14/drivers/char/drm/drm_bufs.c:309:
> warning: cast to pointer from integer of different size

This is already fixed in the -mm tree from my -git archive.. I'll push it
to Linus this weekend hopefully..

> * If we _ever_ have more drm_device_t, the call to HandleId() would be
> racy.  Right?

Potentially it might be alright, I suppose I could move the handle base
into the drm device, in practice we won't hit this yet, as the X server is
the only client that can do this stuff.. and it doesn't do threading..

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
Linux kernel - DRI, VAX / pam_smb / ILUG


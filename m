Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268026AbUHPXzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268026AbUHPXzm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 19:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268030AbUHPXzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 19:55:42 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:20887 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S268026AbUHPXzj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 19:55:39 -0400
Date: Tue, 17 Aug 2004 00:55:38 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Christoph Hellwig <hch@infradead.org>, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: your mail
In-Reply-To: <20040816154240.54747.qmail@web14925.mail.yahoo.com>
Message-ID: <Pine.LNX.4.58.0408170052571.26072@skynet>
References: <20040816154240.54747.qmail@web14925.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> But DRM still has to live with existing fbdev drivers. The same DRM
> code is used in 2.4 and 2.6 so existing fbdev drivers are not going
> away anytime soon. When DRM detects a fbdev it will revert back into
> stealth mode where is attaches itself to the hardware without telling
> the kernel that it is doing so. DRM can not use stealth mode when
> running without fbdev present since it will mess up hotplug by not
> marking the resources in use.
>
> I don't believe the ordering between fbdev and DRM is an issue. If you
> are using fbdev you likely have it compiled in. In that case fbdev
> always loads first and DRM second. In the non-ppc world, most of us
> have x86 boxes which don't use fbdev. In those machines DRM needs to be
> a first class driver. In the real world I don't know anyone other than
> a developer who would load DRM first and then fbdev. If this is a
> problem you will need to fixed fbdev to fall back into stealth mode
> like DRM does.

This is a good point, we are being forced into stealth mode by the fb
driver if they want to load after us they should respsect us and do the
same, (nope this isn't an us and them, DRM vs fb - I think we have a
solution and are heading the correct direction)...

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person


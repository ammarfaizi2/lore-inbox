Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261730AbVBSP4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261730AbVBSP4v (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 10:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbVBSP4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 10:56:51 -0500
Received: from rproxy.gmail.com ([64.233.170.198]:2086 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261730AbVBSP4t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 10:56:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=PyA7sU5uRuK7yAQaHC36GPUuOYHwq/y8jqJgVt6XfS57NdZz87HxBA5YlKS00mZoCWU7FLpwH4YFiY3m0/6IIl+vJtmCMJLmTxbKAbo9ZJWqlfF7hWrZTl9ADgF12lxmS13PFNuy/QzcVu5KCtlNyMDkOv7n44KdpyCocczLab0=
Message-ID: <9e47339105021907561c4f408c@mail.gmail.com>
Date: Sat, 19 Feb 2005 10:56:48 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Subject: Re: Hotplug blacklist and video devices
Cc: lkml <linux-kernel@vger.kernel.org>,
       fbdev <linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <E1D2TjV-0007r9-00@chiark.greenend.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e4733910502181251ea2b95e@mail.gmail.com>
	 <20050218210822.GB8588@nostromo.devel.redhat.com>
	 <9e47339105021813146cf69759@mail.gmail.com>
	 <E1D2TjV-0007r9-00@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Feb 2005 12:29:13 +0000, Matthew Garrett
<mgarrett@chiark.greenend.org.uk> wrote:
> Jon Smirl <jonsmirl@gmail.com> wrote:
> 
> > For example I'm looking at making changes to DRM such that DRM will
> > require the corresponding framebuffer driver to be loaded. If you back
> > up further this is part of fixing X so that it won't mess with the
> > hardware from user space. Mode setting would come from the framebuffer
> > driver instead of the X 2D XAA driver.
> 
> Please don't until all the framebuffer drivers are able to deal with
> suspend and resume (which will also require some mechanism to switch
> backlights back on). Currently, it's far easier to restore some amount
> of state on a standard VGA or VESA mode. There's no real support for
> doing so with most accelerated framebuffers.

I didn't say make framebuffer depend on DRM, you can still unload DRM
before suspend.  It's the other way around DRM needs framebuffer.
Suspend/resume are part of this. In the current model there is no way
for the DRM driver to see the suspend/resume events. I haven't tried
it but I suspect a suspend/resume with DRM running has a bad outcome
right now.

-- 
Jon Smirl
jonsmirl@gmail.com

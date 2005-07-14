Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261370AbVGNNTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261370AbVGNNTZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 09:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbVGNNTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 09:19:25 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:27164 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261370AbVGNNS0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 09:18:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Qk3ZRT6+FKvNO1aMuI6RU1oeCaTMiVNOF35yKtswPkoZREpX2EU21qonK476gcGIPj42rmjNG6EJfqi/3gq3IMpwbg+TH2fnr8+W5Ju7CQ/Shcw0p0dR55dHxddPyJ7PVQBQbXeLm+Ss+lHStlkLXHz5NQf0Ad+0/ueJXSTBaSs=
Message-ID: <9e47339105071406177dc4dad6@mail.gmail.com>
Date: Thu, 14 Jul 2005 09:17:39 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Dave Airlie <airlied@gmail.com>
Subject: Re: moving DRM header files
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <21d7e9970507132209e7ac477@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <21d7e99705071321044c216db4@mail.gmail.com>
	 <9e4733910507132125af9835@mail.gmail.com>
	 <21d7e9970507132209e7ac477@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/05, Dave Airlie <airlied@gmail.com> wrote:
> > > I'm thinking include/linux/drm/
> > > but include/linux would also be possible.
> > >
> > > Any suggestions or ideas?
> >
> > If you're in a mood to move things, how about moving drivers/char/drm
> > to drivers/video/drm.
> 
> But that has little point beyond aesthetics... moving the header files
> is for a reason that I want them to start appearing in userspace
> includeable places.. as part of the cleanup for libdrm..
> 
> Moving c files internally in the kernel provides no real benefit over
> not moving them..

When you start merging DRM and fbdev you will be able to use relative
paths that are closer together.  For example #include
"../char/drm/drmP.h" versus "#include "drm/drmP.h" for internal
headers.

DRM and fbdev need to be moved next to each other in kconfig too if
they start depending on each other. It if hard to figure out that a
video option might not be visible because the char/drm/option is not
turned on.

-- 
Jon Smirl
jonsmirl@gmail.com

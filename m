Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262194AbVBVF71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262194AbVBVF71 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 00:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbVBVF71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 00:59:27 -0500
Received: from rproxy.gmail.com ([64.233.170.196]:31849 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262194AbVBVF7X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 00:59:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=PNfE2b0mw+nYA1dqk6KlXLSK9D7sp1aH+a8XLUMrrDFAb+HvWrl5wv/eWk4yT7ws+0pBnviD+t9hovzRYf8qI3yXsuf6Rb1PZvirCZIFDSXGKBxK13NldTAoKb85mmJRZzBGOIFIsAt59tSd9I1919ZWreXPmwZsPF5V5Y4URcI=
Message-ID: <9e47339105022121595913c9b@mail.gmail.com>
Date: Tue, 22 Feb 2005 00:59:22 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: James Simmons <jsimmons@www.infradead.org>
Subject: Re: [Linux-fbdev-devel] Resource management.
Cc: Dave Airlie <airlied@gmail.com>,
       James Simmons <jsimmons@pentafluge.infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       adaplas@pol.net, dri-devel@lists.sourceforge.net,
       xorg@lists.freedesktop.org, Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.56.0502220450190.22255@pentafluge.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.56.0502211908520.14500@pentafluge.infradead.org>
	 <200502220653.01286.adaplas@hotpop.com>
	 <Pine.LNX.4.56.0502212313160.18148@pentafluge.infradead.org>
	 <9e473391050221170111610521@mail.gmail.com>
	 <Pine.LNX.4.56.0502220319330.20949@pentafluge.infradead.org>
	 <21d7e99705022120462cb9494c@mail.gmail.com>
	 <Pine.LNX.4.56.0502220450190.22255@pentafluge.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Feb 2005 05:13:07 +0000 (GMT), James Simmons
<jsimmons@www.infradead.org> wrote:
> > > 4. Which comes to the next point. The code is not modular enough. Take
> > >    drm_bufs.c. Everything is a ioctl function. This has a few disadvantages.
> > >    One is the fbdev layer couldn't just link into it so fbcon could use
> > >    it. The second is it's not easy to take advantage of things like sysfs.
> > >    If you could untangle the code somewhat it would make life so much
> > >    easier. That would include making life easier for OS ports.
> >
> > the reason we can't take advantage of sysfs or anything like it is
> > that we can't bind to the PCI device as we break things.. this is the
> > root of a lot of our problems...
> 
> Is this because you want to be OS portable? This makes things very very
> hard to merge. Fbdev attempts to take advantage the most powerful linux
> kernel features.

My turn to laugh! It's because Linux only allow one driver to bind to
the device and fbdev has already bound to it. We have done
siginificant work to DRM to try and work around this (stealth mode)
but the right solution is to have a common base driver.

-- 
Jon Smirl
jonsmirl@gmail.com

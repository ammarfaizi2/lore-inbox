Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269889AbUIDMV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269889AbUIDMV4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 08:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269886AbUIDMV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 08:21:56 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:17158 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269916AbUIDMVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 08:21:53 -0400
Date: Sat, 4 Sep 2004 13:21:42 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dave Airlie <airlied@linux.ie>
Cc: Keith Whitwell <keith@tungstengraphics.com>, Dave Jones <davej@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Jon Smirl <jonsmirl@yahoo.com>,
       dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: New proposed DRM interface design
Message-ID: <20040904132142.A14904@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Airlie <airlied@linux.ie>,
	Keith Whitwell <keith@tungstengraphics.com>,
	Dave Jones <davej@redhat.com>, Jon Smirl <jonsmirl@yahoo.com>,
	dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <41398EBD.2040900@tungstengraphics.com> <20040904104834.B13362@infradead.org> <413997A7.9060406@tungstengraphics.com> <20040904112535.A13750@infradead.org> <4139995E.5030505@tungstengraphics.com> <20040904112930.GB2785@redhat.com> <4139A9F4.4040702@tungstengraphics.com> <20040904115442.GD2785@redhat.com> <4139B03A.6040706@tungstengraphics.com> <Pine.LNX.4.58.0409041311020.25475@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0409041311020.25475@skynet>; from airlied@linux.ie on Sat, Sep 04, 2004 at 01:17:54PM +0100
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 04, 2004 at 01:17:54PM +0100, Dave Airlie wrote:
> Lets take an example, I'm DA graphics card vendor, I write a DRI driver
> for my brand new 3d graphics cards (they rock btw :-), people buy loads of
> them, I want to give them something on my website that they can deploy to
> use their new card, like a driver for ANotherOS. Now I just want to give
> them an XFree DDX, DRI driver and a drm module (in source form, that they
> can use no matter what kernel), now at the moment no matter what kernel
> they have, the DRM is a completly separate entity - the DRM code deals
> with it,
> 
> If we make a library split that sits inside the kernel, their DRM can
> stop working if someone busts the interface, hence the idea of having the
> core reg/dereg in the kernel, and locking it down, then they can ship a
> complete DRM source tree, and do as they wish as long as they interface
> properly with the core...

And with each distro kernel update they have to reinstall the damn thing.
If you absolutely want people to use your driver on older kernels add the
right KERNEL_VERSION (or DRI_VERSION if you want to abstract this out some
way) for older ones.

Again, how is drm different from scsi or net or whatever drivers except
that you need a big userlevel component aswell?

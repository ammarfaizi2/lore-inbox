Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268421AbUI2NTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268421AbUI2NTj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 09:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268420AbUI2NSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 09:18:34 -0400
Received: from mproxy.gmail.com ([216.239.56.242]:31214 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268392AbUI2NQE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 09:16:04 -0400
Message-ID: <21d7e99704092906163f40353@mail.gmail.com>
Date: Wed, 29 Sep 2004 23:16:04 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Discuss issues related to the xorg tree <xorg@freedesktop.org>
Subject: Re: New DRM driver model - gets rid of DRM() macros!
Cc: Christoph Hellwig <hch@infradead.org>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1096459192.15905.0.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e4733910409280854651581e2@mail.gmail.com>
	 <20040929133759.A11891@infradead.org>
	 <1096459192.15905.0.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have the basics working alright, my only issue was with getting
proper sysfs with it, I'll dig up my latest version and post it, I've
also got a ported DRM for it,

at the moment it was doing something like
/sys/devices/vga00 /sys/devices/vga01 one for each user of the card
(multi-card would look really ugly) whereas what we probably want is a
directory per card along the lines of
/sys/device/vga0
                  /vga1

and then links 0->x for each registered driver or maybe even links
like common, dri , fb0 (make the names meaningful as they do have
one...)

Dave.

On Wed, 29 Sep 2004 12:59:55 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Mer, 2004-09-29 at 13:37, Christoph Hellwig wrote:
> >  - once we have Alan's idea of the graphics core implemented drm_init()
> >    should go awaw
> 
> Last I heard Dave Airlie had that working having fixed my bugs.
> 
> 
> 
> 
> _______________________________________________
> xorg mailing list
> xorg@freedesktop.org
> http://freedesktop.org/mailman/listinfo/xorg
>

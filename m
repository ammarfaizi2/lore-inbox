Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269847AbUIDJ14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269847AbUIDJ14 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 05:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269848AbUIDJ14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 05:27:56 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:59909 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269847AbUIDJ1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 05:27:55 -0400
Date: Sat, 4 Sep 2004 10:27:50 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dave Airlie <airlied@linux.ie>
Cc: dri-devel@lists.sf.net, linux-kernel@vger.kernel.org
Subject: Re: New proposed DRM interface design
Message-ID: <20040904102750.A13149@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Airlie <airlied@linux.ie>, dri-devel@lists.sf.net,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0409040107190.18417@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0409040107190.18417@skynet>; from airlied@linux.ie on Sat, Sep 04, 2004 at 01:12:16AM +0100
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 04, 2004 at 01:12:16AM +0100, Dave Airlie wrote:
> 	DRM core - just the stub registration procedure and handling any
> shared resources like the device major number, and perhaps parts of sysfs
> and class code. This interface gets set in stone as quickly as possible
> and is as minimal as can be, (Jon Smirls dyn-minor patch will help a fair
> bit also). All the core does is allow DRMs to register and de-register in
> a nice easy fashion and not interfere with each other. This drmcore.o can
> either be linked into the kernel (ala the fb core) or a module, but in
> theory it should only really be shipped with the kernel - (for compat
> reasons the DRM tree will ship it for older systems).

Ok.

> 	DRM library - this contains all the non-card specific code, AGP
> interface, buffers interface, memory allocation, context handling etc.
> This is mostly stuff that is in templated header files now moved into C
> files along the lines of what I've done in the drmlib-0-0-1-branch. This
> file gets linked into each drm module, if you build two drivers into the
> kernel it gets shared automatically as far as I can see, if you build as
> modules they both end up with the code, for the DRM the single card is the
> primary case so I don't mind losing some resources for having different
> cards in a machine.

Ok except you should build this only once.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269864AbUIDJsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269864AbUIDJsV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 05:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269862AbUIDJsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 05:48:20 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:63237 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269860AbUIDJrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 05:47:22 -0400
Date: Sat, 4 Sep 2004 10:47:18 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dave Airlie <airlied@linux.ie>
Cc: Christoph Hellwig <hch@infradead.org>, Jon Smirl <jonsmirl@yahoo.com>,
       dri-devel@lists.sf.net, linux-kernel@vger.kernel.org
Subject: Re: New proposed DRM interface design
Message-ID: <20040904104718.A13362@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Airlie <airlied@linux.ie>, Jon Smirl <jonsmirl@yahoo.com>,
	dri-devel@lists.sf.net, linux-kernel@vger.kernel.org
References: <20040904004424.93643.qmail@web14921.mail.yahoo.com> <Pine.LNX.4.58.0409040145240.25475@skynet> <20040904102914.B13149@infradead.org> <Pine.LNX.4.58.0409041031370.25475@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0409041031370.25475@skynet>; from airlied@linux.ie on Sat, Sep 04, 2004 at 10:43:39AM +0100
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 04, 2004 at 10:43:39AM +0100, Dave Airlie wrote:
> >
> > Umm, the Linux kernel isn't about minimizing interfaces.  We don't link a
> > copy of scsi helpers into each scsi driver either, or libata into each sata
> > driver.
> 
> true but the DRM isn't only about the Linux kernel, the DRM is a lowlevel
> component of a much larger system, of which the DRM just has to reside in
> the kernel,

And what makes this different?

> While I agree the perfcet solution is to introduce another binary
> interface, but no-one on the dri-devel list is willing to dedicate most of
> their time for the next age answering questions like "well I upgraded my
> r200 driver, and my mga stopped working, and the ATI binary driver killed
> my dog when I changed something else",

Just upgrade all of drm.  You don't uopgrade a single drm driver either.
Or introduce a DRM_VERSION macro ala KERNEL_VERSION.    But best thing is
really to keep the mast copy of drm in the latest kernel and let vendors
backport if nessecary.

> Ian has pointed this out on the
> dri-devel list as a major issue and to be honest he is not alone in his
> worries, if make the kernel responsible for the registration/de-reg only
> then build everything else in the drivers, we don't have to worry about
> someone adding a line to the middle of a structure and breaking the
> modules from somewhere else.. not many people have two different graphics
> cards and I'd rather inconvience them than increase support burden..

I think you need to start to play the kernel game if you want your code
in the kernel.  I know X has this strange idea of beeing useful mostly to
make propritary vendors their life easier, but in kernel lands we thing
differently.


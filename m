Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262497AbVAEQEC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbVAEQEC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 11:04:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262474AbVAEQDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 11:03:07 -0500
Received: from [213.146.154.40] ([213.146.154.40]:49045 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262498AbVAEPzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 10:55:37 -0500
Date: Wed, 5 Jan 2005 15:55:29 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andi Kleen <ak@muc.de>
Cc: Christoph Hellwig <hch@infradead.org>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Andrew Morton <akpm@osdl.org>, mingo@elte.hu, rlrevell@joe-job.com,
       tiwai@suse.de, linux-kernel@vger.kernel.org, pavel@suse.cz,
       discuss@x86-64.org, gordon.jin@intel.com,
       alsa-devel@lists.sourceforge.net, greg@kroah.com
Subject: Re: [PATCH] deprecate (un)register_ioctl32_conversion
Message-ID: <20050105155529.GA2721@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andi Kleen <ak@muc.de>, "Michael S. Tsirkin" <mst@mellanox.co.il>,
	Andrew Morton <akpm@osdl.org>, mingo@elte.hu, rlrevell@joe-job.com,
	tiwai@suse.de, linux-kernel@vger.kernel.org, pavel@suse.cz,
	discuss@x86-64.org, gordon.jin@intel.com,
	alsa-devel@lists.sourceforge.net, greg@kroah.com
References: <20041215065650.GM27225@wotan.suse.de> <20041217014345.GA11926@mellanox.co.il> <20050105144043.GB19434@mellanox.co.il> <20050105144603.GA1419@infradead.org> <m1fz1fdhu3.fsf@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1fz1fdhu3.fsf@muc.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2005 at 04:19:16PM +0100, Andi Kleen wrote:
> Christoph Hellwig <hch@infradead.org> writes:
> 
> > On Wed, Jan 05, 2005 at 04:40:43PM +0200, Michael S. Tsirkin wrote:
> >> Hello, Andrew, all!
> >> 
> >> Since in -mm1 we now have a race-free replacement (that being ioctl_compat),
> >> here is a patch to deprecate (un)register_ioctl32_conversion.
> >
> > Sorry, but this is a lot too early.  Once there's a handfull users left
> > in _mainline_ you can start deprecating it (or better remove it completely).
> 
> There were never more than a handful users of it anyways. So I think
> Michael's suggestion to deprecate it early is very reasonable.

It's 72 callers in mainline.  Aka 72 new warnings for an allmodconfig
build.  This isn't reasonable just because the interface got out of
fashion.


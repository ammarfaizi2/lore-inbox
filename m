Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262588AbULPFEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262588AbULPFEk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 00:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262582AbULPFER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 00:04:17 -0500
Received: from ns.suse.de ([195.135.220.2]:6850 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262588AbULPFEE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 00:04:04 -0500
Date: Thu, 16 Dec 2004 06:03:56 +0100
From: Andi Kleen <ak@suse.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Takashi Iwai <tiwai@suse.de>, "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, pavel@suse.cz,
       discuss@x86-64.org, gordon.jin@intel.com,
       alsa-devel <alsa-devel@lists.sourceforge.net>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [discuss] Re: unregister_ioctl32_conversion and modules. ioctl32 revisited.
Message-ID: <20041216050356.GH32718@wotan.suse.de>
References: <20041215065650.GM27225@wotan.suse.de> <20041215074635.GC11501@mellanox.co.il> <s5hbrcvqv7r.wl@alsa2.suse.de> <1103135460.18982.68.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103135460.18982.68.camel@krustophenia.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2004 at 01:30:59PM -0500, Lee Revell wrote:
> On Wed, 2004-12-15 at 19:20 +0100, Takashi Iwai wrote:
> > At Wed, 15 Dec 2004 09:46:35 +0200,
> > Michael S. Tsirkin wrote:
> > > 
> > > There were two additional motivations for my patch:
> > > 1. Make it possible to avoid the BKL completely by writing
> > >    an ioctl with proper internal locking.
> > > 2. As noted by  Juergen Kreileder, the compat hash does not work
> > >    for ioctls that encode additional information in the command, like this:
> > > 
> > > #define EVIOCGBIT(ev,len)  _IOC(_IOC_READ, 'E', 0x20 + ev, len)
> > 
> > I like the idea very well.  Other benifits in addition:
> > 
> 
> How does this all relate to Ingo's ->unlocked_ioctl stuff which is "an
> official way to do BKL-less ioctls"?

This is another "official" way which is more powerful. I suppose it will
replace Ingo's patch.

-Andi

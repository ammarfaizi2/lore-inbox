Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262650AbULPIjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262650AbULPIjn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 03:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262653AbULPIjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 03:39:42 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:42653 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262650AbULPIih (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 03:38:37 -0500
Date: Thu, 16 Dec 2004 09:38:36 +0100
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, mingo@elte.hu, rlrevell@joe-job.com,
       tiwai@suse.de, mst@mellanox.co.il, linux-kernel@vger.kernel.org,
       pavel@suse.cz, discuss@x86-64.org, gordon.jin@intel.com,
       alsa-devel@lists.sourceforge.net, greg@kroah.com
Subject: Re: [discuss] Re: unregister_ioctl32_conversion and modules. ioctl32 revisited.
Message-ID: <20041216083836.GM32718@wotan.suse.de>
References: <20041215065650.GM27225@wotan.suse.de> <20041215074635.GC11501@mellanox.co.il> <s5hbrcvqv7r.wl@alsa2.suse.de> <1103135460.18982.68.camel@krustophenia.net> <20041216050356.GH32718@wotan.suse.de> <20041216075301.GC11047@elte.hu> <20041216080952.GL32718@wotan.suse.de> <20041216002539.60d37dfe.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041216002539.60d37dfe.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2004 at 12:25:39AM -0800, Andrew Morton wrote:
> Andi Kleen <ak@suse.de> wrote:
> >
> > I think Michael's patch is best (but I'm probably biased) because it addresses
> >  the independent problem of a race in unregister_ioctl32_conversion() too
> >  (and some other smaller issues in ioctl 32bit emulation)
> 
> They should be separate patches.

The two new methods (ioctl_native and ioctl_compat) are in the same patch
because they basically touch the same piece of code and would be hard
to separate. The other stuff (actually replacing register_ioctl32_conversion and 
converting a few obvious users to use the BKL less fast path) will be addon patches.

> 
> >  Andrew, could we replace unlocked_ioctl.patch with Michael's patch?
> 
> Where would one locate Michael's patch?

See his mail.

-Andi

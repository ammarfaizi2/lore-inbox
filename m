Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262868AbVAFPiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262868AbVAFPiO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 10:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262879AbVAFPiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 10:38:13 -0500
Received: from cantor.suse.de ([195.135.220.2]:22724 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262868AbVAFPhk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 10:37:40 -0500
Date: Thu, 6 Jan 2005 16:37:38 +0100
From: Andi Kleen <ak@suse.de>
To: Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Andrew Morton <akpm@osdl.org>, Takashi Iwai <tiwai@suse.de>,
       mingo@elte.hu, rlrevell@joe-job.com, linux-kernel@vger.kernel.org,
       pavel@suse.cz, discuss@x86-64.org, gordon.jin@intel.com, greg@kroah.com,
       VANDROVE@vc.cvut.cz
Subject: Re: [PATCH] macros to detect existance of unlocked_ioctl and ioctl_compat
Message-ID: <20050106153738.GF1830@wotan.suse.de>
References: <20041215065650.GM27225@wotan.suse.de> <20041217014345.GA11926@mellanox.co.il> <20050103011113.6f6c8f44.akpm@osdl.org> <20050105144043.GB19434@mellanox.co.il> <s5hd5wjybt8.wl@alsa2.suse.de> <20050105133448.59345b04.akpm@osdl.org> <20050106140636.GE25629@mellanox.co.il> <20050106145356.GA18725@infradead.org> <20050106150941.GE1830@wotan.suse.de> <20050106151429.GA19155@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050106151429.GA19155@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 03:14:29PM +0000, Christoph Hellwig wrote:
> On Thu, Jan 06, 2005 at 04:09:42PM +0100, Andi Kleen wrote:
> > I would agree that it shouldn't be used for in tree code, but for
> > out of tree code it is rather useful. There are other such feature macros
> > for major driver interface changes too (e.g. in the network stack).
> 
> Which is the only place doing it.  We had this discussion in the past
> (lastone I revolve Greg vetoed it).  We simply shouldn't clutter our

I don't know who had this discussion and did this "decision", but 
for record I disagree.

> headers for the sake of out of tree drivers - with LINUX_VERSION_CODE
> we've already implemented a mechanism for out of tree drivers.

That's incredibly ugly. I always hate these checks in source code
because it's never clear what exactly they are testing for. 
And requires unreasonable work to find out when exactly the feature was 
added. And it doesn't really work when there are backports in older trees.
In short there are many drawbacks. HAVE_* is much nicer.

-Andi

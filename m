Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261673AbULTXAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbULTXAa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 18:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261671AbULTW6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 17:58:55 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:7 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261689AbULTWxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 17:53:30 -0500
Date: Mon, 20 Dec 2004 23:53:24 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Dan Dennedy <dan@dennedy.org>
Cc: Lee Revell <rlrevell@joe-job.com>, Ben Collins <bcollins@debian.org>,
       Linux1394-Devel <linux1394-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] ieee1394_core.c: remove unneeded EXPORT_SYMBOL's
Message-ID: <20041220225324.GY21288@stusta.de>
References: <20041220015320.GO21288@stusta.de> <1103508610.3724.69.camel@kino.dennedy.org> <20041220022503.GT21288@stusta.de> <1103510535.1252.18.camel@krustophenia.net> <1103516870.3724.103.camel@kino.dennedy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103516870.3724.103.camel@kino.dennedy.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 19, 2004 at 11:27:50PM -0500, Dan Dennedy wrote:
> On Sun, 2004-12-19 at 21:42 -0500, Lee Revell wrote:
> > On Mon, 2004-12-20 at 03:25 +0100, Adrian Bunk wrote:
> > > On Sun, Dec 19, 2004 at 09:10:10PM -0500, Dan Dennedy wrote:
> > > > On Mon, 2004-12-20 at 02:53 +0100, Adrian Bunk wrote:
> > > > > The patch below removes 41 unneeded EXPORT_SYMBOL's.
> > > > 
> > > > Unneeded according to whom, just you? These functions are part of an
> > > > API. How do I know someone is not using these in a custom ieee1394
> > > > kernel module in some industrial or research setting or something new
> > > > under development to be contributed to linux1394 project?
> > > 
> > > If someone uses some of them in code to be contributed to the linux1394 
> > > project, re-adding the EXPORT_SYMBOL's in question is trivial.
> > > 
> > > If someone uses some of them in a custom setting, re-adding them is 
> > > trivial, too.
> > > 
> > > If the only user of one or more of these EXPORT_SYMBOL's was a non-free 
> > > module, it's kernel policy that the EXPORT_SYMBOL's in question have to 
> > > be removed.
> > 
> > What do you tell a vendor who wants to write a driver for their device?
> > "OK, about half the functions you need are in the kernel, the other half
> > you have to port from this old kernel because we removed them.  Maybe we
> > will put them back if we really like your driver"?
> 
> While I think some of Adrian's points are valid, I am exercising caution
> because I am a new maintainer for linux1394 (although not new to the
> project in general). This is an interface version management issue IMHO.
> Adrian is not suggesting to remove the functions yet, but it is
> effectively the same thing to an outsider. A vendor or services provider
> would have to modify kernel source to let their driver work again, which
> is not technically challenging to kernel hackers, but frustrating
> situation to be in as a vendor or customer. It creates a mess in
> support, distribution, deployment, etc.

The solution is simple:
The vendor or services provider submits his driver for inclusion into 
the kernel which is the best solution for everyone.

> Do I have specific examples where removing these symbols would cause
> breakage? No, but I do provide contracted services based on linux1394, I
> know of a guy developing a v4l2 driver that likely needs some of these,
> and some have been considering new alsa and v4l2 drivers that could use
> these. Besides, there is a lot in the wild we do not know about - free
> or non-free. It would suck to say you can not use these custom or new
> drivers on your distro's kernel and you need to wait for an upgrade if
> not willing to customize and compile.

You didn't explicitely say whether the results of the contracted 
services you offer are free or non-free.

If the result is free, inclusion into the kernel is simply the optimal 
solution.

If the result is non-free, it;s kernel policy that there are no 
EXPORT_SYMBOL's specifically for non-free modules (and that a free 
module might some day use them is not a reason).

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


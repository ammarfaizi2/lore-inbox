Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261413AbULTEjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbULTEjm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 23:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbULTEjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 23:39:42 -0500
Received: from smtp.nuvox.net ([64.89.70.9]:25122 "EHLO
	smtp04.gnvlscdb.sys.nuvox.net") by vger.kernel.org with ESMTP
	id S261413AbULTEjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 23:39:40 -0500
Subject: Re: [2.6 patch] ieee1394_core.c: remove unneeded EXPORT_SYMBOL's
From: Dan Dennedy <dan@dennedy.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Adrian Bunk <bunk@stusta.de>, Ben Collins <bcollins@debian.org>,
       Linux1394-Devel <linux1394-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1103510535.1252.18.camel@krustophenia.net>
References: <20041220015320.GO21288@stusta.de>
	 <1103508610.3724.69.camel@kino.dennedy.org>
	 <20041220022503.GT21288@stusta.de>
	 <1103510535.1252.18.camel@krustophenia.net>
Content-Type: text/plain
Date: Sun, 19 Dec 2004 23:27:50 -0500
Message-Id: <1103516870.3724.103.camel@kino.dennedy.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-12-19 at 21:42 -0500, Lee Revell wrote:
> On Mon, 2004-12-20 at 03:25 +0100, Adrian Bunk wrote:
> > On Sun, Dec 19, 2004 at 09:10:10PM -0500, Dan Dennedy wrote:
> > > On Mon, 2004-12-20 at 02:53 +0100, Adrian Bunk wrote:
> > > > The patch below removes 41 unneeded EXPORT_SYMBOL's.
> > > 
> > > Unneeded according to whom, just you? These functions are part of an
> > > API. How do I know someone is not using these in a custom ieee1394
> > > kernel module in some industrial or research setting or something new
> > > under development to be contributed to linux1394 project?
> > 
> > If someone uses some of them in code to be contributed to the linux1394 
> > project, re-adding the EXPORT_SYMBOL's in question is trivial.
> > 
> > If someone uses some of them in a custom setting, re-adding them is 
> > trivial, too.
> > 
> > If the only user of one or more of these EXPORT_SYMBOL's was a non-free 
> > module, it's kernel policy that the EXPORT_SYMBOL's in question have to 
> > be removed.
> 
> What do you tell a vendor who wants to write a driver for their device?
> "OK, about half the functions you need are in the kernel, the other half
> you have to port from this old kernel because we removed them.  Maybe we
> will put them back if we really like your driver"?

While I think some of Adrian's points are valid, I am exercising caution
because I am a new maintainer for linux1394 (although not new to the
project in general). This is an interface version management issue IMHO.
Adrian is not suggesting to remove the functions yet, but it is
effectively the same thing to an outsider. A vendor or services provider
would have to modify kernel source to let their driver work again, which
is not technically challenging to kernel hackers, but frustrating
situation to be in as a vendor or customer. It creates a mess in
support, distribution, deployment, etc.

Do I have specific examples where removing these symbols would cause
breakage? No, but I do provide contracted services based on linux1394, I
know of a guy developing a v4l2 driver that likely needs some of these,
and some have been considering new alsa and v4l2 drivers that could use
these. Besides, there is a lot in the wild we do not know about - free
or non-free. It would suck to say you can not use these custom or new
drivers on your distro's kernel and you need to wait for an upgrade if
not willing to customize and compile.



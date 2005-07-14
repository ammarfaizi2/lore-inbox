Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262991AbVGNKBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262991AbVGNKBg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 06:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262995AbVGNKBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 06:01:36 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:6161 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262991AbVGNKBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 06:01:35 -0400
To: jengelh@linux01.gwdg.de
CC: linux-kernel@vger.kernel.org
In-reply-to: <Pine.LNX.4.61.0507141145181.18072@yvahk01.tjqt.qr> (message from
	Jan Engelhardt on Thu, 14 Jul 2005 11:48:48 +0200 (MEST))
Subject: Re: [PATCH] Fuse chardevice number
References: <Pine.LNX.4.61.0507132213450.23970@yvahk01.tjqt.qr>
 <E1Dsyhe-0005A9-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.61.0507141145181.18072@yvahk01.tjqt.qr>
Message-Id: <E1Dt0Wu-0005LO-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 14 Jul 2005 12:01:20 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>  /** The minor number of the fuse character device */
> >> -#define FUSE_MINOR 229
> >> +#define FUSE_MINOR MISC_DYNAMIC_MINOR
> >
> >FUSE has an allocated fix minor.  Dynamic minor is much harder to
> >handle with legacy /dev (not udev).
> 
> How many users of 2.6.13 and up really do not have/run udev? [Please don't 
> send too many responses]

Don't be afraid, 2.6.13 is not yet released.  So the number of users
of udev under 2.6.13 is exactly zero ;)

> A module option could be added to specify an explicit minor.

That's just making it more complicated without any gain. An assigned
device number (if it exsist) is exactly as good as a dynamic.

Miklos


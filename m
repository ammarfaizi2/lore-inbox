Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261729AbVGDNdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261729AbVGDNdv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 09:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261726AbVGDNdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 09:33:49 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:58893 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261690AbVGDNSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 09:18:16 -0400
To: 7eggert@gmx.de
CC: akpm@osdl.org, aia21@cam.ac.uk, arjan@infradead.org,
       linux-kernel@vger.kernel.org
In-reply-to: <E1DpQhW-0004Sv-Iw@be1.7eggert.dyndns.org> (message from Bodo
	Eggert on Mon, 04 Jul 2005 15:09:29 +0200)
Subject: Re: FUSE merging? (2)
References: <4ly7J-14H-9@gated-at.bofh.it> <4lRDA-4U-55@gated-at.bofh.it> <4lSJa-16Z-7@gated-at.bofh.it> <4m5ZG-2ok-1@gated-at.bofh.it> <4maPM-5XJ-5@gated-at.bofh.it> <4mcHV-7no-21@gated-at.bofh.it> <4mduc-7Zg-1@gated-at.bofh.it> <4mfcJ-UT-17@gated-at.bofh.it> <4mitV-3mL-3@gated-at.bofh.it> <4mv7Q-2Ki-19@gated-at.bofh.it> <4mwdG-3AP-15@gated-at.bofh.it> <4mwwX-3N9-9@gated-at.bofh.it> <E1DpQhW-0004Sv-Iw@be1.7eggert.dyndns.org>
Message-Id: <E1DpQpL-0006aM-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 04 Jul 2005 15:17:35 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I see your point.  But then this is really not a security issue, but
> > an "are you sure you want to format C:" style protection for the
> > user's own sake.  Adding a mount option (checked by the library) for
> > this would be fine.  E.g. with "mount_nonempty" it would not refuse to
> > mount on a non-leaf dir, and README would document, that using this
> > option might cause trouble.  Otherwise the mount would be refused with
> > a reference to the above option.
> 
> IMO that should be a generic mount option, not FUSE specific.
> Maybe the default could vary for each fs, but I'd vote against that.

The option only makes sense with the default being restrictive.  But
making that default for all filesystems can't be done, because that
would immediately break thousands of existing installations.

I think this makes some sense for unprivileged mounts, but otherwise
not really.  If sysadmin is not careful about where the mounts go,
tough luck on him.

Miklos

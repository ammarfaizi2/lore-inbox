Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751314AbWAQQIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbWAQQIb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 11:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbWAQQIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 11:08:31 -0500
Received: from jose.lug.udel.edu ([128.175.60.112]:27307 "EHLO
	jose.lug.udel.edu") by vger.kernel.org with ESMTP id S1751299AbWAQQIa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 11:08:30 -0500
Date: Tue, 17 Jan 2006 11:08:30 -0500
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 000 of 5] md: Introduction
Message-ID: <20060117160829.GA16606@lug.udel.edu>
References: <20060117174531.27739.patches@notabene> <43CCA80B.4020603@tls.msk.ru> <20060117095019.GA27262@localhost.localdomain> <43CCD453.9070900@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43CCD453.9070900@tls.msk.ru>
User-Agent: Mutt/1.5.11
From: ross@jose.lug.udel.edu (Ross Vandegrift)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2006 at 02:26:11PM +0300, Michael Tokarev wrote:
> Raid code is already too fragile, i'm afraid "simple" I/O errors
> (which is what we need raid for) may crash the system already, and
> am waiting for the next whole system crash due to eg superblock
> update error or whatnot.

I think you've got some other issue if simple I/O errors cause issues.
I've managed hundreds of MD arrays over the past ~ten years.  MD is
rock solid.  I'd guess that I've recovered at least a hundred disk failures
where data was saved by mdadm.

What is your setup like?  It's also possible that you've found a bug.

> I saw all sorts of failures due to
> linux softraid already (we use it here alot), including ones
> which required complete array rebuild with heavy data loss.

Are you sure?  The one thing that's not always intuitive about MD - a
faild array often still has your data and you can recover it.  Unlike
hardware RAID solutions, you have a lot of control over how the disks
are assembled and used - this can be a major advantage.

I'd say once a week someone comes on the linux-raid list and says "Oh no!
I accidently ruined my RAID array!".  Neil almost always responds "Well,
don't do that!  But since you did, this might help...".

-- 
Ross Vandegrift
ross@lug.udel.edu

"The good Christian should beware of mathematicians, and all those who
make empty prophecies. The danger already exists that the mathematicians
have made a covenant with the devil to darken the spirit and to confine
man in the bonds of Hell."
	--St. Augustine, De Genesi ad Litteram, Book II, xviii, 37

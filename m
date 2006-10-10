Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbWJJTGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWJJTGk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 15:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbWJJTGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 15:06:39 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:19895 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932169AbWJJTGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 15:06:38 -0400
Date: Tue, 10 Oct 2006 14:06:30 -0500 (CDT)
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Randy Dunlap <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Jeremy Higdon <jeremy@sgi.com>,
       Pat Gefre <pfg@sgi.com>
Subject: Re: [PATCH 2/2] ioc4: Enable build on non-SN2
In-Reply-To: <Pine.LNX.4.61.0610102042290.17718@yvahk01.tjqt.qr>
Message-ID: <20061010140429.O71367@pkunk.americas.sgi.com>
References: <20061010120928.V71367@pkunk.americas.sgi.com>
 <20061010103915.f412d770.rdunlap@xenotime.net> <20061010131916.D71367@pkunk.americas.sgi.com>
 <Pine.LNX.4.61.0610102042290.17718@yvahk01.tjqt.qr>
Organization: Silicon Graphics, Inc.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2006, Jan Engelhardt wrote:

> >> Mostly curious:  did you observe that this is required?
> >> I always thought that Roman said that unknown config variables
> >> caused a rescan by kconfig.  IOW, I thought that it wouldn't
> >> be observable by a user.  Just wondering..
> >
> >If it causes a rescan (I don't rightly know) it must have changed.
> >I caught a bit of flak for an incorrectly ordered config statement
> >once before, but that was a few years ago.
> 
> I am sure it causes a rescan, because activating 
> CONFIG_NETFILTER for example makes some options available that are 
> defined before NETFILTER, such as IP_ROUTE_FWMARK, IP_VS, 
> NETFILTER_XT_TARGET_CONNMARK and NETFILTER_XT_TARGET_NOTRACK, and 
> activating NETFILTER _will_ cause a rescan with `make oldconfig` - I 
> just tried. (Things are a little different with menuconfig/xconfig and 
> such of course)

In my case I think it was the menuconfig or xconfig that someone
complained about (I don't rightly remember which one).  In any case,
for the patch at hand, I could find no particular reason that
the drivers/misc Kconfig line couldn't be moved up to preserve peace
and harmony.

Brent

-- 
Brent Casavant                          All music is folk music.  I ain't
bcasavan@sgi.com                        never heard a horse sing a song.
Silicon Graphics, Inc.                    -- Louis Armstrong

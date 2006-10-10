Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932163AbWJJTFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbWJJTFK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 15:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbWJJTFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 15:05:09 -0400
Received: from xenotime.net ([66.160.160.81]:50602 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932163AbWJJTFH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 15:05:07 -0400
Date: Tue, 10 Oct 2006 12:06:33 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Brent Casavant <bcasavan@sgi.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Jeremy Higdon <jeremy@sgi.com>,
       Pat Gefre <pfg@sgi.com>
Subject: Re: [PATCH 2/2] ioc4: Enable build on non-SN2
Message-Id: <20061010120633.895c6dc7.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.61.0610102042290.17718@yvahk01.tjqt.qr>
References: <20061010120928.V71367@pkunk.americas.sgi.com>
	<20061010103915.f412d770.rdunlap@xenotime.net>
	<20061010131916.D71367@pkunk.americas.sgi.com>
	<Pine.LNX.4.61.0610102042290.17718@yvahk01.tjqt.qr>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2006 20:53:39 +0200 (MEST) Jan Engelhardt wrote:

> 
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
> 
> >> The lines under ---help--- should be indented by 2 spaces (by
> >> convention) (and even though they were not when in the /sn/ subdir).
> >
> >Thanks for catching that... I just blindly copied from one spot
> >to another.  I'll resend.
> 
> Not tabs?

One tab + 2 spaces.  Or 2 spaces more than the rest of
the config entry.

---
~Randy

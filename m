Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbWJJS5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbWJJS5c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 14:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWJJS5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 14:57:32 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:48877 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751086AbWJJS5b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 14:57:31 -0400
Date: Tue, 10 Oct 2006 20:53:39 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Brent Casavant <bcasavan@sgi.com>
cc: Randy Dunlap <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Jeremy Higdon <jeremy@sgi.com>,
       Pat Gefre <pfg@sgi.com>
Subject: Re: [PATCH 2/2] ioc4: Enable build on non-SN2
In-Reply-To: <20061010131916.D71367@pkunk.americas.sgi.com>
Message-ID: <Pine.LNX.4.61.0610102042290.17718@yvahk01.tjqt.qr>
References: <20061010120928.V71367@pkunk.americas.sgi.com>
 <20061010103915.f412d770.rdunlap@xenotime.net> <20061010131916.D71367@pkunk.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Mostly curious:  did you observe that this is required?
>> I always thought that Roman said that unknown config variables
>> caused a rescan by kconfig.  IOW, I thought that it wouldn't
>> be observable by a user.  Just wondering..
>
>If it causes a rescan (I don't rightly know) it must have changed.
>I caught a bit of flak for an incorrectly ordered config statement
>once before, but that was a few years ago.

I am sure it causes a rescan, because activating 
CONFIG_NETFILTER for example makes some options available that are 
defined before NETFILTER, such as IP_ROUTE_FWMARK, IP_VS, 
NETFILTER_XT_TARGET_CONNMARK and NETFILTER_XT_TARGET_NOTRACK, and 
activating NETFILTER _will_ cause a rescan with `make oldconfig` - I 
just tried. (Things are a little different with menuconfig/xconfig and 
such of course)

>> The lines under ---help--- should be indented by 2 spaces (by
>> convention) (and even though they were not when in the /sn/ subdir).
>
>Thanks for catching that... I just blindly copied from one spot
>to another.  I'll resend.

Not tabs?


	-`J'
-- 

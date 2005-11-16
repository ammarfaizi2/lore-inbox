Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030376AbVKPPnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030376AbVKPPnw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 10:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030371AbVKPPnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 10:43:52 -0500
Received: from sccrmhc11.comcast.net ([63.240.77.81]:31739 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1030376AbVKPPnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 10:43:52 -0500
From: kernel-stuff@comcast.net (Parag Warudkar)
To: "Johannes Berg" <johannes@sipsolutions.net>
Cc: debian-powerpc@lists.debian.org, linux-kernel@vger.kernel.org
Subject: Re: PowerBook5,8 - TrackPad update
Date: Wed, 16 Nov 2005 15:43:50 +0000
Message-Id: <111620051543.21656.437B53B5000EABF300005498220074818400009A9B9CD3040A029D0A05@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Dec 17 2004)
X-Authenticated-Sender: a2VybmVsLXN0dWZmQGNvbWNhc3QubmV0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ah and yes I forgot about the dual finger scrolling function - newer trackpads allow you to use 2 fingers to slide up and down to achieve scrolling. I don't see any code in current appletouch.c which handles this. We might be able to live without it for some time but maybe we can't as it might screw up the reporting if not handled. (PPC assembly is fun to work with :)


Parag


> > Parag Warudkar wrote:
> > > Just a heads up - After some lame hacking I finally have got the trackpad
> > > on the PB5,8  (15" Late Oct 2005) to work.
> > 
> > Can you tell us what's different? I'd like to work that into my page that
> > documents the protocol.
> > 
> > johannes
> 
> Sure but I haven't worked out the details of the changes yet. All I am fairly 
> certain at this point is that 
> 
> 1) New Trackpad sends in more data than the old one. ATP_DATASIZE has to be 
> increased from 81 to 256. (The original code was dying with EOVERFLOW from the 
> URB complete routine. 256 is the minimum value it is happy with.)
> 
> 2) The 15" also has 26 x 16 sensors - not sure how many the 17" has - most 
> likely same
> 
> 3) The FUZZ, PRESSURE, XFACT and YFACT, along with the button reporting all 
> needs to be reworked - this is my preliminary opinion, might be wrong but with 
> the original code, the mouse moves erratically and the button events don't seem 
> to be delivered right.
> 
> Will post complete details once I have it working.
> 
> Thanks
> 
> Parag 
> 
> 
> 

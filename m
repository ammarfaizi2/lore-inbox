Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261420AbVCOQmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbVCOQmT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 11:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbVCOQmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 11:42:18 -0500
Received: from mx1.redhat.com ([66.187.233.31]:13979 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261420AbVCOQmF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 11:42:05 -0500
Date: Tue, 15 Mar 2005 11:41:58 -0500
From: Dave Jones <davej@redhat.com>
To: Dave Airlie <airlied@linux.ie>
Cc: Andrew Clayton <andrew@digital-domain.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
Subject: Re: drm lockups since 2.6.11-bk2
Message-ID: <20050315164158.GE15531@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Dave Airlie <airlied@linux.ie>,
	Andrew Clayton <andrew@digital-domain.net>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	dri-devel@lists.sourceforge.net
References: <Pine.LNX.4.58.0503151033110.22756@skynet> <20050315143629.GA27654@redhat.com> <Pine.LNX.4.58.0503151610560.443@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503151610560.443@skynet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2005 at 04:15:42PM +0000, Dave Airlie wrote:

 > > I saw one report where the recent drm security hole fix broke dri
 > > for one user.  Whilst it seems an isolated incident, could this have
 > > more impact than we first realised ?
 > 
 > the radeon security changes? I've gotten no bad feedback on those neither
 > has dri-devel, so I've assumed they were all fine (usually radeon bug
 > reports get back fairly quickly as everyone has one ..),

The missing memset in setversion ioctl.
What sounded odd was that this was reproduced on 2.6.11.x, rather
than 2.6.11-bk, which has none of the AGP changes.
Could be a red herring though, as it was only one report.

 > > Worse case scenario we can drop out the multi-bridge support for now
 > > if it needs work. Mike left SGI now, so we'll need to find someone else
 > > with access to a Prism to make sure it still works correctly on a
 > > real multi-gart system.
 > 
 > I'd like to make it work I'm sure it is some thing small wrong, but I've
 > no access for > 1 week to my radeon machine so unless someone else picks
 > it up we may need to drop it for now..

I'll try and dig into it over the next few days, but I'm swamped
in other stuff right now :-/

		Dave

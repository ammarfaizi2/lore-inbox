Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261278AbVCOOhA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbVCOOhA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 09:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261279AbVCOOg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 09:36:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:51131 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261278AbVCOOgr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 09:36:47 -0500
Date: Tue, 15 Mar 2005 09:36:29 -0500
From: Dave Jones <davej@redhat.com>
To: Dave Airlie <airlied@linux.ie>
Cc: Andrew Clayton <andrew@digital-domain.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
Subject: Re: drm lockups since 2.6.11-bk2
Message-ID: <20050315143629.GA27654@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Dave Airlie <airlied@linux.ie>,
	Andrew Clayton <andrew@digital-domain.net>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	dri-devel@lists.sourceforge.net
References: <Pine.LNX.4.58.0503151033110.22756@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503151033110.22756@skynet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2005 at 10:38:30AM +0000, Dave Airlie wrote:
 > 
 > Hi all,
 > 	Andrew Clayton reported lockups on the dri list issues since -bk2
 > and bug 4337 on bugzilla.kernel.org looks like it might be the same
 > thing..
 > 
 > This leads me to think the AGP multi-bridge patches are at fault... (for
 > once my laziness in merging late instead of early gave a good gap in the
 > patches...)
 > 
 > I'm "offline" in sense of I can write this mail and respond but have not
 > access to a Linux system, my bitkeeper trees, ssh keys for anywhere of
 > interest.. and am in the wrong country, it'll be the 23rd/24th before I am
 > back at my desks...
 > 
 > I might get time to do a code review, my main worry is that all the
 > problems reported with those patches in -mm made it into the patchset that
 > went into Linus.. mainly things like forgetting to memset certain
 > structures to 0 and sillies like that...

I saw one report where the recent drm security hole fix broke dri
for one user.  Whilst it seems an isolated incident, could this have
more impact than we first realised ?

Worse case scenario we can drop out the multi-bridge support for now
if it needs work. Mike left SGI now, so we'll need to find someone else
with access to a Prism to make sure it still works correctly on a
real multi-gart system.

		Dave


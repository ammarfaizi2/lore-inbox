Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262645AbVCXSSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262645AbVCXSSo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 13:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263145AbVCXSSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 13:18:43 -0500
Received: from mx1.redhat.com ([66.187.233.31]:40844 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262645AbVCXSSY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 13:18:24 -0500
Date: Thu, 24 Mar 2005 13:18:06 -0500
From: Dave Jones <davej@redhat.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Dave Airlie <airlied@linux.ie>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
Subject: Re: drm bugs hopefully fixed but there might still be one..
Message-ID: <20050324181806.GA23567@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jesse Barnes <jbarnes@engr.sgi.com>, Dave Airlie <airlied@linux.ie>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	dri-devel@lists.sourceforge.net
References: <Pine.LNX.4.58.0503241015190.7647@skynet> <200503240902.03808.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503240902.03808.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2005 at 09:02:03AM -0800, Jesse Barnes wrote:
 > On Thursday, March 24, 2005 2:33 am, Dave Airlie wrote:
 > > Hi Andrew, Dave,
 > >
 > > I've put a couple of patches into my drm-2.6 tree that hopefully fix up
 > > the multi-bridge on i915 and the XFree86 4.3 issue.. Andrew can you drop
 > > the two patches in your tree.. the one from Brice and the one I attached
 > > to the bug? you'll get conflicts anyway I'm sure. I had to modify Brices
 > > one as it didn't look safe to me in all cases..
 > >
 > > I think their might be one left, but I think it only seems to be on
 > > non-intel AGP system, as in my system works fine for a combination of
 > > cards and X releases ... anyone with a VIA chipset and Radeon graphics
 > > card or r128 card.. testing the next -mm would help me a lot..
 > 
 > I'm trying to get ahold of one--so hopefully I'll be able to test and fix this 
 > stuff up when I do.

Aparently backing out the changes to via's tlb_flush routine fixed it
for one VIA user. I've not had a chance to look into it just yet.
Worse case we can just drop those changes for 2.6.12

		Dave



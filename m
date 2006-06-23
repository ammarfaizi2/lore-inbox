Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932732AbWFWAX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932732AbWFWAX7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 20:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbWFWAX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 20:23:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59360 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932732AbWFWAX7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 20:23:59 -0400
Date: Thu, 22 Jun 2006 20:23:49 -0400
From: Dave Jones <davej@redhat.com>
To: Andi Kleen <ak@muc.de>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86-64 build fix
Message-ID: <20060623002348.GF5604@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@muc.de>,
	Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
	torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <20060622205928.GA23801@havoc.gtf.org> <20060622142430.3219f352.akpm@osdl.org> <20060622223919.GB50270@muc.de> <20060622155943.27c98d61.akpm@osdl.org> <449B268E.4000808@garzik.org> <20060622233549.GA55538@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060622233549.GA55538@muc.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2006 at 01:35:49AM +0200, Andi Kleen wrote:
 > On Thu, Jun 22, 2006 at 07:23:58PM -0400, Jeff Garzik wrote:
 > > Andrew Morton wrote:
 > > >I don't think Jeff has sent us an example .config, but I hit this a few
 > > >times too, before we fixed it.  I think this was all triggered by a Kconfig
 > > >change in the AGP tree, so you wouldn't have seen it, but -mm did.
 > > 
 > > 'make allmodconfig' on x86-64.  You can create this .config yourself :)
 > > 
 > > I think the tree suffers [sometimes due to me :(] when 'allyesconfig' 
 > > and 'allmodconfig' stop working.
 > 
 > Yes, but they work in 2.6.17 right? 

worked for me, it only broke as of .17-git2 or so.

 > And nothing should have changed since 2.6.17 so far.
 > But apparently something did. What was it?

(for the 3rd time today)  INTEL_FB now builds on x86-64,
and selects AGP, so if INTEL_FB=m, AGP becomes =m too,
which breaks the select AGP which GART_IOMMU wants.

		Dave

-- 
http://www.codemonkey.org.uk

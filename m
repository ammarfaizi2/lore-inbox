Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932701AbWFVXej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932701AbWFVXej (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 19:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932700AbWFVXej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 19:34:39 -0400
Received: from xenotime.net ([66.160.160.81]:19109 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932675AbWFVXei (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 19:34:38 -0400
Date: Thu, 22 Jun 2006 16:37:24 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: davej@redhat.com, akpm@osdl.org, ak@muc.de, jeff@garzik.org,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86-64 build fix
Message-Id: <20060622163724.5b360e83.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.64.0606230124350.17704@scrub.home>
References: <20060622205928.GA23801@havoc.gtf.org>
	<20060622142430.3219f352.akpm@osdl.org>
	<20060622223919.GB50270@muc.de>
	<20060622155943.27c98d61.akpm@osdl.org>
	<20060622230138.GA6209@redhat.com>
	<Pine.LNX.4.64.0606230124350.17704@scrub.home>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2006 01:28:01 +0200 (CEST) Roman Zippel wrote:

> Hi,
> 
> On Thu, 22 Jun 2006, Dave Jones wrote:
> 
> > On Thu, Jun 22, 2006 at 03:59:43PM -0700, Andrew Morton wrote:
> > 
> >  > I don't think Jeff has sent us an example .config, but I hit this a few
> >  > times too, before we fixed it.  I think this was all triggered by a Kconfig
> >  > change in the AGP tree, so you wouldn't have seen it, but -mm did.
> > 
> > Not guilty your honour.
> > See my mail..
> > Subject: Re: intelfb: enable on x86_64
> > 
> > It got busted due to INTEL_FB becoming available on x86-64, and it doing
> > select AGP which if INTEL_FB was =m turned CONFIG_AGP=y into CONFIG_AGP=m
> > for who-knows-why reason.  This busts the IOMMU code which expects the AGP
> > code to be =y or =n
> 
> The select overrides the default (it actually overrides pretty much 
> everything, that's why one should be careful with it).

Just checking:  so the "select AGP"
sets CONFIG_AGP to the same level or value (m or y) as the option
where it is being used?


---
~Randy

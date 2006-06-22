Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932256AbWFVX2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbWFVX2y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 19:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932675AbWFVX2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 19:28:54 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:42438 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932256AbWFVX2x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 19:28:53 -0400
Date: Fri, 23 Jun 2006 01:28:01 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Dave Jones <davej@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, jeff@garzik.org,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86-64 build fix
In-Reply-To: <20060622230138.GA6209@redhat.com>
Message-ID: <Pine.LNX.4.64.0606230124350.17704@scrub.home>
References: <20060622205928.GA23801@havoc.gtf.org> <20060622142430.3219f352.akpm@osdl.org>
 <20060622223919.GB50270@muc.de> <20060622155943.27c98d61.akpm@osdl.org>
 <20060622230138.GA6209@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 22 Jun 2006, Dave Jones wrote:

> On Thu, Jun 22, 2006 at 03:59:43PM -0700, Andrew Morton wrote:
> 
>  > I don't think Jeff has sent us an example .config, but I hit this a few
>  > times too, before we fixed it.  I think this was all triggered by a Kconfig
>  > change in the AGP tree, so you wouldn't have seen it, but -mm did.
> 
> Not guilty your honour.
> See my mail..
> Subject: Re: intelfb: enable on x86_64
> 
> It got busted due to INTEL_FB becoming available on x86-64, and it doing
> select AGP which if INTEL_FB was =m turned CONFIG_AGP=y into CONFIG_AGP=m
> for who-knows-why reason.  This busts the IOMMU code which expects the AGP
> code to be =y or =n

The select overrides the default (it actually overrides pretty much 
everything, that's why one should be careful with it).

bye, Roman

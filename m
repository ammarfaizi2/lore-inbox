Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161432AbWFVXB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161432AbWFVXB5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 19:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161431AbWFVXB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 19:01:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23482 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161429AbWFVXB4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 19:01:56 -0400
Date: Thu, 22 Jun 2006 19:01:38 -0400
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@muc.de>, jeff@garzik.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86-64 build fix
Message-ID: <20060622230138.GA6209@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
	jeff@garzik.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <20060622205928.GA23801@havoc.gtf.org> <20060622142430.3219f352.akpm@osdl.org> <20060622223919.GB50270@muc.de> <20060622155943.27c98d61.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060622155943.27c98d61.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 03:59:43PM -0700, Andrew Morton wrote:

 > I don't think Jeff has sent us an example .config, but I hit this a few
 > times too, before we fixed it.  I think this was all triggered by a Kconfig
 > change in the AGP tree, so you wouldn't have seen it, but -mm did.

Not guilty your honour.
See my mail..
Subject: Re: intelfb: enable on x86_64

It got busted due to INTEL_FB becoming available on x86-64, and it doing
select AGP which if INTEL_FB was =m turned CONFIG_AGP=y into CONFIG_AGP=m
for who-knows-why reason.  This busts the IOMMU code which expects the AGP
code to be =y or =n

		Dave

-- 
http://www.codemonkey.org.uk

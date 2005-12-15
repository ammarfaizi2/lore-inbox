Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161098AbVLOFLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161098AbVLOFLN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 00:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161100AbVLOFLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 00:11:13 -0500
Received: from gate.crashing.org ([63.228.1.57]:24747 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1161087AbVLOFLL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 00:11:11 -0500
Subject: Re: [BUG] Xserver startup locks system... git bisect results
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Dave Airlie <airlied@linux.ie>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <1134622384.16880.26.camel@gaston>
References: <20051215043212.GA4479@jupiter.solarsys.private>
	 <1134622384.16880.26.camel@gaston>
Content-Type: text/plain
Date: Thu, 15 Dec 2005 16:07:21 +1100
Message-Id: <1134623242.16880.30.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ah, also, something else you can try, is replace

	dev_priv->gart_vm_start = dev_priv->fb_location
	    + RADEON_READ(RADEON_CONFIG_APER_SIZE);
with

#define RADEON_CONFIG_MEMSIZE                         0x00F8  
	dev_priv->gart_vm_start = dev_priv->fb_location
	    + RADEON_READ(RADEON_CONFIG_MEMSIZE);

And tell us if it helps ?

Ben.



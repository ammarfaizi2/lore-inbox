Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271045AbTHLSZy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 14:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271080AbTHLSZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 14:25:53 -0400
Received: from [66.212.224.118] ([66.212.224.118]:7175 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S271045AbTHLSZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 14:25:52 -0400
Date: Tue, 12 Aug 2003 14:14:01 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
Cc: Greg KH <greg@kroah.com>, long <tlnguyen@snoqualmie.dp.intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, linux-kernel@vger.kernel.org
Subject: RE: Updated MSI Patches
In-Reply-To: <C7AB9DA4D0B1F344BF2489FA165E5024015416F6@orsmsx404.jf.intel.com>
Message-ID: <Pine.LNX.4.53.0308121411590.26153@montezuma.mastecende.com>
References: <C7AB9DA4D0B1F344BF2489FA165E5024015416F6@orsmsx404.jf.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Aug 2003, Nguyen, Tom L wrote:

> > IMO Multiplexing would be preferred, we can't be allocating that many 
> > vectors for one device/device driver
> All pre-assigned vectors to all enabled IOxAPIC(s) are reserved.
> Allocating additional vectors to MSI-X driver is determined based on the
> available vectors, which must be greater than the number of vectors requested
> by MSI-X driver.

Hmm can you avoid grabbing all the free vectors? I think the irq 
controller subsystem should handle allocation of vectors. Letting MSI grab 
everything might leave us with problems later on.

	Zwane


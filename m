Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268654AbUHWXkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268654AbUHWXkk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 19:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268634AbUHWXjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 19:39:42 -0400
Received: from colin2.muc.de ([193.149.48.15]:7185 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S268591AbUHWXjY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 19:39:24 -0400
Date: 24 Aug 2004 01:39:20 +0200
Date: Tue, 24 Aug 2004 01:39:20 +0200
From: Andi Kleen <ak@muc.de>
To: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
Cc: Roland Dreier <roland@topspin.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [broken?] Add MSI support to e1000
Message-ID: <20040823233920.GA29854@muc.de>
References: <C7AB9DA4D0B1F344BF2489FA165E50240619DA25@orsmsx404.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C7AB9DA4D0B1F344BF2489FA165E50240619DA25@orsmsx404.amr.corp.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2004 at 12:41:36PM -0700, Nguyen, Tom L wrote:
> On Monday, August 23, 2004 Andi Kleen wrote:
> >There seems to be something wrong with the MSI code in the kernel.
> >I tried to add MSI support to the s2io driver on x86-64, but it just
> didn't
> >work (/proc/interrupts still displayed IO-APIC mode). I haven't 
> >investigated in detail yet though.
> 
> Would you please tell me whether the MSI enable bit of the MSI
> capability 
> structure of the s2io device is set or not after successfully calling 
> pci_enable_msi()?

Yes, the flag word is 0x8b after the call. And pci_enable_msi returns 0.

I guess it's an x86-64 specific issue? Did you test that recently?

-Andi

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263775AbUECQeC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbUECQeC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 12:34:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263781AbUECQeC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 12:34:02 -0400
Received: from colin2.muc.de ([193.149.48.15]:5391 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S263775AbUECQeA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 12:34:00 -0400
Date: 3 May 2004 18:33:57 +0200
Date: Mon, 3 May 2004 18:33:57 +0200
From: Andi Kleen <ak@muc.de>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [MICROPATCH] Make x86_64 build work without GART_IOMMU
Message-ID: <20040503163357.GA53645@colin2.muc.de>
References: <20040430220740.GA45095@colin2.muc.de> <20040503150958.6864.qmail@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040503150958.6864.qmail@lwn.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2004 at 09:09:58AM -0600, Jonathan Corbet wrote:
> > > "Nuts" means that the X server goes into an unkillable, 100% system time
> > > state.  It manages to scribble a mess onto the screen first.  Pointer moves
> > > (I believe that's in hardware) but the server does not respond to anything.
> > 
> > Most likely it is a problem with the AGP driver. I assume you have AGP 
> > compiled in. Does it work when you boot with agp=off ? 
> 
> If you turn on CONFIG_GART_IOMMU, it seems to force CONFIG_AGP as well, so
> yes.  And yes, if I boot with agp-off, it works.

Ok, and does it work when you make the AGP driver modular and load it
later? 

Anyways, from Andrew's findings it appears that DRI is broken on your
card and without AGP it will never be started. Perhaps it would 
be best to just disable the DRI module in your configuration.

-Andi

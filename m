Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbUD3WHr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbUD3WHr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 18:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbUD3WHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 18:07:47 -0400
Received: from colin2.muc.de ([193.149.48.15]:49931 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261628AbUD3WHm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 18:07:42 -0400
Date: 1 May 2004 00:07:40 +0200
Date: Sat, 1 May 2004 00:07:40 +0200
From: Andi Kleen <ak@muc.de>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [MICROPATCH] Make x86_64 build work without GART_IOMMU
Message-ID: <20040430220740.GA45095@colin2.muc.de>
References: <m3ad0t9o54.fsf@averell.firstfloor.org> <20040430214040.25268.qmail@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040430214040.25268.qmail@lwn.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2004 at 03:40:40PM -0600, Jonathan Corbet wrote:
> > > My Radeon 9200SE goes nuts if I build a GART-enabled
> > > kernel.  Haven't figured out why...
> > 
> > Define 'nuts' and supply full boot log (with GART enabled)
> 
> Oops, sorry for the technical term...:)
> 
> "Nuts" means that the X server goes into an unkillable, 100% system time
> state.  It manages to scribble a mess onto the screen first.  Pointer moves
> (I believe that's in hardware) but the server does not respond to anything.

Most likely it is a problem with the AGP driver. I assume you have AGP 
compiled in. Does it work when you boot with agp=off ? 

IOMMU GART initialises the AGP driver early.

-Andi

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161446AbWHJQrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161446AbWHJQrI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 12:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161441AbWHJQrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 12:47:08 -0400
Received: from waste.org ([66.93.16.53]:56987 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1161423AbWHJQrG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 12:47:06 -0400
Date: Thu, 10 Aug 2006 11:45:48 -0500
From: Matt Mackall <mpm@selenic.com>
To: Jeff Dike <jdike@addtoit.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net,
       Joern Engel <joern@wohnheim.fh-wedel.de>
Subject: Re: [PATCH] UML - support checkstack
Message-ID: <20060810164548.GS6908@waste.org>
References: <200608091815.k79IFQVB005310@ccure.user-mode-linux.org> <20060810020922.GO6908@waste.org> <20060810042216.GA7754@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060810042216.GA7754@ccure.user-mode-linux.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2006 at 12:22:16AM -0400, Jeff Dike wrote:
> On Wed, Aug 09, 2006 at 09:09:22PM -0500, Matt Mackall wrote:
> > On Wed, Aug 09, 2006 at 02:15:24PM -0400, Jeff Dike wrote:
> > > Make checkstack work for UML.  We need to pass the underlying architecture
> > > name, rather than "um" to checkstack.pl.
> > 
> > Does this do the right thing with something like Voyager?
> 
> SUBARCH has a different meaning here.  For UML, it's the underlying,
> host, architecture, not a variant architecture like Voyager.

Right, so it sounds like this breaks Voyager. Which I think means we
ought to pass ARCH and SUBARCH and do the right thing inside
checkstack.

-- 
Mathematics is the supreme nostalgia of our time.

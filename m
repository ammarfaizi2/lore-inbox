Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264900AbUFRXhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264900AbUFRXhV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 19:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265541AbUFRXXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 19:23:17 -0400
Received: from outmail1.freedom2surf.net ([194.106.33.237]:16782 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S264965AbUFRXVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 19:21:30 -0400
Date: Sat, 19 Jun 2004 00:20:51 +0100
From: Ian Molton <spyro@f2s.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: James.Bottomley@steeleye.com, benh@kernel.crashing.org, jamey.hicks@hp.com,
       linux-kernel@vger.kernel.org, greg@kroah.com, tony@atomide.com,
       david-b@pacbell.net, joshua@joshuawise.com
Subject: Re: DMA API issues
Message-Id: <20040619002051.66661ff4.spyro@f2s.com>
In-Reply-To: <20040618222014.D17516@flint.arm.linux.org.uk>
References: <1087582845.1752.107.camel@mulgrave>
	<20040618193544.48b88771.spyro@f2s.com>
	<1087584769.2134.119.camel@mulgrave>
	<40D340FB.3080309@hp.com>
	<1087589651.8210.288.camel@gaston>
	<1087590286.2135.161.camel@mulgrave>
	<20040618222014.D17516@flint.arm.linux.org.uk>
Organization: The Dragon Roost
X-Mailer: Sylpheed version 0.9.12-gtk2-20040617 (GTK+ 2.4.1; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2004 22:20:14 +0100
Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> > Yes, we do this on parisc too.  We actually have a hidden method
> > pointer(per platform) and cache the iommu (we have more than one)
> > accessors in platform_data.
> 
> Except that platform_data already has multiple other uses, especially
> for platform devices.

In the case of the SOC devices I described, its actually appropriate to
make the allocator system tied to the bus - as several devices end up
sharing the same 32K pool in the device. at the device level the
allocator would be useless in these cases.

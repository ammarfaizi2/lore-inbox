Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262906AbUFRUoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbUFRUoV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 16:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261880AbUFRUky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 16:40:54 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:28573 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262906AbUFRUY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 16:24:59 -0400
Subject: Re: DMA API issues
From: James Bottomley <James.Bottomley@steeleye.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jamey Hicks <jamey.hicks@hp.com>, Ian Molton <spyro@f2s.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, tony@atomide.com,
       David Brownell <david-b@pacbell.net>, joshua@joshuawise.com
In-Reply-To: <1087589651.8210.288.camel@gaston>
References: <1087582845.1752.107.camel@mulgrave>
	<20040618193544.48b88771.spyro@f2s.com>
	<1087584769.2134.119.camel@mulgrave>  <40D340FB.3080309@hp.com> 
	<1087589651.8210.288.camel@gaston>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 18 Jun 2004 15:24:45 -0500
Message-Id: <1087590286.2135.161.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-06-18 at 15:14, Benjamin Herrenschmidt wrote:
> I wanted to do just that a while ago, and ended up doing things a bit
> differently, but still, I agree that would help. The thing is, you
> can do that in your platform code. just use the platform data pointer
> in struct device to stuff a ptr to the structure with your "ops"

Yes, we do this on parisc too.  We actually have a hidden method pointer
(per platform) and cache the iommu (we have more than one) accessors in
platform_data.

The problem is, though, that I really don't think this interface would
benefit from being made public (or part of the API).  There are too many
nasty quirks in the platform for this (at least in our case).

James





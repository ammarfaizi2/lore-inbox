Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbUFSBEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbUFSBEv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 21:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265727AbUFSBDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 21:03:14 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:38296 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S266804AbUFRUH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 16:07:56 -0400
Subject: Re: DMA API issues
From: James Bottomley <James.Bottomley@steeleye.com>
To: Oliver Neukum <oliver@neukum.org>
Cc: Jamey Hicks <jamey.hicks@hp.com>, Ian Molton <spyro@f2s.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, greg@kroah.com,
       tony@atomide.com, david-b@pacbell.net, joshua@joshuawise.com
In-Reply-To: <200406182202.13528.oliver@neukum.org>
References: <1087582845.1752.107.camel@mulgrave> <40D340FB.3080309@hp.com>
	<1087587669.1752.147.camel@mulgrave>  <200406182202.13528.oliver@neukum.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 18 Jun 2004 15:07:35 -0500
Message-Id: <1087589270.2135.158.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-06-18 at 15:02, Oliver Neukum wrote:
> Am Freitag, 18. Juni 2004 21:41 schrieb James Bottomley:
> > Well, I thought it was something like that.  So the problem could be
> > solved simply by rejigging ohci to export td_alloc and td_free as
> > overrideable methods?
> 
> Unfortunately no. Usb_buffer_alloc() needs to know about the restriction,
> too.

But usb_buffer_alloc is already an indirected operation, it looks like
it can be easily overridden to do precisely what you want.

James



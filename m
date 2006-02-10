Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751396AbWBJXWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbWBJXWx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 18:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWBJXWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 18:22:53 -0500
Received: from streetfiresound.liquidweb.com ([64.91.233.29]:26336 "EHLO
	host.streetfiresound.liquidweb.com") by vger.kernel.org with ESMTP
	id S1751396AbWBJXWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 18:22:52 -0500
Subject: Re: [PATCH] spi: Updated PXA2xx SSP SPI Driver
From: Stephen Street <stephen@streetfiresound.com>
Reply-To: stephen@streetfiresound.com
To: Nicolas Pitre <nico@cam.org>
Cc: lkml <linux-kernel@vger.kernel.org>, dvrabel@arcom.com,
       David Brownell <david-b@pacbell.net>,
       spi-devel-general@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602101732590.5397@localhost.localdomain>
References: <43e80ec3.oEr+gtyMVtunRTyE%stephen@streetfiresound.com>
	 <1139535480.30189.30.camel@ststephen.streetfiresound.com>
	 <Pine.LNX.4.64.0602101102520.5397@localhost.localdomain>
	 <1139609981.30189.84.camel@ststephen.streetfiresound.com>
	 <Pine.LNX.4.64.0602101732590.5397@localhost.localdomain>
Content-Type: text/plain
Organization: StreetFire Sound Labs
Date: Fri, 10 Feb 2006 15:22:48 -0800
Message-Id: <1139613768.30189.139.camel@ststephen.streetfiresound.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-22) 
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host.streetfiresound.liquidweb.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - streetfiresound.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-10 at 17:45 -0500, Nicolas Pitre wrote:
> 
> Actually, it will do almost the same as you originally did if you look 
> at its definition.  However, because a solution needs to be implemented 
> to support multiple ports then using __raw_readl() at the driver level 
> is more familiar to other kernel people.
> 
Yea, I did notice that also.  I just wanted to make sure I understood
what is going on so that I do not make the same mistake for the third
time.

> In fact, if there was only one SSP port, I'd have asked you to use 
> SSPCR0, SSPDR, etc. directly.  But the fact that the driver can handle 
> multiple ports makes it rather messy (and the SSP*_P() macros in 
> pxa-regs.h are an abomination IMHO).
> 
I did not use the SSP*_P functions because of the mess.  Actually at one
point the driver implemented register accesses in similar manner as
SSP*_P but David Brownell got me straightened out.  Thus the original
question.

Stephen




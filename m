Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbUCQOc2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 09:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbUCQOc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 09:32:28 -0500
Received: from mail.zmailer.org ([62.78.96.67]:52494 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S261503AbUCQOcZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 09:32:25 -0500
Date: Wed, 17 Mar 2004 16:32:12 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: RANDAZZO@ddc-web.com
Cc: linux-kernel@vger.kernel.org, linux-newbie@vger.kernel.org
Subject: Re: Arp Implementation Example....
Message-ID: <20040317143212.GX1653@mea-ext.zmailer.org>
References: <89760D3F308BD41183B000508BAFAC4104B17006@DDCNYNTD>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89760D3F308BD41183B000508BAFAC4104B17006@DDCNYNTD>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2004 at 08:39:37AM -0500, RANDAZZO@ddc-web.com wrote:
> All;
> 
> I am developed a network driver for my fibre channel device.
> I've used the O'Reilly Linux Device Driver's "snull.c and snull.h"
> as an example.
> 
> Problem is this example does not implement ARP.  After many attempts, I
> can't seem to pass an ARP packet successfully up
> the stack......

  ARP-request is just one more of network packets that are passed
  up into network code like any other by calling  netif_rx().
  As long as the packet is recognizable by the upper layers as
  an SKBUF with ARP request, all will be fine.

  Oh yes,  not all network interfaces need to support ARP at all.
  The PPP is one such example.  Nor do all ARP request frames carry
  same tags as ethernet ARP does.   Nevertheless one can pass ARP-
  requests thru a PPP link. See  drivers/net/ppp*  files about
  how that is handled.

> Does anyone know of an example driver / website that shows the formatting
> and responsibility of the network driver, with regards
> to ARP?
> 
> Any help is much appreciated...
> 
> BTW, I'm using Linux 2.4....

/Matti Aarnio

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262965AbUKRVFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262965AbUKRVFS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 16:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbUKRVDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 16:03:18 -0500
Received: from mail.timesys.com ([65.117.135.102]:1097 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261161AbUKRVAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 16:00:50 -0500
Subject: Re: [PATCH] MII bus API for PHY devices
From: Jason McMullan <jason.mcmullan@timesys.com>
To: Andy Fleming <afleming@freescale.com>
Cc: "<netdev@oss.sgi.com>" <netdev@oss.sgi.com>,
       "<linux-kernel@vger.kernel.org>" <linux-kernel@vger.kernel.org>
In-Reply-To: <2B68D9FA-399B-11D9-96F6-000393C30512@freescale.com>
References: <069B6F33-341C-11D9-9652-000393DBC2E8@freescale.com>
	 <9B0D9272-398A-11D9-96F6-000393C30512@freescale.com>
	 <1100806489.14467.47.camel@jmcmullan>
	 <2B68D9FA-399B-11D9-96F6-000393C30512@freescale.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 18 Nov 2004 16:00:47 -0500
Message-Id: <1100811647.14467.52.camel@jmcmullan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1-1mdk 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-18 at 13:50 -0600, Andy Fleming wrote:
> Jason McMullan said:
> >
> > Actually, each PHY should have it's own device directory, like every
> > other device. Eventually, PHYs should have /dev/phy* entries, where
> > user-space can read/write PHY registers.
> 
> I think you misunderstood.  Are you talking about sysfs?  I was talking 
> about actual source files.  i.e. should there be dm9161.c, m88e1101.c, 
> cis8201.c, etc.

	Yes, I am talking about sysfs. And yes, I think every PHY should have
it's own .c file. (although most people could get away with
using a non-IRQ 'drivers/net/phy/phy-generic.c'

> Also, do we need user-space to read/write PHY registers.  ethtool has 
> this capability, I believe, and the interfaces there are settled.

Doh! I forgot.

-- 
Jason McMullan <jason.mcmullan@timesys.com>

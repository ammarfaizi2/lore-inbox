Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261478AbUKSQll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261478AbUKSQll (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 11:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbUKSQll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 11:41:41 -0500
Received: from mail.timesys.com ([65.117.135.102]:5021 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261478AbUKSQlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 11:41:39 -0500
Subject: Re: [PATCH] MII bus API for PHY devices
From: Jason McMullan <jason.mcmullan@timesys.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andy Fleming <afleming@freescale.com>, netdev@oss.sgi.com,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1100820391.25521.14.camel@gaston>
References: <069B6F33-341C-11D9-9652-000393DBC2E8@freescale.com>
	 <9B0D9272-398A-11D9-96F6-000393C30512@freescale.com>
	 <1100820391.25521.14.camel@gaston>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 19 Nov 2004 11:41:38 -0500
Message-Id: <1100882498.14467.58.camel@jmcmullan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1-1mdk 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-11-19 at 10:26 +1100, Benjamin Herrenschmidt wrote:
> The ethernet driver can instanciate the PHYs at it's childs, though the
> case of several MACs sharing PHYs will be difficult to represent...

I think *requiring* a binding to ethernet devices is a bad idea. 

For example, on many MPC8260 embedded systems, the MII bus is controlled
by GPIO pins, not an ethernet MDIO system.

Some applications may use the MII bus to control non-PHY devices, such
as Broadcom ethernet switches. I'm working for a general MII bus that
ethernet PHYs and other devices can all use.

-- 
Jason McMullan <jason.mcmullan@timesys.com>

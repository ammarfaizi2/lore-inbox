Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262935AbUKRUHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262935AbUKRUHw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 15:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262950AbUKRUGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 15:06:17 -0500
Received: from motgate7.mot.com ([129.188.136.7]:37351 "EHLO motgate7.mot.com")
	by vger.kernel.org with ESMTP id S262935AbUKRTvQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 14:51:16 -0500
In-Reply-To: <1100806489.14467.47.camel@jmcmullan>
References: <069B6F33-341C-11D9-9652-000393DBC2E8@freescale.com> <9B0D9272-398A-11D9-96F6-000393C30512@freescale.com> <1100806489.14467.47.camel@jmcmullan>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2B68D9FA-399B-11D9-96F6-000393C30512@freescale.com>
Content-Transfer-Encoding: 7bit
Cc: "<netdev@oss.sgi.com>" <netdev@oss.sgi.com>,
       "<linux-kernel@vger.kernel.org>" <linux-kernel@vger.kernel.org>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH] MII bus API for PHY devices
Date: Thu, 18 Nov 2004 13:50:59 -0600
To: Jason McMullan <jason.mcmullan@timesys.com>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Nov 18, 2004, at 13:34, Jason McMullan wrote:
>> 3) How should we bind ethernet drivers to PHY drivers?
>
> A PHY 'platform_data' struct like:
>
> struct phy_device_data {
> 	struct {
> 		const char *name;
> 		int id;
> 	} ethernet_platform_device_parent;
> 	int	phy_id;
> }

So you would have each PHY know the controller to which it's attached?  
I would have thought the other way around... Hm.  I will definitely 
have to read up on my driver model stuff

> 	
>> Oh, and a 4th side-issue:
>> Should each PHY have its own file?
>
> Actually, each PHY should have it's own device directory, like every
> other device. Eventually, PHYs should have /dev/phy* entries, where
> user-space can read/write PHY registers.

I think you misunderstood.  Are you talking about sysfs?  I was talking 
about actual source files.  i.e. should there be dm9161.c, m88e1101.c, 
cis8201.c, etc.

Also, do we need user-space to read/write PHY registers.  ethtool has 
this capability, I believe, and the interfaces there are settled.

Andy Fleming


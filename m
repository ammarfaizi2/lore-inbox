Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264301AbTLYMhU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 07:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264303AbTLYMhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 07:37:20 -0500
Received: from waste.org ([209.173.204.2]:1727 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S264301AbTLYMhS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 07:37:18 -0500
Date: Thu, 25 Dec 2003 06:36:37 -0600
From: Matt Mackall <mpm@selenic.com>
To: George Anzinger <george@mvista.com>
Cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       dilinger@voxel.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] more CardServices() removals (drivers/net/wireless)
Message-ID: <20031225123637.GK18208@waste.org>
References: <1072229780.5300.69.camel@spiral.internal> <20031223182817.0bd3dd3c.akpm@osdl.org> <3FE8FC2E.3080701@pobox.com> <20031223184827.4cfb87e2.akpm@osdl.org> <3FE9022A.7010604@pobox.com> <20031223202305.489c409f.akpm@osdl.org> <20031224043349.GI18208@waste.org> <3FEAB1D6.9030209@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FEAB1D6.9030209@mvista.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 25, 2003 at 01:45:58AM -0800, George Anzinger wrote:
> 
> By the way, in my looking at the network link stuff, I started wondering if 
> it could not be done without modifying the card stuff.  Here is what I see:
> 
> The poll routine just calls the interrupt handler.  We only need the 
> address of that routine and a generic poll function to do the indirect 
> call.  That address, once the link is up, can be found in the interrupt 
> tables using the irq.

Netpoll did exactly this in an earlier incarnation, but Jeff
eventually convinced me it was problematic.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting

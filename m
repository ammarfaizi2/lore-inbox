Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264963AbTLKOao (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 09:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264964AbTLKOao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 09:30:44 -0500
Received: from fed1mtao07.cox.net ([68.6.19.124]:50853 "EHLO
	fed1mtao07.cox.net") by vger.kernel.org with ESMTP id S264963AbTLKOan
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 09:30:43 -0500
Date: Thu, 11 Dec 2003 07:32:56 -0700
From: Jesse Allen <the3dfxdude@hotmail.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Ross Dickson <ross@datscreative.com.au>, linux-kernel@vger.kernel.org,
       AMartin@nvidia.com
Subject: Re: Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
Message-ID: <20031211143256.GA162@tesore.local>
References: <200312072312.01013.ross@datscreative.com.au> <20031210033906.GA176@tesore.local> <16342.61127.717756.446723@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16342.61127.717756.446723@alkaid.it.uu.se>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 10, 2003 at 11:00:39AM +0100, Mikael Pettersson wrote:
> Please try without this delay but with the disconnect PCI quirk.
> 


OK,  I have tried it without the delay, and with Ross' timer patch.  It will obviously lockup, and nmi_watchdog doesn't work.  Added the disconnect quirk patch, and lockups are gone and nmi_watchdog works.  So there is no difference between the disconnect patch or the ACK delay patch.  Though I found nmi_watchdog does depend on having either the disconnect patch or the delay patch (not an io_apic patch).  You think the disconnect patch is better?  In any event, they both indicate a behavior, and there maybe a better solution to all of it.

Jesse

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbWBQR5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbWBQR5U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 12:57:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWBQR5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 12:57:20 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:36606 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750714AbWBQR5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 12:57:19 -0500
Date: Fri, 17 Feb 2006 13:49:38 -0500
From: Adam Kropelin <akropel1@rochester.rr.com>
To: philippe.seewer@bfh.ch
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       tsbogend@alpha.franken.de
Subject: Re: [PATCH 2/2] pcnet32: PHY selection support
Message-ID: <20060217134938.B24429@mail.kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <43F5F672.9080904@bfh.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seewer Philippe wrote:
> Most AMD pcnet chips support up to 32 external PHYs. This patch
> introduces basic PHY selection/switching support, by adding two
> new module parameters:
> -maxphy: how many PHYs the card supports
> -usephy: which phy to use instead of eeprom default
> 
> Maxphy is necessary in order to check the range of usephy and may
> be overriden inside the module.

It seems a bit pointless for the range check of a user-supplied value to
be driven by another user-supplied value.

> If only maxphy is present I've implemented an algorithm which checks
> the link state on all PHYs and uses the one that has a link.

Knowing how many PHYs to scan is potentially useful, but how about
determining that at runtime? Missing PHYs should be detectable with a
timeout or similar. Too risky?

--Adam


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750837AbVJSMAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbVJSMAr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 08:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbVJSMAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 08:00:47 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:25606 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1750837AbVJSMAq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 08:00:46 -0400
Date: Wed, 19 Oct 2005 08:00:24 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [patch 2.6.14-rc3 2/3] sundance: probe PHYs from MII address 0
Message-ID: <20051019120022.GA15438@tuxdriver.com>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <10182005213101.12810@bilbo.tuxdriver.com> <4355B017.4040509@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4355B017.4040509@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2005 at 10:31:51PM -0400, Jeff Garzik wrote:
> John W. Linville wrote:

> >--- a/drivers/net/sundance.c
> >+++ b/drivers/net/sundance.c
> >@@ -608,7 +608,7 @@ static int __devinit sundance_probe1 (st
> > 
> > 	np->phys[0] = 1;		/* Default setting */
> > 	np->mii_preamble_required++;
> >-	for (phy = 1; phy < 32 && phy_idx < MII_CNT; phy++) {
> >+	for (phy = 0; phy < 32 && phy_idx < MII_CNT; phy++) {
> 
> NAK.  MII address 0 should be scanned _last_, after all other addresses. 
>  In some phys, it is a ghost, mirroring another address.
> 
> Take a look at some of the original Becker MII scan code from
> ftp://ftp.scyld.com/pub/network/ to see an elegant method for this.

Hmmm...that is clever...patch to follow...

John
-- 
John W. Linville
linville@tuxdriver.com

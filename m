Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262589AbUKLQvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262589AbUKLQvQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 11:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262581AbUKLQtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 11:49:23 -0500
Received: from mail.timesys.com ([65.117.135.102]:39585 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S262569AbUKLQrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 11:47:31 -0500
Subject: Re: [PATCH] MII bus API for PHY devices
From: Jason McMullan <jason.mcmullan@timesys.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, romieu@fr.zoreil.com
In-Reply-To: <1100240131.20512.47.camel@gaston>
References: <20041111224845.GA12646@jmcmullan.timesys>
	 <1100240131.20512.47.camel@gaston>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 12 Nov 2004 11:47:26 -0500
Message-Id: <1100278046.17607.23.camel@jmcmullan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1-1mdk 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-11-12 at 17:15 +1100, Benjamin Herrenschmidt wrote:
> Have you looked at what sungem/sungem_phy does ?
> 
> Among others, sungem has an algorithm for automatically testing fallback
> forced speeds when aneg fails, which has proven useful with a variety of
> PHY/hub combos, plus a "magic_aneg" bit in the PHY definition for PHYs
> taht can do that themselves automatically.

	I'll look into it.

> Also, besides shutdown(), you probably want a suspend() callback used by
> the MAC driver when the machine is entering a suspend() state (I
> definitely need that with various PHYs on powermacs) along with the
> various WOL parameters.

	For the 'wake on lan' stuff, could you give me a list of the
types of features you'd need? I haven't really looked at WOL just yet.

	We can add WOL, suspend, etc. as needed. I just want to
get the base infrastructure in first, and gradually start migrating
phys to the mii_bus on embedded systems.

-- 
Jason McMullan <jason.mcmullan@timesys.com>

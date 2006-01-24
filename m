Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030235AbWAXAcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030235AbWAXAcM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 19:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030236AbWAXAcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 19:32:12 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:29413
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030235AbWAXAcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 19:32:10 -0500
Date: Mon, 23 Jan 2006 16:30:37 -0800 (PST)
Message-Id: <20060123.163037.52587086.davem@davemloft.net>
To: benh@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sungem: Make PM of PHYs more reliable (#2)
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1137899170.24244.1.camel@localhost.localdomain>
References: <1137899170.24244.1.camel@localhost.localdomain>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sun, 22 Jan 2006 14:06:10 +1100

> On my latest laptop, I've had occasional PHY dead on wakeup from
> sleep... the PHY would be totally unresponsive even to toggling the hard
> reset line until the machine is powered down... Looking closely at the
> code, I found some possible issues in the way we setup the MDIO lines
> during suspend along with slight divergences from what Darwin does when
> resetting it that may explain the problem. That patch change these and
> the problem appear to be gone for me at least... I also fixed an mdelay
> -> msleep while I was at it to the pmac feature code that is called
> when toggling the PHY reset line since sungem doesn't call it in an
> atomic context anymore.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Applied, thanks Ben.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262450AbUKLGQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbUKLGQJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 01:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262457AbUKLGQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 01:16:09 -0500
Received: from gate.crashing.org ([63.228.1.57]:39342 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262450AbUKLGQG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 01:16:06 -0500
Subject: Re: [PATCH] MII bus API for PHY devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jason McMullan <jason.mcmullan@timesys.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, romieu@fr.zoreil.com
In-Reply-To: <20041111224845.GA12646@jmcmullan.timesys>
References: <20041111224845.GA12646@jmcmullan.timesys>
Content-Type: text/plain
Date: Fri, 12 Nov 2004 17:15:31 +1100
Message-Id: <1100240131.20512.47.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-11 at 17:48 -0500, Jason McMullan wrote:
> Second attempt, more polish.
> 
> (Though I'm leaving my macro abuse in for now!)
> 
> Description: MII Bus interface
> Date:        Thu, 11 Nov 2004 17:44:57 -0500
> Signed-off-by:  Jason McMullan <jmcmullan@timesys.com>
> Depends:
> 	linux-2.6.9

Have you looked at what sungem/sungem_phy does ?

Among others, sungem has an algorithm for automatically testing fallback
forced speeds when aneg fails, which has proven useful with a variety of
PHY/hub combos, plus a "magic_aneg" bit in the PHY definition for PHYs
taht can do that themselves automatically.

Also, besides shutdown(), you probably want a suspend() callback used by
the MAC driver when the machine is entering a suspend() state (I
definitely need that with various PHYs on powermacs) along with the
various WOL parameters.

Ben.



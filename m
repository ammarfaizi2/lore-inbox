Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262140AbUKJXAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262140AbUKJXAq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 18:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262141AbUKJXAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 18:00:45 -0500
Received: from gate.crashing.org ([63.228.1.57]:61343 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262140AbUKJXAe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 18:00:34 -0500
Subject: Re: [(broken) PATCH] Sungem and wake_on_lan
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Colin Leroy <colin.lkml@colino.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com
In-Reply-To: <20041109151154.43c897dd.colin.lkml@colino.net>
References: <20041109151154.43c897dd.colin.lkml@colino.net>
Content-Type: text/plain
Date: Thu, 11 Nov 2004 09:57:36 +1100
Message-Id: <1100127457.25814.19.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-09 at 15:11 +0100, Colin Leroy wrote:
> Hi everyone,
> 
> I'm trying to implement wake_on_lan in sungem. I did it by mimicking the
> Darwin AppleGMACEthernet driver. 
> I have some problems with it; not only it doesn't work (pinging the
> target machine does not wake it up, nor does ether-wake.c), but also the
> normal resume crashes instead of working - before powering screen up,
> so no log available...
> 
> My laptop has a BCM5221 PHY, I suppose it supports WOL but did not
> check. Anyway it shouldn't crash on normal resume, as Darwin's driver
> doesn't seem to have special cases depending on PHYs.
> 
> Before putting the laptop to sleep, I issue a 'sudo ethtool -s eth0 wol p'
> to enable gp->wake_on_lan.
> 
> Here's the patch, in case anyone (BenH, David Miller ? :)) has an idea
> about something i do wrong. 
> Thanks,

Not sure at this point why it would die, but I'm pretty sure you must
edit the PHY PM code too in sungem_phy.c to not shut it down :)

Darwin does have some special cases for PHYs.

Ben.


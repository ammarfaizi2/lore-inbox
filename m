Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261388AbVGHHd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbVGHHd6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 03:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbVGHHd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 03:33:58 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:9932
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261388AbVGHHd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 03:33:57 -0400
Date: Fri, 08 Jul 2005 00:33:33 -0700 (PDT)
Message-Id: <20050708.003333.28789082.davem@davemloft.net>
To: ink@jurassic.park.msu.ru
Cc: linville@tuxdriver.com, rmk+lkml@arm.linux.org.uk, matthew@wil.cx,
       grundler@parisc-linux.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, greg@kroah.com,
       ambx1@neo.rr.com
Subject: Re: [patch 2.6.12 (repost w/ corrected subject)] pci: restore BAR
 values in pci_enable_device_bars
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050708110358.A8491@jurassic.park.msu.ru>
References: <20050708095104.A612@den.park.msu.ru>
	<20050707.233530.85417983.davem@davemloft.net>
	<20050708110358.A8491@jurassic.park.msu.ru>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Date: Fri, 8 Jul 2005 11:03:58 +0400

> On Thu, Jul 07, 2005 at 11:35:30PM -0700, David S. Miller wrote:
> > That's fine, what would be the most minimal implementation?
> 
> #define pci_update_resource(dev, res, n)	BUG()
> 
> No, I'm serious - I don't believe that generic implementation of
> pcibios_resource_to_bus() in the proposed patch does the right thing
> on sparc64 anyway.

We really don't do power management on sparc64 at all currently,
besides cpufreq, so I guess this would be OK.

Do PCI devices ever come out of reset in a PM state, and thus
would execute John's new code as a side effect?

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262155AbVGHIVC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262155AbVGHIVC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 04:21:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbVGHIVC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 04:21:02 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:52888 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S262155AbVGHIU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 04:20:56 -0400
Date: Fri, 8 Jul 2005 12:20:43 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: "David S. Miller" <davem@davemloft.net>
Cc: linville@tuxdriver.com, rmk+lkml@arm.linux.org.uk, matthew@wil.cx,
       grundler@parisc-linux.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, greg@kroah.com,
       ambx1@neo.rr.com
Subject: Re: [patch 2.6.12 (repost w/ corrected subject)] pci: restore BAR values in pci_enable_device_bars
Message-ID: <20050708122043.A8779@jurassic.park.msu.ru>
References: <20050708095104.A612@den.park.msu.ru> <20050707.233530.85417983.davem@davemloft.net> <20050708110358.A8491@jurassic.park.msu.ru> <20050708.003333.28789082.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050708.003333.28789082.davem@davemloft.net>; from davem@davemloft.net on Fri, Jul 08, 2005 at 12:33:33AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2005 at 12:33:33AM -0700, David S. Miller wrote:
> Do PCI devices ever come out of reset in a PM state, and thus
> would execute John's new code as a side effect?

PCI spec requires that all devices must enter D0 state from
power on reset, so this code shouldn't be executed unless you
have some really buggy PM firmware (which is unlikely :-).

Ivan.

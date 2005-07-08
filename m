Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261432AbVGHHES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbVGHHES (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 03:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbVGHHES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 03:04:18 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:41624 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S261432AbVGHHEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 03:04:16 -0400
Date: Fri, 8 Jul 2005 11:03:58 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: "David S. Miller" <davem@davemloft.net>
Cc: linville@tuxdriver.com, rmk+lkml@arm.linux.org.uk, matthew@wil.cx,
       grundler@parisc-linux.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, greg@kroah.com,
       ambx1@neo.rr.com
Subject: Re: [patch 2.6.12 (repost w/ corrected subject)] pci: restore BAR values in pci_enable_device_bars
Message-ID: <20050708110358.A8491@jurassic.park.msu.ru>
References: <20050708005701.GA13384@tuxdriver.com> <20050707.201103.41635951.davem@davemloft.net> <20050708095104.A612@den.park.msu.ru> <20050707.233530.85417983.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050707.233530.85417983.davem@davemloft.net>; from davem@davemloft.net on Thu, Jul 07, 2005 at 11:35:30PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2005 at 11:35:30PM -0700, David S. Miller wrote:
> That's fine, what would be the most minimal implementation?

#define pci_update_resource(dev, res, n)	BUG()

No, I'm serious - I don't believe that generic implementation of
pcibios_resource_to_bus() in the proposed patch does the right thing
on sparc64 anyway.

Ivan.

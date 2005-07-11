Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261675AbVGKNQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbVGKNQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 09:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbVGKNQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 09:16:25 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:60165 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S261674AbVGKNQY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 09:16:24 -0400
Date: Mon, 11 Jul 2005 09:15:22 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Lennert Buytenhek <buytenh+lkml@liacs.nl>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       "David S. Miller" <davem@davemloft.net>, rmk+lkml@arm.linux.org.uk,
       matthew@wil.cx, grundler@parisc-linux.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.osdl.org,
       linux-kernel@vger.kernel.org, greg@kroah.com, ambx1@neo.rr.com,
       byjac@matfyz.cz, herbertb@cs.vu.nl
Subject: Re: [patch 2.6.13-rc2] pci: restore BAR values from pci_set_power_state for D3hot->D0
Message-ID: <20050711131518.GB23093@tuxdriver.com>
Mail-Followup-To: Lennert Buytenhek <buytenh+lkml@liacs.nl>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	"David S. Miller" <davem@davemloft.net>, rmk+lkml@arm.linux.org.uk,
	matthew@wil.cx, grundler@parisc-linux.org,
	linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.osdl.org,
	linux-kernel@vger.kernel.org, greg@kroah.com, ambx1@neo.rr.com,
	byjac@matfyz.cz, herbertb@cs.vu.nl
References: <20050708095104.A612@den.park.msu.ru> <20050707.233530.85417983.davem@davemloft.net> <20050708110358.A8491@jurassic.park.msu.ru> <20050708.003333.28789082.davem@davemloft.net> <20050708122043.A8779@jurassic.park.msu.ru> <20050708183452.GB13445@tuxdriver.com> <20050711144844.A16143@tin.liacs.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050711144844.A16143@tin.liacs.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2005 at 02:48:44PM +0200, Lennert Buytenhek wrote:
> On Fri, Jul 08, 2005 at 02:34:56PM -0400, John W. Linville wrote:
> 
> > Some PCI devices lose all configuration (including BARs) when
> > transitioning from D3hot->D0.  This leaves such a device in an
> > inaccessible state.  The patch below causes the BARs to be restored
> > when enabling such a device, so that its driver will be able to
> > access it.
> 
> It might be useful to have this functionality exported to outside of
> the generic PCI code.

Fine by me...patch to follow...

John
-- 
John W. Linville
linville@tuxdriver.com

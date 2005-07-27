Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262252AbVG0OTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262252AbVG0OTc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 10:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262264AbVG0OTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 10:19:32 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:7443 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S262252AbVG0OS6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 10:18:58 -0400
Date: Wed, 27 Jul 2005 10:12:04 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Greg KH <greg@kroah.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       "David S. Miller" <davem@davemloft.net>, rmk+lkml@arm.linux.org.uk,
       matthew@wil.cx, grundler@parisc-linux.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.osdl.org,
       linux-kernel@vger.kernel.org, ambx1@neo.rr.com
Subject: Re: [patch 2.6.13-rc2] pci: restore BAR values from pci_set_power_state for D3hot->D0
Message-ID: <20050727141202.GA22686@tuxdriver.com>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	"David S. Miller" <davem@davemloft.net>, rmk+lkml@arm.linux.org.uk,
	matthew@wil.cx, grundler@parisc-linux.org,
	linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.osdl.org,
	linux-kernel@vger.kernel.org, ambx1@neo.rr.com
References: <20050708095104.A612@den.park.msu.ru> <20050707.233530.85417983.davem@davemloft.net> <20050708110358.A8491@jurassic.park.msu.ru> <20050708.003333.28789082.davem@davemloft.net> <20050708122043.A8779@jurassic.park.msu.ru> <20050708183452.GB13445@tuxdriver.com> <20050726234934.GA6584@kroah.com> <20050727013601.GA13958@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050727013601.GA13958@tuxdriver.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2005 at 09:36:02PM -0400, John W. Linville wrote:
> On Tue, Jul 26, 2005 at 04:49:34PM -0700, Greg KH wrote:

> > This code doesn't even build, as need_restore isn't a global variable.
> 
> Hmmm...you must be missing this hunk from the patch posted on July 8?

> > Care to redo this patch (and merge it with your other one) and resend
> > it?
> 
> I'll be happy to do so, and include the other comment tweaks that
> Grant requested.  I should get to it tomorrow morning.

Looks like there was enough change between 8 July and now that patch
(the utility) got confused.  When I applied my 8 July patch against a
current tree, it put the last hunk in some totally different function.
This probably accounts for the compile failure you saw... :-)

New patch (w/ comment tweaks and symbol export) to follow...

John
-- 
John W. Linville
linville@tuxdriver.com

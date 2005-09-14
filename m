Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932749AbVINSWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932749AbVINSWv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 14:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932750AbVINSWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 14:22:51 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:10719 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S932749AbVINSWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 14:22:51 -0400
Date: Wed, 14 Sep 2005 22:22:24 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: "David S. Miller" <davem@davemloft.net>
Cc: jgarzik@pobox.com, linville@tuxdriver.com, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.osdl.org,
       torvalds@osdl.org, akpm@osdl.org, kaos@sgi.com, greg@kroah.com,
       rmk+lkml@arm.linux.org.uk, matthew@wil.cx, grundler@parisc-linux.org,
       ambx1@neo.rr.com
Subject: Re: [patch 2.6.14-rc1] pci: only call pci_restore_bars at boot
Message-ID: <20050914222224.A22319@jurassic.park.msu.ru>
References: <09142005095242.32027@bilbo.tuxdriver.com> <43283CDC.3070603@pobox.com> <20050914.092650.99910742.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050914.092650.99910742.davem@davemloft.net>; from davem@davemloft.net on Wed, Sep 14, 2005 at 09:26:50AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2005 at 09:26:50AM -0700, David S. Miller wrote:
> Why in the world can a PCI device not handle it's BARs being
> rewritten, especially if we're just rewriting the same exact
> values it had when we probed it beforehand?

Definitely. I wonder whether pci_resource_to_bus() works
correctly on this platform.

Ivan.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbWGGV3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbWGGV3R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 17:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbWGGV3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 17:29:17 -0400
Received: from cantor2.suse.de ([195.135.220.15]:13237 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932314AbWGGV3Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 17:29:16 -0400
From: Andi Kleen <ak@suse.de>
To: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: skge error; hangs w/ hardware memory hole
Date: Fri, 7 Jul 2006 23:28:51 +0200
User-Agent: KMail/1.9.3
Cc: Martin Michlmayr <tbm@cyrius.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, 341801@bugs.debian.org,
       asd@suespammers.org, kevin@sysexperts.com
References: <20060703205238.GA10851@deprecation.cyrius.com> <20060707141843.73fc6188@dxpl.pdx.osdl.net>
In-Reply-To: <20060707141843.73fc6188@dxpl.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607072328.51282.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 07 July 2006 23:18, Stephen Hemminger wrote:
> On Mon, 3 Jul 2006 22:52:38 +0200
> Martin Michlmayr <tbm@cyrius.com> wrote:
> 
> > We received the following bug report at http://bugs.debian.org/341801
> > 
> > | I have a Asus A8V with 4GB of RAM. When I turn on the hardware memory
> > | hole in the BIOS, the skge driver prints out this message:
> > |       skge hardware error detected (status 0xc00)
> > | and then does not work. Setting debug=16 doesn't really show anything.


Is that a board with VIA chipset?

VIA doesn't seem to support PCI accesses with addresses >4GB and they also
don't have a working GART IOMMU.

It will likely work with iommu=force

I've been pondering to force this, but was still waiting for more reports.

-Andi


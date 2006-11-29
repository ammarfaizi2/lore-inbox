Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757100AbWK2AD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757100AbWK2AD1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 19:03:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757138AbWK2AD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 19:03:26 -0500
Received: from gate.crashing.org ([63.228.1.57]:54684 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1757089AbWK2ADZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 19:03:25 -0500
Subject: Re: [PATCH 2.6.15.4 rel.2 1/1] libata: add hotswap to sata_svw
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Martin Devera <devik@cdi.cz>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
       lkosewsk@gmail.com.jgarzik
In-Reply-To: <1164756139.14595.37.camel@pmac.infradead.org>
References: <E1F9klH-0004Fg-00@devix>
	 <1164756139.14595.37.camel@pmac.infradead.org>
Content-Type: text/plain
Date: Wed, 29 Nov 2006 11:01:23 +1100
Message-Id: <1164758483.5350.113.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-28 at 23:22 +0000, David Woodhouse wrote:
> On Thu, 2006-02-16 at 16:09 +0100, Martin Devera wrote:
> > From: Martin Devera <devik@cdi.cz>
> > 
> > Add hotswap capability to Serverworks/BroadCom SATA controlers. The
> > controler has SIM register and it selects which bits in SATA_ERROR
> > register fires interrupt.
> > The solution hooks on COMWAKE (plug), PHYRDY change and 10B8B decode 
> > error (unplug) and calls into Lukasz's hotswap framework.
> > The code got one day testing on dual core Athlon64 H8SSL Supermicro 
> > MoBo with HT-1000 SATA, SMP kernel and two CaviarRE SATA HDDs in
> > hotswap bays.
> > 
> > Signed-off-by: Martin Devera <devik@cdi.cz>
> 
> What became of this?

I might be to blame for not testing it... The Xserve I had on my desk
was too noisy for most of my co-workers so I kept delaying and forgot
about it.... 

Also the Xserve I have only has one disk, which makes hotplug testing a
bit harder :-)

Ben.



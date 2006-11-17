Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162387AbWKQGRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162387AbWKQGRg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 01:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162388AbWKQGRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 01:17:36 -0500
Received: from gate.crashing.org ([63.228.1.57]:54461 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1162387AbWKQGRf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 01:17:35 -0500
Subject: Re: [Linux-fbdev-devel] Fwd: [Suspend-devel] resume not working on
	acer ferrari 4005 with radeonfb enabled
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stuffed Crust <pizza@shaftnet.org>
Cc: linux-fbdev-devel@lists.sourceforge.net,
       Christian Hoffmann <chrmhoffmann@gmail.com>,
       Andrew Morton <akpm@osdl.org>,
       Christian Hoffmann <Christian.Hoffmann@wallstreetsystems.com>,
       LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
In-Reply-To: <20061117052755.GA23831@shaftnet.org>
References: <D0233BCDB5857443B48E64A79E24B8CE6B544C@labex2.corp.trema.com>
	 <200611151109.06956.rjw@sisk.pl>
	 <200611162317.30880.chrmhoffmann@gmail.com>
	 <200611162344.41622.rjw@sisk.pl>  <20061117052755.GA23831@shaftnet.org>
Content-Type: text/plain
Date: Fri, 17 Nov 2006 17:17:00 +1100
Message-Id: <1163744220.5940.443.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-17 at 00:27 -0500, Stuffed Crust wrote:
> On Thu, Nov 16, 2006 at 11:44:40PM +0100, Rafael J. Wysocki wrote:
> > I think the call to radeon_restore_pci_cfg(rinfo) causes the problem to happen.
> 
> radeonfb is still using its own code for saving and restoring PCI 
> registers; I'm in the process of fixing it up to use proper PCI
> subsystem calls.  That will hopefully work better.   
> 
> It's possible there's a good reason (other than "nobody's ported it over 
> yet") that the radeonfb driver is doing it manually, but I don't know 
> why that would be the case.  

Well, radeonfb has code to bring back some cards from D2 or D3 cold (or
hard reset). It differenciates those states by checking if the config
space has been trashed. We should try to find out some better way.

Cheers,
Ben.



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965302AbWHWX1o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965302AbWHWX1o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 19:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965308AbWHWX1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 19:27:44 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:20956 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S965302AbWHWX1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 19:27:43 -0400
Subject: Re: [RFC/PATCH] Fixes for ULi5261 (tulip driver)
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: Valerie Henson <val_henson@linux.intel.com>
Cc: Pozsar Balazs <pozsy@uhulinux.hu>, Jeff Garzik <jgarzik@pobox.com>,
       Prakash Punnoor <prakash@punnoor.de>, Jiri Benc <jbenc@suse.cz>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060823165614.GF10658@goober>
References: <20060816191139.5d13fda8@griffin.suse.cz>
	 <20060816174329.GC17650@ojjektum.uhulinux.hu>
	 <200608162002.06793.prakash@punnoor.de>
	 <20060816195345.GA12868@ojjektum.uhulinux.hu>
	 <20060819001640.GE20111@goober>
	 <20060819061507.GB8571@ojjektum.uhulinux.hu> <44E721E1.2030203@pobox.com>
	 <20060821090351.GB19425@ojjektum.uhulinux.hu>
	 <20060823062821.GD10658@goober>
	 <20060823091919.GA5806@ojjektum.uhulinux.hu>
	 <20060823165614.GF10658@goober>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 09:27:17 +1000
Message-Id: <1156375637.4506.10.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2006-08-23 at 09:56 -0700, Valerie Henson wrote:
> On Wed, Aug 23, 2006 at 11:19:19AM +0200, Pozsar Balazs wrote:
> > 
> > The funny thing is that it seems the _first_ phy_read call always 
> > returns only when the 0x8000 bit is gone (I got this while loop from the 
> > xircom_tulip driver).
> 
> That's pretty much the answer I was suspecting.  Sounds like the read
> is doing some sort of flush.  Unfortunately I can't find any docs, so
> I'd rather keep things as close to the old code as possible to avoid
> breaking other cards.  Does something like this also work?
> 
> 	udelay(500); /* Paranoia - phy_read() may be sufficient */
> 	if (phy_read(db->ioaddr, db->phy_addr, 0, db->chip_id) & 0x8000)
> 		printk("some useful error message");
> 

I got docs from uli earlier in the year, I just never got around to
using them to the extent I intended, and then I switched to working
wirelessly most of the time. I didn't have to sign an NDA to get the
PDF, so it should be okay for me to distribute it, right? If that's the
case, then assuming LKML won't take a PDF, I'll reply again after giving
people time to tell me I'm wrong, removing LKML and giving everyone
directly emailed a copy (it's not huge).

Regards,

Nigel


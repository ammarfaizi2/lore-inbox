Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265865AbUFIT0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265865AbUFIT0X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 15:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265864AbUFIT0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 15:26:22 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:2944 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S265865AbUFITZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 15:25:03 -0400
Date: Wed, 9 Jun 2004 20:32:43 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200406091932.i59JWh0N000383@81-2-122-30.bradfords.org.uk>
To: Matt Mackall <mpm@selenic.com>,
       Christian Borntraeger <linux-kernel@borntraeger.net>
Cc: linux-kernel@vger.kernel.org, John Bradford <john@grabjohn.com>,
       Rik van Riel <riel@redhat.com>,
       Lasse K?rkk?inen / Tronic <tronic2@sci.fi>
In-Reply-To: <20040609181307.GE5414@waste.org>
References: <Pine.LNX.4.44.0406051935380.29273-100000@chimarrao.boston.redhat.com>
 <200406060708.i5678PW4000272@81-2-122-30.bradfords.org.uk>
 <200406061038.29470.linux-kernel@borntraeger.net>
 <20040609181307.GE5414@waste.org>
Subject: Re: Some thoughts about cache and swap
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Matt Mackall <mpm@selenic.com>:
> On Sun, Jun 06, 2004 at 10:38:25AM +0200, Christian Borntraeger wrote:
> > John Bradford wrote:
> > > Quote from Rik van Riel <riel@redhat.com>:
> > > > I wonder if we should just bite the bullet and implement
> > > > LIRS, ARC or CART for Linux.  These replacement algorithms
> > > > should pretty much detect by themselves which pages are
> > > > being used again (within a reasonable time) and which pages
> > > > aren't.
> > > Is there really much performance to be gained from tuning the 'limited'
> > > cache space, or will it just hurt as many or more systems than it helps?
> > 
> > Thats a very good question. 
> > Most of the time the current algorithm works quite well.
> > On the other hand, I definitely know what people mean when they complain 
> > about cachingand all this stuff. By just copying a big file that I dont use 
> > afterwards or watching an video I have 2 wonderful scenarios.
> 
> Perhaps people should read about the referenced algorithms. LRU
> (including the hybrid LRU that Linux uses) is vulnerable to
> "scanning" of the sort you're describing, while the above algorithms
> have varying degrees of scan-resistance. As lack of scan-resistance
> seems to be "the big problem" in the current VM, this looks like an
> interesting direction to go in.

Does "the big problem" really exist though?

Despite all of this discussion about swap and memory management, I _never_
reproduce any of the problems mentioned in normal use.  In my experience,
extreme VM problems almost always stem from mis-configured swap.

John.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265887AbUFISNq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265887AbUFISNq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 14:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265892AbUFISNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 14:13:46 -0400
Received: from waste.org ([209.173.204.2]:61078 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S265887AbUFISNn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 14:13:43 -0400
Date: Wed, 9 Jun 2004 13:13:07 -0500
From: Matt Mackall <mpm@selenic.com>
To: Christian Borntraeger <linux-kernel@borntraeger.net>
Cc: linux-kernel@vger.kernel.org, John Bradford <john@grabjohn.com>,
       Rik van Riel <riel@redhat.com>,
       Lasse K?rkk?inen / Tronic <tronic2@sci.fi>
Subject: Re: Some thoughts about cache and swap
Message-ID: <20040609181307.GE5414@waste.org>
References: <Pine.LNX.4.44.0406051935380.29273-100000@chimarrao.boston.redhat.com> <200406060708.i5678PW4000272@81-2-122-30.bradfords.org.uk> <200406061038.29470.linux-kernel@borntraeger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406061038.29470.linux-kernel@borntraeger.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 06, 2004 at 10:38:25AM +0200, Christian Borntraeger wrote:
> John Bradford wrote:
> > Quote from Rik van Riel <riel@redhat.com>:
> > > I wonder if we should just bite the bullet and implement
> > > LIRS, ARC or CART for Linux.  These replacement algorithms
> > > should pretty much detect by themselves which pages are
> > > being used again (within a reasonable time) and which pages
> > > aren't.
> > Is there really much performance to be gained from tuning the 'limited'
> > cache space, or will it just hurt as many or more systems than it helps?
> 
> Thats a very good question. 
> Most of the time the current algorithm works quite well.
> On the other hand, I definitely know what people mean when they complain 
> about cachingand all this stuff. By just copying a big file that I dont use 
> afterwards or watching an video I have 2 wonderful scenarios.

Perhaps people should read about the referenced algorithms. LRU
(including the hybrid LRU that Linux uses) is vulnerable to
"scanning" of the sort you're describing, while the above algorithms
have varying degrees of scan-resistance. As lack of scan-resistance
seems to be "the big problem" in the current VM, this looks like an
interesting direction to go in.

-- 
Mathematics is the supreme nostalgia of our time.

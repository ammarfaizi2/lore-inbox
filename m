Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbWGAK0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbWGAK0m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 06:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbWGAK0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 06:26:42 -0400
Received: from verein.lst.de ([213.95.11.210]:48618 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1750795AbWGAK0m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 06:26:42 -0400
Date: Sat, 1 Jul 2006 12:25:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux powerpc <linuxppcleo@gmail.com>, linuxppc-dev@ozlabs.org,
       Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc:Fix rheap alignment problem
Message-ID: <20060701102557.GA14013@lst.de>
References: <9FCDBA58F226D911B202000BDBAD467306E04FF6@zch01exm40.ap.freescale.net> <1151709194.27137.2.camel@localhost.localdomain> <DCEAAC0833DD314AB0B58112AD99B93B07B36E@ismail.innsys.innovsys.com> <a0bc9bf80606302335p7ba227afwf69dc42e2eada64b@mail.gmail.com> <1151738466.27137.24.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151738466.27137.24.camel@localhost.localdomain>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 01, 2006 at 05:21:06PM +1000, Benjamin Herrenschmidt wrote:
> On Sat, 2006-07-01 at 14:35 +0800, Linux powerpc wrote:
> > Yes, it was used for allocating dual port RAM for CPM.  And now we are
> > adding QE support to powerpc arch which need to use rheap(QE is next
> > generation for CPM).  Please see the patches I <leoli@freescale.com>
> > just posted for 8360epb support.  Moreover, previous CPM support is
> > adding to powerpc arch too. 
> 
> Ok, well, I don't have anything specifically against that code, I was
> just wondering if it may not duplicate something we already have (yet
> another space allocator basically)... 

Yepp.  Without looking at the rheap allocator in deatail, any reason
it can't use lib/genalloc.c?


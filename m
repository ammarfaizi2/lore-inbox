Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264346AbUIIN4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264346AbUIIN4F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 09:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264299AbUIIN4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 09:56:04 -0400
Received: from the-village.bc.nu ([81.2.110.252]:24746 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S264246AbUIINyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 09:54:46 -0400
Subject: Re: bug in md write barrier support?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Arjan van de Ven <arjanv@redhat.com>, Neil Brown <neilb@cse.unsw.edu.au>,
       Christoph Hellwig <hch@lst.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040909082922.GN1737@suse.de>
References: <20040903172414.GA6771@lst.de>
	 <16697.4817.621088.474648@cse.unsw.edu.au> <20040904082121.GB2343@suse.de>
	 <16699.48946.29579.495180@cse.unsw.edu.au> <20040908092309.GD2258@suse.de>
	 <1094650500.11723.32.camel@localhost.localdomain>
	 <20040908154608.GN2258@suse.de>
	 <1094682098.12280.19.camel@localhost.localdomain>
	 <20040909080612.GJ1737@suse.de> <1094718179.2801.3.camel@laptop.fenrus.com>
	 <20040909082922.GN1737@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094734272.14623.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 09 Sep 2004 13:51:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-09-09 at 09:29, Jens Axboe wrote:
> > why does this seem broken? semantics of "cache flush guarantees that all
> > io submitted prior to it hits the spindle" are quite sane imo; no
> > guarantee of later submitted IO.. compare the unix "sync" command; same
> > level of semantics.
> 
> Depends on your angle, I think it breaks the principle of least
> surprise.

As far as I can ascertain raid controllers in general follow this set of
semantics. Its less of an issue for many of them with battery backup
obviously.

It also makes a lot of sense at the hardware level for performance
especially when dealing with raid.

Alan


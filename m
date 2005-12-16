Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932349AbVLPQcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbVLPQcX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 11:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbVLPQcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 11:32:23 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:8874 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S932349AbVLPQcX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 11:32:23 -0500
Subject: Re: [PATCH 2/2] dasd: remove dynamic ioctl registration
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, arnd@arndb.de, linux-kernel@vger.kernel.org
In-Reply-To: <20051216150058.GA20144@lst.de>
References: <20051216143348.GB19541@lst.de>
	 <1134745099.5495.31.camel@localhost.localdomain>
	 <20051216150058.GA20144@lst.de>
Content-Type: text/plain
Date: Fri, 16 Dec 2005 17:32:21 +0100
Message-Id: <1134750741.5495.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-16 at 16:00 +0100, Christoph Hellwig wrote:
> On Fri, Dec 16, 2005 at 03:58:19PM +0100, Martin Schwidefsky wrote:
> > On Fri, 2005-12-16 at 15:33 +0100, Christoph Hellwig wrote:
> > > dasd has some really messy code to allow submodule to register ioctl.
> > > Right now there are two cases:  cmd and eckd.
> > 
> > Wrong, at least four: cmf, eckd, err, and a binary only module from EMC.
> > Now don't hit me for that binary module. But it has been there for 2.4
> > and we even reserved some ioctl numbers for them (240-255).
> 
> NACK, binary modules are not a reason to keep broken things, rather one
> to fix it better sooner than later.

I see your point. We shouldn't have introduced that interface in the
first place but we really wanted to be able to run on EMC with decent
speed.

> > I would be cautious about ripping out the dynamic ioctls interface
> > though. I have no idea if there still is an EMC module for 2.6 or other
> > exploiters. It is an exported interface after all. It is not necessary
> > to break these exploiters intentionally.
> 
> Yes, it is.  Unrelated modules adding ioctls is a big no-way.  Even more
> for binary modules.  The EMC code deserves to be broken.

Ok understood, but at least I have warn the EMC people about that change
so that they can send a patch for the dasd driver ..

-- 
blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH



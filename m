Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283393AbRK2V0y>; Thu, 29 Nov 2001 16:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283406AbRK2V0p>; Thu, 29 Nov 2001 16:26:45 -0500
Received: from zeus.kernel.org ([204.152.189.113]:60823 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S283393AbRK2V0f>;
	Thu, 29 Nov 2001 16:26:35 -0500
Date: Thu, 29 Nov 2001 13:10:46 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Jens Axboe <axboe@suse.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>, rwhron@earthlink.net
Subject: Re: 2.5.1-pre3 FIXED (was Re: 2.5.1-pre3 DON'T USE)
In-Reply-To: <20011129121431.D10601@suse.de>
Message-ID: <Pine.LNX.4.10.10111291308260.20821-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2001, Jens Axboe wrote:

> On Thu, Nov 29 2001, Jens Axboe wrote:
> > Hi,
> > 
> > Please don't use this kernel unless you can afford to loose your data.
> > I'm looking at the problem right now.
> 
> Ok the problem was only on highmem machines, the copying of data was
> just wrong. The attached patch fixes that and a few other buglets, such
> as:
> 
> - BIO_HASH remnant in LVM
> - bouncing should take multi-page bio's into account
> - bouncing should bounce pages _above_ the bounce_pfn :-)
> - remove bio_size() macro, it's just silly
> - multi-page bio fixes (BIO_CONTIG etc)
> 
> Linus, please apply.
> 
> I'm going to make a TODO list for the new block stuff, so potential
> block janitors can get cracking on updating all those broken drivers
> etc. If someone would be willing to coordinate this effort, let me know.

When you think it is stable again I will supply you all an integration
patch of my stuff and it will allow you to trace the data down the path
ways to find any periodic or random acts of disk abuse.

Regards,

Andre Hedrick
CEO/President, LAD Storage Consulting Group
Linux ATA Development
Linux Disk Certification Project



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262424AbSKCUzP>; Sun, 3 Nov 2002 15:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262448AbSKCUzP>; Sun, 3 Nov 2002 15:55:15 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:13835
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S262424AbSKCUzN>; Sun, 3 Nov 2002 15:55:13 -0500
Date: Sun, 3 Nov 2002 13:00:15 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Erik Andersen <andersen@codepoet.org>
cc: bert hubert <ahu@ds9a.nl>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] de-cryptify ide-disk host protected area output
In-Reply-To: <20021026132419.GA11930@codepoet.org>
Message-ID: <Pine.LNX.4.10.10211031300060.27918-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Agreed w/ Erik.

On Sat, 26 Oct 2002, Erik Andersen wrote:

> On Sat Oct 26, 2002 at 03:07:01PM +0200, bert hubert wrote:
> > Useless number '1' being printed leading to operator confusion.
> > 
> > --- linux-2.5.44/drivers/ide/ide-disk.c~orig	Sat Oct 26 14:59:35 2002
> > +++ linux-2.5.44/drivers/ide/ide-disk.c	Sat Oct 26 15:00:40 2002
> > @@ -1128,7 +1128,7 @@
> >  {
> >  	int flag = (drive->id->cfs_enable_1 & 0x0400) ? 1 : 0;
> >  	if (flag)
> > -		printk("%s: host protected area => %d\n", drive->name, flag);
> > +		printk("%s: supports host protected area", drive->name);
> >  	return flag;
> >  }
> 
> Even better -- kill the prink entirely.  If anyone really
> cares, they can run 'hdparm -I <drivename>' and get the
> exhaustive list of everything the drive supports....
> 
>  -Erik
> 
> --
> Erik B. Andersen             http://codepoet-consulting.com/
> --This message was written using 73% post-consumer electrons--
> 

Andre Hedrick
LAD Storage Consulting Group


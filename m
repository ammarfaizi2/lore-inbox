Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261398AbUL2T26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbUL2T26 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 14:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbUL2T26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 14:28:58 -0500
Received: from pastinakel.tue.nl ([131.155.2.7]:31755 "EHLO pastinakel.tue.nl")
	by vger.kernel.org with ESMTP id S261398AbUL2T24 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 14:28:56 -0500
Date: Wed, 29 Dec 2004 20:28:52 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andries Brouwer <aebr@win.tue.nl>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: 2.6.10 - Still mishandles volumes without geometry data
Message-ID: <20041229192852.GC2818@pclin040.win.tue.nl>
References: <1104155840.20898.3.camel@localhost.localdomain> <58cb370e041228124878cb6e2a@mail.gmail.com> <1104271702.26131.11.camel@localhost.localdomain> <20041229025212.GA2818@pclin040.win.tue.nl> <1104330967.30080.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1104330967.30080.12.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: SINECTIS: pastinakel.tue.nl 1114; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2004 at 02:36:11PM +0000, Alan Cox wrote:

> > > -	printk(", CHS=%d/%d/%d", 
> > > -	       drive->bios_cyl, drive->bios_head, drive->bios_sect);
> > > +	if(drive->bios_cyl)
> > > +		printk(", CHS=%d/%d/%d", 
> > > +			drive->bios_cyl, drive->bios_head, drive->bios_sect);
> > 
> > Reasonable. (But s/if(/if (/ .)
> > On the other hand, I like the "CHS=0/0/0" - it makes very clear what is wrong
> > in case lilo or so has geometry problems.
> 
> 0/0/0 is valid in these cases - would it be better if it printed
> something else instead for that situation ("No physical geometry, ")
> perhaps ?

But it is not the "physical geometry" (whatever that may be) that is printed.
Not drive->head but drive->bios_head. It is easiest just to leave it.

Andries

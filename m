Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319723AbSIMRgT>; Fri, 13 Sep 2002 13:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319724AbSIMRgT>; Fri, 13 Sep 2002 13:36:19 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:6928 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S319723AbSIMRgS>; Fri, 13 Sep 2002 13:36:18 -0400
Date: Fri, 13 Sep 2002 10:39:00 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Alex Davis <alex14641@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Possible bug and question about ide_notify_reboot in drivers/ide/ide.c
 (2.4.19)
In-Reply-To: <1031933717.9991.4.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.10.10209131035230.29877-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


So Alex,

What did you do prior to flush cache being added or did you care?
If you are talking about suspend, apm, acpi issues -- I am not interested
at the moment.  It was not important to the folks at the top when I tried
to address the issue, and now I have my hands full with other things.

Sorry, but it will have to wait unless Marcelo wants it fixed and doing
half way solutions does not cut it.  If it is wrong in -ac that is where
it shall be fixed first.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On 13 Sep 2002, Alan Cox wrote:

> On Fri, 2002-09-13 at 16:19, Alex Davis wrote:
> > 
> > --- Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > > To make sure they have written back their caches...
> > 
> > This is redundant, since cleanup() flushes the write cache. Also, I spoke to a 
> > Maxtor tech support person and he said that putting the drives in standby mode
> > does NOT flush the write cache. 
> 
> Whether we should be putting drives in Standby is an Andre question I
> think. One dodgy bios isnt a good reason to change it
> 
> 
> >  Yet another thing: you are flushing the cache,
> > by calling cleanup(), AFTER you put the disks to sleep. I think that's backward.
> 
> That would be a bug, but the 2.4.19 IDE code isnt my problem
> 
> Alan
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


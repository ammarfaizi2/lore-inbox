Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266235AbUA3HZg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 02:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266316AbUA3HZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 02:25:34 -0500
Received: from webhosting.rdsbv.ro ([213.157.185.164]:48871 "EHLO
	hosting.rdsbv.ro") by vger.kernel.org with ESMTP id S266235AbUA3HZ3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 02:25:29 -0500
Date: Fri, 30 Jan 2004 09:25:10 +0200 (EET)
From: Catalin BOIE <util@deuroconsult.ro>
X-X-Sender: util@hosting.rdsbv.ro
To: "Robert M. Hyatt" <hyatt@cis.uab.edu>
cc: Nick Piggin <piggin@cyberone.com.au>, linux-kernel@vger.kernel.org,
       linux-smp@vger.kernel.org
Subject: Re: 2.6.2-rc2 Interactivity problems with SMP + HT
In-Reply-To: <Pine.LNX.4.44.0401290901510.21120-100000@crafty.cis.uab.edu>
Message-ID: <Pine.LNX.4.58.0401300919520.8217@hosting.rdsbv.ro>
References: <Pine.LNX.4.44.0401290901510.21120-100000@crafty.cis.uab.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jan 2004, Robert M. Hyatt wrote:

>
>
> It might be some IDE disk I/O that results from flushing buffers or
> whatever.  I don't see this on my SCSI boxes, but I have seen an IDE
> box get sluggish at times due to I/O.

It is possible.
vmstat shows a lot of writes when this happen.
Seems that even reads hangs.
I remember tat I was in pine and I tried to save a small file (under 1k)
and it took 5-7 seconds to do it.

>
> On Thu, 29 Jan 2004, Nick Piggin
> wrote:
>
> >
> >
> > Catalin BOIE wrote:
> >
> > >Hello!
> > >
> > >First, thank you very much for the effort you put for Linux!
> > >
> > >I have a Intel motherboard with SATA (2 Maxtor disks).
> > >CPUs: 2 x 2.4GHz PIV HT = 4 processors (2 virtual)
> > >1 GB RAM.
> > >
> > >Load: postgresql and apache. Very low load (3-4 clients).
> > >
> > >RAID: Yes, soft RAID1 between the 2 disks.
> > >
> > >I have times when the console freeze for 3-4 seconds!
> > >2.6.0-test11 had the same problem (maybe longer times).
> > >2.6.1-rc2 worked good in this respect but crashed after 2 days. :(
> > >2.6.2-rc2 is back with the delay.
> > >
> > >Do you know why this can happen?
> > >
> > >
> >
> > There haven't been many scheduler changes there recently so
> > maybe its something else.
> >
> > But you could try the latest -mm kernels. They have some
> > Hyperthreading work in them (you need to enable CONFIG_SCHED_SMT).
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-smp" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
>
> --
> Robert M. Hyatt, Ph.D.          Computer and Information Sciences
> hyatt@uab.edu                   University of Alabama at Birmingham
> (205) 934-2213                  136A Campbell Hall
> (205) 934-5473 FAX              Birmingham, AL 35294-1170
>

---
Catalin(ux) BOIE
catab@deuroconsult.ro

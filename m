Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261660AbVEOPaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbVEOPaU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 11:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbVEOPaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 11:30:19 -0400
Received: from atlmail.prod.rxgsys.com ([69.61.70.25]:32704 "EHLO
	bastet.signetmail.com") by vger.kernel.org with ESMTP
	id S261660AbVEOPaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 11:30:09 -0400
Date: Sun, 15 May 2005 11:29:56 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Disk write cache (Was: Hyper-Threading Vulnerability)
Message-ID: <20050515152956.GA25143@havoc.gtf.org>
References: <1115963481.1723.3.camel@alderaan.trey.hu> <20050515145241.GA5627@irc.pl> <Pine.LNX.4.58.0505151657230.19181@artax.karlin.mff.cuni.cz> <200505151121.36243.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505151121.36243.gene.heskett@verizon.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 15, 2005 at 11:21:36AM -0400, Gene Heskett wrote:
> On Sunday 15 May 2005 11:00, Mikulas Patocka wrote:
> >On Sun, 15 May 2005, Tomasz Torcz wrote:
> >> On Sun, May 15, 2005 at 04:12:07PM +0200, Andi Kleen wrote:
> >> > > > > However they've patched the FreeBSD kernel to
> >> > > > > "workaround?" it:
> >> > > > > ftp://ftp.freebsd.org/pub/FreeBSD/CERT/patches/SA-05:09/ht
> >> > > > >t5.patch
> >> > > >
> >> > > > That's a similar stupid idea as they did with the disk write
> >> > > > cache (lowering the MTBFs of their disks by considerable
> >> > > > factors, which is much worse than the power off data loss
> >> > > > problem) Let's not go down this path please.
> >> > >
> >> > > What wrong did they do with disk write cache?
> >> >
> >> > They turned it off by default, which according to disk vendors
> >> > lowers the MTBF of your disk to a fraction of the original
> >> > value.
> >> >
> >> > I bet the total amount of valuable data lost for FreeBSD users
> >> > because of broken disks is much much bigger than what they
> >> > gained from not losing in the rather hard to hit power off
> >> > cases.
> >>
> >>  Aren't I/O barriers a way to safely use write cache?
> >
> >FreeBSD used these barriers (FLUSH CACHE command) long time ago.
> >
> >There are rumors that some disks ignore FLUSH CACHE command just to
> > get higher benchmarks in Windows. But I haven't heart of any proof.
> > Does anybody know, what companies fake this command?
> >
> >From a story I read elsewhere just a few days ago, this problem is 
> virtually universal even in the umpty-bucks 15,000 rpm scsi server 
> drives.  It appears that this is just another way to crank up the 
> numbers and make each drive seem faster than its competition.
> 
> My gut feeling is that if this gets enough ink to get under the drive 
> makers skins, we will see the issuance of a utility from the makers 
> that will re-program the drives therefore enabling the proper 
> handling of the FLUSH CACHE command.  This would be an excellent 
> chance IMO, to make a bit of noise if the utility comes out, but only 
> runs on windows.  In that event, we hold their feet to the fire (the 
> prefereable method), or a wrapper is written that allows it to run on 
> any os with a bash-like shell manager.


There is a large amount of yammering and speculation in this thread.

Most disks do seem to obey SYNC CACHE / FLUSH CACHE.

	Jeff




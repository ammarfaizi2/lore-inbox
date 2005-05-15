Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261604AbVEOOM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbVEOOM1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 10:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbVEOOM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 10:12:26 -0400
Received: from colin.muc.de ([193.149.48.1]:21776 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S261604AbVEOOMK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 10:12:10 -0400
Date: 15 May 2005 16:12:07 +0200
Date: Sun, 15 May 2005 16:12:07 +0200
From: Andi Kleen <ak@muc.de>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Hyper-Threading Vulnerability
Message-ID: <20050515141207.GB94354@muc.de>
References: <1115963481.1723.3.camel@alderaan.trey.hu> <m164xnatpt.fsf@muc.de> <20050513211609.75216bf8.diegocg@gmail.com> <20050515095446.GE68736@muc.de> <Pine.LNX.4.58.0505151550160.8633@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505151550160.8633@artax.karlin.mff.cuni.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 15, 2005 at 03:51:05PM +0200, Mikulas Patocka wrote:
> 
> 
> On Sun, 15 May 2005, Andi Kleen wrote:
> 
> > On Fri, May 13, 2005 at 09:16:09PM +0200, Diego Calleja wrote:
> > > El Fri, 13 May 2005 20:03:58 +0200,
> > > Andi Kleen <ak@muc.de> escribi?:
> > >
> > >
> > > > This is not a kernel problem, but a user space problem. The fix
> > > > is to change the user space crypto code to need the same number of cache line
> > > > accesses on all keys.
> > >
> > >
> > > However they've patched the FreeBSD kernel to "workaround?" it:
> > > ftp://ftp.freebsd.org/pub/FreeBSD/CERT/patches/SA-05:09/htt5.patch
> >
> > That's a similar stupid idea as they did with the disk write
> > cache (lowering the MTBFs of their disks by considerable factors,
> > which is much worse than the power off data loss problem)
> > Let's not go down this path please.
> 
> What wrong did they do with disk write cache?

They turned it off by default, which according to disk vendors
lowers the MTBF of your disk to a fraction of the original value.

I bet the total amount of valuable data lost for FreeBSD users because
of broken disks is much much bigger than what they gained from not losing
in the rather hard to hit power off cases.

-Andi

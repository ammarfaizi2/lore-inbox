Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269755AbUJAKuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269755AbUJAKuZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 06:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269754AbUJAKuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 06:50:25 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:41672 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S269755AbUJAKuV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 06:50:21 -0400
Date: Fri, 1 Oct 2004 12:47:23 +0200
From: Jens Axboe <axboe@suse.de>
To: Borislav Petkov <petkov@uni-muenster.de>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>,
       Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fw: Re: 2.6.9-rc2-mm4
Message-ID: <20041001104723.GH3008@suse.de>
References: <20040929214637.44e5882f.akpm@osdl.org> <200410011154.32670.petkov@uni-muenster.de> <20041001095432.GF3008@suse.de> <200410011234.12462.petkov@uni-muenster.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410011234.12462.petkov@uni-muenster.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01 2004, Borislav Petkov wrote:
> > > > I don't see any changes that could impact this from 2.6.7 to 2.6.8. We
> > > > tightened the dma alignment (from 4 to 32 bytes), but should not cause
> > > > problems going in that direction. Unless the other path is buggy, of
> > > > course.
> > > >
> > > > Does dma make a difference? Please try 2.6.9-rc3 as well.
> > >
> > > Sorry guys,
> > >
> > > still a no go. Tested today 2.6.8.1 and 2.6.9-rc3 both with DMA
> > > on/off. same lost interrupt message. How about a hardware problem?
> > > Maybe the cd-drive is showing some hidden "features" under certain
> > > conditions, although it is highly unlikely since 2.6.7 runs fine.
> > > strange...
> >
> > I can't say, probably you need to look outside of ide changes to locate
> > the problem. Have you tried disabling acpi on your box?
>
> I'm not sure whether adding the boot option acpi=off is enough to
> disable ACPI in 2.6, but if this is the case 2.6.9-rc3 is still a no
> go with acpi disabled. How about APIC? 

maybe it would be more useful if you tried the -bk snapshots in between
2.6.7 and 2.6.8 to locate where the problem started. try the 2.6.8-rc
first, then try the snapshots in between when you find where the problem
was introduced.

-- 
Jens Axboe


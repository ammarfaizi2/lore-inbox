Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265078AbTLCQ0n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 11:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265080AbTLCQ0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 11:26:43 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:33254 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265078AbTLCQ0l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 11:26:41 -0500
Date: Wed, 3 Dec 2003 17:26:33 +0100
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David =?iso-8859-1?Q?Mart=EDnez?= Moreno <ender@debian.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       clubinfo.servers@adi.uam.es, Ingo Molnar <mingo@elte.hu>,
       Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: Errors and later panics in 2.6.0-test11.
Message-ID: <20031203162633.GB27964@suse.de>
References: <200312031417.18462.ender@debian.org> <Pine.LNX.4.58.0312030757120.5258@home.osdl.org> <20031203162045.GA27964@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031203162045.GA27964@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 03 2003, Jens Axboe wrote:
> On Wed, Dec 03 2003, Linus Torvalds wrote:
> > 
> > 
> > On Wed, 3 Dec 2003, David [iso-8859-15] Martínez Moreno wrote:
> > >
> > > 	Hello again. I'm testing 2.6.0-test11 in one of my servers. In about a day or
> > > so under a web/FTP server load, the kernel starts to spit messages:
> > >
> > > Dec  2 22:07:25 ulises kernel: Bad page state at prep_new_page
> > > [ ... ]
> > >
> > > 	This machine is Pentium IV with 512 MB of RAM, IDE & SATA disks, RAID 0 over the
> > > 2 SATA disks, vanilla 2.6.0-test11, Debian testing, apache2 and proftpd.
> > 
> > Interesting. Another RAID 0 problem report..
> 
> Hmm did _all_ reports include raid-0, or just "some" raid? I'm looking
> at the bio_pair stuff which raid-0 is the only user of, something looks
> fishy there.

Looks like some raid-5 and others were involved in other reports, so
that's probably not it.

The bio_pair stuff has a few flaws, but nothing that could bad things to
happen.

-- 
Jens Axboe


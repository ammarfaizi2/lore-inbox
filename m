Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261473AbVCFVuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbVCFVuS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 16:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261471AbVCFVuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 16:50:05 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:14818 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261371AbVCFVtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 16:49:49 -0500
From: Darren Williams <dsw@gelato.unsw.edu.au>
To: Christoph Lameter <clameter@sgi.com>
Date: Mon, 7 Mar 2005 08:49:02 +1100
Cc: Darren Williams <dsw@gelato.unsw.edu.au>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Page fault scalability patch V18: Overview
Message-ID: <20050306214902.GC19053@cse.unsw.EDU.AU>
Mail-Followup-To: Christoph Lameter <clameter@sgi.com>,
	Darren Williams <dsw@gelato.unsw.edu.au>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
References: <Pine.LNX.4.58.0503011947001.25441@schroedinger.engr.sgi.com> <20050304021847.GF28102@cse.unsw.EDU.AU> <20050304024704.GG28102@cse.unsw.EDU.AU> <Pine.LNX.4.58.0503040814220.17378@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503040814220.17378@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph

On Fri, 04 Mar 2005, Christoph Lameter wrote:

> Make sure that scrubd_stop on startup is set to 2 and no zero in
> mm/scrubd.c. The current patch on oss.sgi.com may have that set to zero.
> 
unsigned int sysctl_scrub_stop = 2;     /* Mininum order of page to zero */

This is the assignment when page zero fails.

Darren

> On Fri, 4 Mar 2005, Darren Williams wrote:
> 
> > Hi Darren
> >
> > On Fri, 04 Mar 2005, Darren Williams wrote:
> >
> > > Hi Christoph
> > >
> > > On Tue, 01 Mar 2005, Christoph Lameter wrote:
> > >
> > > > Is there any chance that this patchset could go into mm now? This has been
> > > > discussed since last August....
> > > >
> > > > Changelog:
> > > >
> > > > V17->V18 Rediff against 2.6.11-rc5-bk4
> > >
> > > Just applied this patch against 2.6.11, however with the patch applied
> > > and all the aditional config options not set, the kernel hangs at
> > > Freeing unused kernel memory: 240kB freed
> > > FYI:
> > >
> > > boot    atomic   prezero
> > > OK        on      on
> > > fail      off     on
> > > fail      off     off
> > > OK        on      off
> >
> > A bit extra info on the system:
> > HP rx8620 Itanium(R) 2 16way
> >
> > >
> > > > V16->V17 Do not increment page_count in do_wp_page. Performance data
> > > > 	posted.
> > > > V15->V16 of this patch: Redesign to allow full backback
> > > > 	for architectures that do not supporting atomic operations.
> > > >
> > > > An introduction to what this patch does and a patch archive can be found on
> > > > http://oss.sgi.com/projects/page_fault_performance. The archive also has the
> > > > result of various performance tests (LMBench, Microbenchmark and
> > > > kernel compiles).
> > > >
> > > > The basic approach in this patchset is the same as used in SGI's 2.4.X
> > > > based kernels which have been in production use in ProPack 3 for a long time.
> > > >
> > > > The patchset is composed of 4 patches (and was tested against 2.6.11-rc5-bk4):
> > > >
> > > [SNIP]
> > >
> > > > -
> > > > To unsubscribe from this list: send the line "unsubscribe linux-ia64" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > --------------------------------------------------
> > > Darren Williams <dsw AT gelato.unsw.edu.au>
> > > Gelato@UNSW <www.gelato.unsw.edu.au>
> > > --------------------------------------------------
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> > --------------------------------------------------
> > Darren Williams <dsw AT gelato.unsw.edu.au>
> > Gelato@UNSW <www.gelato.unsw.edu.au>
> > --------------------------------------------------
> >
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ia64" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--------------------------------------------------
Darren Williams <dsw AT gelato.unsw.edu.au>
Gelato@UNSW <www.gelato.unsw.edu.au>
--------------------------------------------------

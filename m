Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932474AbWBGXgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474AbWBGXgp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 18:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbWBGXgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 18:36:44 -0500
Received: from mx1.suse.de ([195.135.220.2]:52104 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932476AbWBGXgn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 18:36:43 -0500
From: Andi Kleen <ak@suse.de>
To: "Ray Bryant" <raybry@mpdtxmail.amd.com>
Subject: Re: [discuss] mmap, mbind and write to mmap'ed memory crashes 2.6.16-rc1[2] on 2 node X86_64
Date: Wed, 8 Feb 2006 00:36:30 +0100
User-Agent: KMail/1.8.2
Cc: "Christoph Lameter" <clameter@engr.sgi.com>,
       "Bharata B Rao" <bharata@in.ibm.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
References: <20060205163618.GB21972@in.ibm.com> <Pine.LNX.4.62.0602070848450.24487@schroedinger.engr.sgi.com> <200602071727.18359.raybry@mpdtxmail.amd.com>
In-Reply-To: <200602071727.18359.raybry@mpdtxmail.amd.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602080036.31059.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 February 2006 00:27, Ray Bryant wrote:
> On Tuesday 07 February 2006 10:49, Christoph Lameter wrote:
> > On Tue, 7 Feb 2006, Bharata B Rao wrote:
> > > I can still crash my x86_64 box with Christoph's program.
> >
> > So it looks like the problem is arch specific. Test program runs fine on
> > ia64.
> >
> > > page = 0xffffffffffffffd8
> > > &page->lru = 0000000000000000
> >
> > Yup lru field overwritten as I thought.
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> For what it is worth:
> 
> Christoph's test program runs fine on my 32 GB, 4 socket, 8 core Opteron 64 

Opteron 64? A new exciting upcomming product? @)

> box with 2.6.16-rc1.

Yes it also works on my test box and also some other simple tests with MPOL_BIND. 
But we had similar reports on two different systems, so there's very likely a problem.
Just need to reproduce it somehow. 

-Andi

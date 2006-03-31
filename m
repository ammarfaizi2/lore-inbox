Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbWCaNda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbWCaNda (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 08:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbWCaNda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 08:33:30 -0500
Received: from ns2.suse.de ([195.135.220.15]:18572 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932135AbWCaNd3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 08:33:29 -0500
To: cmm@us.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, Takashi Sato <sho@tnes.nec.co.jp>,
       Laurent Vivier <Laurent.Vivier@bull.net>, linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH 0/2]Extend ext3 filesystem limit from 8TB to 16TB
References: <20060325223358sho@rifu.tnes.nec.co.jp>
	<1143485147.3970.23.camel@dyn9047017067.beaverton.ibm.com>
	<20060327131049.2c6a5413.akpm@osdl.org>
	<20060327225847.GC3756@localhost.localdomain>
	<1143530126.11560.6.camel@openx2.frec.bull.fr>
	<1143568905.3935.13.camel@dyn9047017067.beaverton.ibm.com>
	<1143623605.5046.11.camel@openx2.frec.bull.fr>
	<1143682730.4045.145.camel@dyn9047017067.beaverton.ibm.com>
	<20060330174008.GW5030@schatzie.adilger.int>
	<1143746202.3896.32.camel@dyn9047017067.beaverton.ibm.com>
From: Andi Kleen <ak@suse.de>
Date: 31 Mar 2006 15:33:24 +0200
In-Reply-To: <1143746202.3896.32.camel@dyn9047017067.beaverton.ibm.com>
Message-ID: <p73r74i91sr.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mingming Cao <cmm@us.ibm.com> writes:

> On Thu, 2006-03-30 at 10:40 -0700, Andreas Dilger wrote:
> > On Mar 29, 2006  17:38 -0800, Mingming Cao wrote:
> > > Have verified these two patches on a 64 bit machine with 10TB ext3
> > > filesystem, fsx runs fine for a few hours. Also testes on 32 bit machine
> > > with <8TB ext3.
> > 
> > Have you done tests _near_ 8TB with a 32-bit machine, even without these
> > patches?
> No I haven't. The >8TB right now is attached to a 64 bit machine, but we
> should able to move it to a 32 bit machine.

If you use XFS or JFS as backing fs you can use a holey loop device
to simulate it.  When I tried this last time JFS worked better for me.
XFS doesn't seem to like that many extents as will be created by 
mkfs.ext2.

-Andi

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266222AbUALP5I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 10:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266215AbUALP5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 10:57:07 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44467 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266222AbUALP4V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 10:56:21 -0500
Subject: Re: smp dead lock of io_request_lock/queue_lock patch
From: Doug Ledford <dledford@redhat.com>
To: Jens Axboe <axboe@suse.de>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       Martin Peschke3 <MPESCHKE@de.ibm.com>,
       Arjan Van de Ven <arjanv@redhat.com>, Peter Yao <peter@exavio.com.cn>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-scsi mailing list <linux-scsi@vger.kernel.org>
In-Reply-To: <20040112154345.GE1255@suse.de>
References: <OF2581AA2D.BFD408D2-ONC1256E19.004BE052-C1256E19.004E1561@de.ibm.com>
	 <20040112141330.GH24638@suse.de>
	 <1073920110.3114.268.camel@compaq.xsintricity.com>
	 <1073921054.2186.16.camel@mulgrave>  <20040112154345.GE1255@suse.de>
Content-Type: text/plain
Message-Id: <1073922773.3114.275.camel@compaq.xsintricity.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Mon, 12 Jan 2004 10:52:53 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-01-12 at 10:43, Jens Axboe wrote:
> On Mon, Jan 12 2004, James Bottomley wrote:
> > On Mon, 2004-01-12 at 10:08, Doug Ledford wrote:
> > > >From my standpoint, we are going to be maintaining our 2.4 kernel RPMs
> > > for a long time, so my preference is to have it in mainline.  On top of
> > > the performance stuff I have also been building some actual bug fix
> > > patches.  They depend on the behavior of the patched kernels, and in
> > > some cases would be difficult to put on top of a non-iorl patched scsi
> > > stack.  In any case, my current plans include putting my 2.4 scsi stack
> > > stuff up for perusal on linux-scsi.bkbits.net/scsi-dledford-2.4 as soon
> > > as I can sort through the patches and break them into small pieces.
> > 
> > I was thinking about opening at least a 2.4 drivers tree given some of
> > the issues in 2.4 and driver updates swirling around on this list.
> > 
> > But, if you're going to be maintaining 2.4 for Red Hat, would you like
> > to take point position for reviewing 2.4 patches and passing them on to
> > Marcelo via a BK tree?
> 
> I think that would be a swell idea (assigning a 2.4 SCSI point person),
> for driver updates. It'll be hard to pass tested stuff though, if it all
> comes from vendor trees which are vastly different in some places.
> 
> Changing core drastically is not an option in my book, for 2.4.

Well, the scsi-dledford-2.4 tree is intended to be someplace I can put
all the stuff I'm having to carry forward in our kernels, so that's
distinctly different than a driver update only tree.  I could do that
separately and I have no problem doing that.  As for the other stuff,
I'm not pushing to necessarily get any of my changes into mainline.  I
would be happy if they make it there sometime as that would relieve load
off of me, but at the same time I *am* making some changes to the core
code (sorry Jens, but there are some ways in which the 2.4 core scsi
code is just too broken to believe and leaving it broken just means
dealing with everyone that points it out in bugzilla entries) and I know
people are loath to change core code in mainline, so I kinda figured a
lot of that stuff would either A) stay separate or B) only after myself
and other interested parties agree on a patch and that patch is widely
tested and known good then maybe it might get moved over, up to Marcelo.

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc.
         1801 Varsity Dr.
         Raleigh, NC 27606



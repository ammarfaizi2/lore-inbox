Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267069AbUBMQ32 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 11:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267072AbUBMQ32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 11:29:28 -0500
Received: from 10fwd.cistron-office.nl ([62.216.29.197]:48829 "EHLO
	smtp.cistron-office.nl") by vger.kernel.org with ESMTP
	id S267069AbUBMQ3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 11:29:15 -0500
Date: Fri, 13 Feb 2004 17:29:01 +0100
From: Miquel van Smoorenburg <miquels@cistron.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Nathan Scott <nathans@sgi.com>, miquels@cistron.nl,
       linux-kernel@vger.kernel.org, linux-lvm@sistina.com
Subject: Re: 2.6.3-rc2-mm1 (dm)
Message-ID: <20040213162901.GM14554@traveler.cistron.net>
References: <20040212015710.3b0dee67.akpm@osdl.org> <20040212203306.GA13192@cistron.nl> <20040212212811.GA655@frodo> <20040212143417.41d2ce58.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20040212143417.41d2ce58.akpm@osdl.org> (from akpm@osdl.org on Thu, Feb 12, 2004 at 23:34:17 +0100)
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004.02.12 23:34, Andrew Morton wrote:
> Nathan Scott <nathans@sgi.com> wrote:
> >
> > > This forces the underlying device(s) to a soft blocksize of 512. And
> > > I had my 80 MB/sec write speed back !
> > > 
> > > I'm not sure if setting the blocksize of the underlying device
> > > always to 512 is the right solution. I think that set_blocksize
> > 
> > Hmm... that set_blocksize there must be new in -mm, I don't see
> > that in mainline yet.  I would guess that bdev_hardsect_size()
> > would be more appropriate here than hard-coding 512 bytes.  I
> > don't know the details of the problem being solving by adding
> > set_blocksize() in there though, so I might be completely wrong.
> 
> Yes, 2.6.3-rc2-mm1 has a new device-mapper update.
> 
> Miquel, thanks for picking this up.  I shall wait for the LVM team to
> suggest the preferred fix.

Nah, forget about it. I don't think this actually matters, it's still something
with the 3ware driver in RAID5 mode that fsckes this up. It needs more
investigation (it seems there's some heisenberg effect in there, or
I need more sleep).

Mike.

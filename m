Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264030AbSIQJw2>; Tue, 17 Sep 2002 05:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264029AbSIQJw2>; Tue, 17 Sep 2002 05:52:28 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:15203 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S264030AbSIQJw1>; Tue, 17 Sep 2002 05:52:27 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200209170957.g8H9vMw17037@devserv.devel.redhat.com>
Subject: Re: [PATCH] Experimental IDE oops dumper v0.1
To: andre@linux-ide.org (Andre Hedrick)
Date: Tue, 17 Sep 2002 05:57:21 -0400 (EDT)
Cc: rusty@rustcorp.com.au (Rusty Russell), alan@redhat.com (Alan Cox),
       linux-kernel@vger.kernel.org, vojtech@suse.cz (Vojtech Pavlik)
In-Reply-To: <Pine.LNX.4.10.10209170028370.11597-100000@master.linux-ide.org> from "Andre Hedrick" at Sep 17, 2002 12:42:56 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 	if (ioctl(devfd, HDIO_GET_IDENTITY, &hdid) < 0) {
> > 		perror("Getting identity of drive");
> > 		exit(1);
> > 	}
> 
> Uses and interrupt and nIEN = 0, BUG() for polling

That data can be captured early, in fact if you trust the data structures
a little its potentially still there

> > > Be careful here - one or two drives get nIEN backwards, you might just
> > > want to turn off interrupts and be done with it
> > 
> > Hmm... I have interrupts disabled so I don't really care: should be OK
> > I think.  Or were you thinking of something else?
> 
> Kernel interrupts are not Device.

Should be fine, except as Andre notes you have to poll, but for the simple
commands I don't think thats exactly a killer.

> Depends of if you want hard or soft reset and if you care about signature
> decoding for redetecting presence of attached devices.

I'd guess not. The disk was there, it needs to be in some kind of working
form so resetting it all and pretending to be DOS should do ?

Alan

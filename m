Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932438AbWBXTkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbWBXTkO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 14:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbWBXTkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 14:40:13 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:305 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932438AbWBXTkM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 14:40:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MzwVg6JlWm7nz0yBVUb/spHJLVmwTVbSy3ilJv0blhoN/frRypxTCn7TDB37+5ZJDFTBrIC/5zI9O3qBMxVwTu0Hjd34GTT5tpf81ZVXci7krw7XlqZThDU1AyQok0FsQqgjri8GrgpK8p5LaEVmj02lVunlonkfSTW5SnX+Mwk=
Message-ID: <9a8748490602241140m2be74e81icdc46a843821f0f3@mail.gmail.com>
Date: Fri, 24 Feb 2006 20:40:11 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Alistair John Strachan" <s0348365@sms.ed.ac.uk>
Subject: Re: [PATCH] x86_64 stack trace cleanup
Cc: "Andi Kleen" <ak@suse.de>, "Andres Salomon" <dilinger@debian.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200602241925.17997.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1140777679.5073.17.camel@localhost.localdomain>
	 <1140780552.5073.26.camel@localhost.localdomain>
	 <200602241322.28389.ak@suse.de>
	 <200602241925.17997.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/06, Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> On Friday 24 February 2006 12:22, Andi Kleen wrote:
> > On Friday 24 February 2006 12:29, Andres Salomon wrote:
> > > That would be nice.  Unfortunately, I'm trying to figure out why my dual
> > > opteron box likes to push the load up to 15 and then hang while doing
> > > i/o to the 3ware 9500S-8 card.  Looks like the load/d-state processes
> > > are caused by a whole lot (well, MAX_PDFLUSH_THREADS) of pdflush
> > > processes spinning on base->lock in lock_timer_base(); not sure if
> > > that's intentional or not, but it seems rather odd.  Whether the hanging
> > > is related to the high load remains to be seen.
> >
> > Sounds like some timer handler is broken. You have to find out which
> > one it is.
> >
> > > I don't see why this is a problem.  Other architectures have done this
> > > for ages, without problems.  I suspect most people get their backtraces
> > > from either serial console or logs, as copying them down from the screen
> > > or taking a picture of the panic is a rather large pain.  It seems like
> > > you're penalizing everyone for a few select use cases.
> >
> > People submitting jpegs of photographed oopses or even badly scribbled
> > down oopses is quite common. Serial consoles are only used by a small
> > elite.
>
> I agree, I've had to report using a JPEG file on multiple occasions, because
> my mainboard has no serial ports. However, if you're using a 1280x1024
> vesafb, which is supported by most systems, you can get a lot of lines on
> screen at once..
>

true, but still, if you have two columns of output you get even more
lines on-screen (and in the cases where the oops os long that's IMHO a
good thing).

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

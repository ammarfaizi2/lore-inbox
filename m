Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317107AbSG1Swm>; Sun, 28 Jul 2002 14:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317114AbSG1SwQ>; Sun, 28 Jul 2002 14:52:16 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:48656 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317191AbSG1Sur>;
	Sun, 28 Jul 2002 14:50:47 -0400
Date: Sun, 28 Jul 2002 11:53:10 -0700
From: Greg KH <greg@kroah.com>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.28
Message-ID: <20020728185310.GC5767@kroah.com>
References: <1027553482.11881.5.camel@sonja.de.interearth.com> <Pine.LNX.4.44.0207241803410.4293-100000@home.transmeta.com> <20020727235726.GB26742@win.tue.nl> <20020728024739.GA28873@kroah.com> <20020728155626.GC26862@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020728155626.GC26862@win.tue.nl>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Sun, 30 Jun 2002 17:04:30 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2002 at 05:56:26PM +0200, Andries Brouwer wrote:
> On Sat, Jul 27, 2002 at 07:47:39PM -0700, Greg KH wrote:
> 
> > On Sun, Jul 28, 2002 at 01:57:26AM +0200, Andries Brouwer wrote:
> > > My third candidate is USB. Systems without USB are clearly more stable.
> > 
> > Hm, then that would imply that all of my systems are unstable :)
> > 
> > Seriously, I don't know of any outstanding 2.5 USB issues that cause
> > oopses right now, or effect stability.  Any problems that people are
> > having, they sure are not telling me, or the other USB developers
> > about...
> 
> I reported an oops at shutdown and provided the trivial fix.
> It is the the standard kernel since 2.5.26, I think.

That patch should be in the latest kernel, thanks.  Let me know if you
are still having that problem in .29

> But there are still other oopses at shutdown for 2.5.27.
> 
> For 2.5.29 I reported
> "> I booted 2.5.29 earlier this evening and was greeted by
>  > kernel BUG at transport.c: 351 and
>  > kernel BUG at scsiglue.c: 150.
>  > (And the usb-storage module now hangs initializing; rmmod fails,
>  > reboot is necessary.)"
> 
> Further improvement of usb-storage is possible.

Oh yeah, I'm not saying that this is not true at all :)
Matt added a BUG_ON() that seems to be hitting a lot of people, but I
guess that was his intention.

thanks,

greg k-h

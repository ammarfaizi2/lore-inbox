Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932469AbWAGA5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469AbWAGA5W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 19:57:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbWAGA5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 19:57:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:60633 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932469AbWAGA5V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 19:57:21 -0500
Date: Fri, 6 Jan 2006 19:57:12 -0500
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: jesper.juhl@gmail.com, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, airlied@linux.ie
Subject: Re: 2.6.15-mm1 - locks solid when starting KDE (EDAC errors)
Message-ID: <20060107005712.GF9402@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, jesper.juhl@gmail.com,
	linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
	airlied@linux.ie
References: <9a8748490601051552x4c8315e7n3c61860283a95716@mail.gmail.com> <20060105162714.6ad6d374.akpm@osdl.org> <9a8748490601051640s5a384dddga46d8106442d10c@mail.gmail.com> <20060105165946.1768f3d5.akpm@osdl.org> <9a8748490601061625q14d0ac04ica527821cf246427@mail.gmail.com> <20060107002833.GB9402@redhat.com> <20060106164012.041e14b2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060106164012.041e14b2.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 04:40:12PM -0800, Andrew Morton wrote:
 > Dave Jones <davej@redhat.com> wrote:
 > >
 > > On Sat, Jan 07, 2006 at 01:25:22AM +0100, Jesper Juhl wrote:
 > >  > On 1/6/06, Andrew Morton <akpm@osdl.org> wrote:
 > >  > > Jesper Juhl <jesper.juhl@gmail.com> wrote:
 > >  > >
 > >  > > >  Reverted that one patch, then rebuild/reinstalled the kernel
 > >  > > >  (with the same .config) and booted it - no change. It still locks up
 > >  > > >  in the exact same spot.
 > >  > > >  X starts & runs fine (sort of) since I can play around at the kdm
 > >  > > >  login screen all I want, it's only once I actually login and KDE
 > >  > > >  proper starts that it locks up.
 > >  > >
 > >  > > Oh bugger.  No serial console/netconsole or such?
 > >  > >
 > >  > > Or are you able log in and then quickly do the alt-ctrl-F1 thing, see if we
 > >  > > get an oops?
 > >  > >
 > >  > I switched to tty1 right after logging in, and after a few seconds
 > >  > (corresponding pretty well with the time it takes to hit the same spot
 > >  > where it crashed all previous times) I got a lot of nice crash info
 > >  > scrolling by.
 > >  > Actually a *lot* scrolled by, a rough guestimate says some 4-6 (maybe
 > >  > more) screens scrolled by, and since the box locks up solid I couldn't
 > >  > scroll up to get at the initial parts :(  So all I have for you is the
 > >  > final block - hand copied from the screen using pen and paper
 > >  > ...
 > >  > It never makes it to the logs, and as mentioned previously I don't
 > >  > have another machine to capture on via netconsole or serial, so if you
 > >  > have any good ideas as to how to capture it all, then I'm all ears.
 > > 
 > > If only someone did a patch to pause the text output after the first oops..
 > > 
 > > Oh wait! Someone did!
 > > 
 > 
 > umm, it'd be more helpful if you'd actually sent the patch so Jesper could
 > apply it so we can find this bug.
 > 
 > I think I did one of those too.  It required a new kernel boot option
 > `halt-after-oops' or some such.  Sounds like a good idea?

I thought Jesper had made a comment in that thread, so was aware of it.
Looking at the archive, I see was mistaken.

Jesper: http://lkml.org/lkml/2006/1/4/534
(unmunged diff is at http://lkml.org/lkml/diff/2006/1/4/534/1)

		Dave


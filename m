Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261698AbRESIcZ>; Sat, 19 May 2001 04:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261708AbRESIcP>; Sat, 19 May 2001 04:32:15 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:4074 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261706AbRESIcH>;
	Sat, 19 May 2001 04:32:07 -0400
Date: Sat, 19 May 2001 04:32:06 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Ben LaHaise <bcrl@redhat.com>
cc: Andrew Clausen <clausen@gnu.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code 
 inuserspace
In-Reply-To: <Pine.LNX.4.33.0105190411030.13165-100000@devserv.devel.redhat.com>
Message-ID: <Pine.GSO.4.21.0105190430270.3724-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 19 May 2001, Ben LaHaise wrote:

> On Sat, 19 May 2001, Alexander Viro wrote:
> 
> > On Sat, 19 May 2001, Ben LaHaise wrote:
> >
> > > It's not done yet, but similar techniques would be applied.  I envision
> > > that a raid device would support operations such as
> > > open("/dev/md0/slot=5,hot-add=/dev/sda")
> >
> > Think for a moment and you'll see why it's not only ugly as hell, but simply
> > won't work.
> 
> Yeah, I shouldn't be replying to email anymore in my bleery-eyed state.
> =) Of course slash seperated data doesn't work, so it would have to be
> hot-add=<filedescriptor> or somesuch.  Gah, that's why the options are all
> parsed from a single lookup name anyways...

That's why you want to use write(2) to pass that information instead of
encoding it into open(2).


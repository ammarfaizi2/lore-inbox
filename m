Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270138AbRH1BsN>; Mon, 27 Aug 2001 21:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270133AbRH1BsC>; Mon, 27 Aug 2001 21:48:02 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:39947 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S270134AbRH1Brv>; Mon, 27 Aug 2001 21:47:51 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Daniel Phillips <phillips@bonn-fries.net>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Dieter =?iso-8859-1?q?N=FCtzel=20?= <Dieter.Nuetzel@hamburg.de>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Date: Tue, 28 Aug 2001 03:54:37 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <Pine.LNX.4.21.0108272103560.7385-100000@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.21.0108272103560.7385-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20010828014802Z16275-32383+1852@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 28, 2001 02:05 am, Marcelo Tosatti wrote:
> On Tue, 28 Aug 2001, Dieter Nützel wrote:
> 
> > [-]
> > > In the real-world case we observed the readahead was actually being
> > > throttled by the ftp clients.  IO request throttling on the file read
> > > side would not have prevented cache from overfilling.  Once the cache
> > > filled up, readahead pages started being dropped and reread, cutting
> > > the server throughput by a factor of 2 or so.  On the other hand,
> > > performance with no readahead was even worse.
> > [-]
> > 
> > Are you like some numbers?
> 
> Note that increasing readahead size on -ac and stock tree will affect the
> system in a different way since the VM has different logics on drop
> behind.
> 
> Could you please try the same tests with the stock tree? (2.4.10-pre and
> 2.4.9)

He'll need the proc max-readahead patch posted by Craig I. Hagan on Sunday 
under the subject "Re: [resent PATCH] Re: very slow parallel read 
performance".

There are two other big variables here: Reiserfs and dbench.  Personally, I 
question the value of doing this testing on dbench, it's too erratic.

--
Daniel

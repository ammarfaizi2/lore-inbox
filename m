Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271844AbRH0S60>; Mon, 27 Aug 2001 14:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271845AbRH0S6R>; Mon, 27 Aug 2001 14:58:17 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:39684 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S271844AbRH0S55>; Mon, 27 Aug 2001 14:57:57 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Date: Mon, 27 Aug 2001 21:04:38 +0200
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L.0108241600410.31410-100000@duckman.distro.conectiva> <20010827142441Z16237-32383+1641@humbolt.nl.linux.org> <200108271848.UAA20391@ns.cablesurf.de>
In-Reply-To: <200108271848.UAA20391@ns.cablesurf.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010827185803Z16034-32384+632@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 27, 2001 08:37 pm, Oliver Neukum wrote:
> Hi,
> 
> >   - Readahead cache is naturally a fifo - new chunks of readahead
> >     are added at the head and unused readahead is (eventually)
> >     culled from the tail.
> 
> do you really want to do this based on pages ? Should you not drop all 
> pages associated with the inode that wasn't touched for the longest
> time ?

Isn't that very much the same as dropping pages from the end of the readahead 
queue?

> If you are streaming dropping all should be no great loss.

The quesion is, how do you know you're streaming?  Some files are 
read/written many times and some files are accessed randomly.  I'm trying to 
avoid penalizing these admittedly rarer, but still important cases.

--
Daniel



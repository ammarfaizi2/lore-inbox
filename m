Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272370AbRHYAxj>; Fri, 24 Aug 2001 20:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272371AbRHYAx2>; Fri, 24 Aug 2001 20:53:28 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:5644 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S272370AbRHYAxS>; Fri, 24 Aug 2001 20:53:18 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: otto.wyss@bluewin.ch,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Why don't have bits the same rights as humans! (flushing to disk waiting  time)
Date: Sat, 25 Aug 2001 03:00:07 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <3B802B68.ADA545DB@bluewin.ch>
In-Reply-To: <3B802B68.ADA545DB@bluewin.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010825005328Z16138-32383+1259@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 19, 2001 11:11 pm, Otto Wyss wrote:
> I recently wrote some small files to the floppy disk and noticed almost nothing
> happened immediately but after a certain time the floppy actually started
> writing. So this action took more than 30 seconds instead just a few. This
> remembered me of the elevator problem in the kernel. To transfer this example
> into real live: A person who wants to take the elevator has to wait 8 hours
> before the elevator even starts. While probably everyone agrees this is
> ridiculous in real live astonishingly nobody complains about it in case of a disk.

My early flush patch, posted a month or so ago, takes care of this nicely.
I'm just waiting for 2.5 to roll around to do some more work on it.

> [...]
> Could anybody produce any real figures to prove/disprove my theory? Could
> anybody benchmark the disk access for the 3 waiting times (0, 200ms 30sec) with
> different loads?

Your theory is correct.  I implemented the idea, took measurements, and found
dramatic performance improvements under some loads, while getting worse on
none.  You can search lwn.net for a nice writeup by Jonathan Corbett.

--
Daniel

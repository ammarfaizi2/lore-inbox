Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292975AbSBQMtE>; Sun, 17 Feb 2002 07:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292976AbSBQMsy>; Sun, 17 Feb 2002 07:48:54 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:63240 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S292975AbSBQMsn>; Sun, 17 Feb 2002 07:48:43 -0500
Date: Sun, 17 Feb 2002 07:47:38 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Simon Kirby <sim@netnation.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: fsync delays for a long time.
In-Reply-To: <20020215172436.GA6842@netnation.com>
Message-ID: <Pine.LNX.3.96.1020217074231.30060G-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Feb 2002, Simon Kirby wrote:

> On Thu, Feb 14, 2002 at 12:51:14PM -0800, Andrew Morton wrote:
> Not sure if this is related, but I still can't get 2.4 or 2.5 kernels to
> actually read and write at the same time during a large file copy between
> two totally separate devices (eg: from hda1 to hdc1).  "vmstat 1" shows
> reads with no writing for about 6-8 seconds followed by writes with no
> reading for about 5-6 seconds, repeat.

You don't have enough memory... you can probably tune bdflush to make the
system flush writes more aggressively, but one cause is that you fill all
available memory before bdflush even runs. Try setting the time way down,
say one sec, and see if things change.

Note that this may not make the system run faster in any significant way,
it may just get all the drive lights blinking.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.


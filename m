Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262789AbSKIWci>; Sat, 9 Nov 2002 17:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262790AbSKIWci>; Sat, 9 Nov 2002 17:32:38 -0500
Received: from unthought.net ([212.97.129.24]:32986 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S262789AbSKIWci>;
	Sat, 9 Nov 2002 17:32:38 -0500
Date: Sat, 9 Nov 2002 23:39:21 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Jeff Dike <jdike@karaya.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-rc1 - hang with processes stuck in D
Message-ID: <20021109223921.GE10902@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Jeff Dike <jdike@karaya.com>, Andrew Morton <akpm@digeo.com>,
	linux-kernel@vger.kernel.org
References: <3DC8645B.A0E99A99@digeo.com> <200211060308.gA638Ui08714@karaya.com> <20021108041755.GD1729@unthought.net> <shslm437vi9.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <shslm437vi9.fsf@charged.uio.no>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2002 at 07:43:10PM +0100, Trond Myklebust wrote:
> >>>>> " " == Jakob Oestergaard <jakob@unthought.net> writes:
...
>      > Everything using disk, both on NFS clients and locally running
>      > processes, just pause. Five seconds after everything is like it
>      > never happened.
> 
> If you are using HIGHMEM, then the stock 2.4.20-rc1 has a known issue
> with an unbalanced kmap. Marcelo has already applied the following
> patch in the latest bitkeeper update.

No highmem.  The box has 512 MB RAM.

I get some
eth1: TX underrun, threshold adjusted.
eth0: TX underrun, threshold adjusted.
messages in the syslog - probably around 100 messages or so, but they
stop appearing after a day of uptime or so.  This is two bonded Intel
eepro100 cards, using the "Becker" driver (not the Intel one which I saw
was included).  Those messages do not seem to be correlated with the
pauses at all though.

That's the *only* anomaly except for the pauses, that I see on the box.

The machine has run 2.4.20-rc1 for 5 days now, with an average load
probably around 3 or 4  (load 2 caused by two long-running CPU hogs, the
rest comes from disk I/O, mostly because it's NFS exporting a 147G fs).

Stable so far, but the "hickups" are weird.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261951AbTCaXvO>; Mon, 31 Mar 2003 18:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261952AbTCaXvN>; Mon, 31 Mar 2003 18:51:13 -0500
Received: from [12.47.58.55] ([12.47.58.55]:32461 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id <S261951AbTCaXvM>;
	Mon, 31 Mar 2003 18:51:12 -0500
Date: Mon, 31 Mar 2003 16:02:12 -0800
From: Andrew Morton <akpm@digeo.com>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: piggin@cyberone.com.au, helgehaf@aitel.hist.no, erik@hensema.net,
       linux-kernel@vger.kernel.org
Subject: Re: Delaying writes to disk when there's no need
Message-Id: <20030331160212.57a9646c.akpm@digeo.com>
In-Reply-To: <20030401013258.G626@nightmaster.csn.tu-chemnitz.de>
References: <slrnb843gi.2tt.usenet@bender.home.hensema.net>
	<20030328231248.GH5147@zaurus.ucw.cz>
	<slrnb8gbfp.1d6.erik@bender.home.hensema.net>
	<3E8845A8.20107@aitel.hist.no>
	<3E88BAF9.8040100@cyberone.com.au>
	<20030331144500.17bf3a2e.akpm@digeo.com>
	<20030401013258.G626@nightmaster.csn.tu-chemnitz.de>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Apr 2003 00:02:29.0748 (UTC) FILETIME=[FC9A7B40:01C2F7E1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de> wrote:
>
> On Mon, Mar 31, 2003 at 02:45:00PM -0800, Andrew Morton wrote:
> > It could have pretty bad failure modes.  Short-lived files in /tmp now
> > perform writeout, which needs to be waited on when those files are removed.
> 
> /tmp is not a problem, because this can be fixed by using tmpfs
> (I use 2GB of it with 1GB of RAM).

I don't.   These files get unlinked before they hit disk.

> The disk is idle, so this is not about performance, but power
> consumption. Spinning up a disk costs around 1-2 seconds, so you
> should come in with at least the amount of data you write in 1-2
> seconds for a spun down disk.

The requirements for portable computers are totally different.  You'd turn
the whole thing off for them.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317036AbSGNSlT>; Sun, 14 Jul 2002 14:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317059AbSGNSlS>; Sun, 14 Jul 2002 14:41:18 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:4615 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317036AbSGNSlR>; Sun, 14 Jul 2002 14:41:17 -0400
Date: Sun, 14 Jul 2002 11:46:24 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: Tim Schmielau <tim@physik3.uni-rostock.de>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: What is supposed to replace clock_t?
In-Reply-To: <200207132015.g6DKFsH103416@saturn.cs.uml.edu>
Message-ID: <Pine.LNX.4.44.0207141143300.19060-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 13 Jul 2002, Albert D. Cahalan wrote:
> Linus Torvalds writes:
>
> > The only sane interface is a seconds-based one, either like /proc/uptime
> > (ie ASCII floating point representation) or a mixed integer representation
> > like timeval/timespec where you have seconds and micro/nanoseconds
> > separately.
>
> Anything wrong with 64-bit nanoseconds? It's easy to work with,
> being an integer type, and it survives the year 2038.

That still counts as being "seconds-based" in my book - the problem with
clock_t (and jiffies) has always been that it has been based not on a
globally defined time-standard, but on an implementation issue.

And we want to be able to change the implementation issue at will.

		Linus


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261578AbSJHJar>; Tue, 8 Oct 2002 05:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261599AbSJHJar>; Tue, 8 Oct 2002 05:30:47 -0400
Received: from 10fwd.cistron-office.nl ([62.216.29.197]:20942 "EHLO
	smtp.cistron-office.nl") by vger.kernel.org with ESMTP
	id <S261578AbSJHJaq>; Tue, 8 Oct 2002 05:30:46 -0400
Date: Tue, 8 Oct 2002 11:36:23 +0200
From: Miquel van Smoorenburg <miquels@cistron.nl>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: experiences with 2.5.40 on a busy usenet news server
Message-ID: <20021008113623.A19014@cistron.nl>
Reply-To: linux-kernel@vger.kernel.org
References: <anu60s$oev$1@ncc1701.cistron.net> <3DA2A233.88525FE4@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3DA2A233.88525FE4@digeo.com>; from akpm@digeo.com on Tue, Oct 08, 2002 at 02:15:31AM -0700
X-NCC-RegID: nl.cistron
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to Andrew Morton:
> Miquel van Smoorenburg wrote:
> > # free
> 
> Please always send /proc/meminfo - it's way more informative.
> A vmstat trace is also useful.

Will do next time.

> > No need to swap 364 MB when there's 872 MB still free...
> > This makes the machine dogslow. An 'expire' process that
> > runs every night normally takes 15 minutes to finish now
> > has been running for 10 hours and its still not finished.
> 
> It must be doing a ton of IO?

Oh yes. This is a usenet news server, 50 mbit/sec
sustained in, 100 mbit/sec sustained out, and it's all being
cached on disk. See http://newsgate.cistron.nl/

> You'll probably find that 2.5.41-mm1 does not swap at all; but
> I'd need to see meminfo to know.

Right now I've not rebooted but instead I turned off swap. It
has enough memory anyway.

The 'expire' process that ran for 10 hours finished within
2 minutes, load went down from 6 to 1.8, and traffic volume
is climbing again.

I'll let it run like this for a few hours so it can catch up
with the backlog my peers have to me, then in the afternoon I'll
try 2.5.41-mm<latest> on it.

Mike.

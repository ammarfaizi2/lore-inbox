Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261946AbSJITRL>; Wed, 9 Oct 2002 15:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261951AbSJITRL>; Wed, 9 Oct 2002 15:17:11 -0400
Received: from mail18.svr.pol.co.uk ([195.92.67.23]:35342 "EHLO
	mail18.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S261946AbSJITRK>; Wed, 9 Oct 2002 15:17:10 -0400
Date: Wed, 9 Oct 2002 19:44:45 +0100
To: Andrew Morton <akpm@digeo.com>
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>, linux-lvm@sistina.com
Subject: Re: [PATCH] 2.5 version of device mapper submission
Message-ID: <20021009184445.GA25733@fib011235813.fsnet.co.uk>
References: <20021009181259.GA25050@fib011235813.fsnet.co.uk> <3DA47606.546A558E@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DA47606.546A558E@digeo.com>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2002 at 11:31:34AM -0700, Andrew Morton wrote:
> Joe Thornber wrote:
> > 
> > The 2.5 port of device-mapper is available from:
> > 
> >    bk://device-mapper.bkbits.net/2.5-stable
> 
> Is it available in a form which everyone can access?

http://people.sistina.com/~thornber/dm_2002-10-09.tar.bz2

> What I really wanted to know is "are you still using kiobufs"?

What I just submitted doesn't include the snapshot target as yet, I
want people to focus on the dm core rather than getting side tracked
by one of the targets.

> If so, what do we need to do to not do that?

For the last few months all snapshot io has been going through kcopyd,
*except* the snapshot metadata update (which did use a kiobuf).  I
have a patch which sends the metadata through kcopyd in the works, so
when I submit the snapshot target it will not use a kiobuf - I'm no
fan of kiobufs.

- Joe

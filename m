Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132277AbRA3TOb>; Tue, 30 Jan 2001 14:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132386AbRA3TOV>; Tue, 30 Jan 2001 14:14:21 -0500
Received: from adsl-209-182-168-213.value.net ([209.182.168.213]:30473 "EHLO
	draco.foogod.com") by vger.kernel.org with ESMTP id <S132277AbRA3TOQ>;
	Tue, 30 Jan 2001 14:14:16 -0500
Date: Tue, 30 Jan 2001 11:13:59 -0800
From: alex@foogod.com
To: Rik van Riel <riel@conectiva.com.br>
Cc: alex@foogod.com, Alan Olsen <alan@clueserver.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Recommended swap for 2.4.x.
Message-ID: <20010130111359.C13819@draco.foogod.com>
In-Reply-To: <20010130101009.B13819@draco.foogod.com> <Pine.LNX.4.21.0101301612360.1321-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <Pine.LNX.4.21.0101301612360.1321-100000@duckman.distro.conectiva>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2001 at 04:22:20PM -0200, Rik van Riel wrote:
> At the moment there is no way to reclaim the swap space if
> the page is shared, and for non-shared pages we haven't
> implemented a way to reclaim swap space.
> 
> While reclaiming swap space when you run out is pretty
> trivial to do, Linus doesn't seem to like the idea all
> that much and Disk Space Is Cheap(tm) so it's not very
> high on my list of things to do.

In general, I agree that Disk Space Is Cheap(tm) (though, of course, there are 
always unusual cases where it may not be), but my primary concern is for 
migration of existing configurations.  It sounds like what you're saying is 
that if I have a machine with 1GB RAM and 1GB swap that I upgrade from 2.2 to 
2.4, all of a sudden this machine has effectively half the VM it used to.  
That could cause some rather unexpected behavior, so it's good to know ahead 
of time..

I guess it's a good thing this question was brought up.

> > Does this mean that having a swap partition less than or equal
> > to RAM is now effectively pointless?
> 
> If you're swapping heavily, yes. If most of your programs
> fit in memory and you're hardly using swap, nothing changes.

I think I'm confused.. are you saying that it's useful to have swap which you 
can't use?  (What I'm hearing is "if you try to use it it won't work, but if 
you don't use it it works fine."  I get the feeling I'm missing something 
subtle.)

-alex
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

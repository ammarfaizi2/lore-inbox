Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272619AbRIPRae>; Sun, 16 Sep 2001 13:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272590AbRIPRaZ>; Sun, 16 Sep 2001 13:30:25 -0400
Received: from family.zawodny.com ([63.174.200.26]:33555 "EHLO
	family.zawodny.com") by vger.kernel.org with ESMTP
	id <S272588AbRIPRaJ>; Sun, 16 Sep 2001 13:30:09 -0400
Date: Sun, 16 Sep 2001 10:18:45 -0700
From: Jeremy Zawodny <Jeremy@Zawodny.com>
To: Ricardo Galli <gallir@m3d.uib.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: broken VM in 2.4.10-pre9
Message-ID: <20010916101845.A14285@peach.zawodny.com>
In-Reply-To: <Pine.LNX.4.33L.0109161330000.9536-100000@imladris.rielhome.conectiva> <Pine.LNX.4.33.0109161856380.31311-100000@m3d.uib.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0109161856380.31311-100000@m3d.uib.es>
User-Agent: Mutt/1.3.20i
X-message-flag: Mailbox corrupt.  Please upgrade your mail software.
X-Uptime: 10:16:35 up 49 days,  8:14, 10 users,  load average: 0.00, 0.00, 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 16, 2001 at 07:06:45PM +0200, Ricardo Galli wrote:
> On Sun, 16 Sep 2001, Rik van Riel wrote:
> >
> > > Is there a way to tell the VM to prune its cache? Or a way to limit
> > > the amount of cache it uses?
> >
> > Not yet, I'll make a quick hack for this when I get back next
> > week. It's pretty obvious now that the 2.4 kernel cannot get
> > enough information to select the right pages to evict from
> > memory.
> 
> ....
> 
> On Sun, 16 Sep 2001, Jeremy Zawodny wrote:
> >
> > Agreed. I'd be great if there was an option to say "Don't swap out
> > memory that was allocated by these programs. If you run out of disk
> > buffers, toss the oldest ones and start re-using them."
> 
> More easy though (for cases of listening mp3's and backups): cache
> pages that were accesed only "once"(*) several seconds ago must be
> discarded first. It only implies a check against an access counter
> and a "last accesed" epoch fields of the page.

Yeah, something along those lines would be great.  It would keep a big
(13 GB) drive to drive file copy from causing a large (400MB) and
relatively active process from having its memory swapped out (and then
back in 20 seconds later).

Imagine watching that for 45 minutes while a backup that used to take
5-8 minutes runs.

Jeremy
-- 
Jeremy D. Zawodny     |  Perl, Web, MySQL, Linux Magazine, Yahoo!
<Jeremy@Zawodny.com>  |  http://jeremy.zawodny.com/

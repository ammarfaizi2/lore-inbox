Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278795AbRJZRnA>; Fri, 26 Oct 2001 13:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278798AbRJZRmu>; Fri, 26 Oct 2001 13:42:50 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:31264 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S278795AbRJZRmj>; Fri, 26 Oct 2001 13:42:39 -0400
Date: Fri, 26 Oct 2001 19:43:01 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Christopher S. Swingley" <cswingle@iarc.uaf.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.13-ac1
Message-ID: <20011026194301.M30905@athlon.random>
In-Reply-To: <20011026092359.A9384@iarc.uaf.edu> <E15xAso-0000mW-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <E15xAso-0000mW-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Oct 26, 2001 at 06:35:02PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2001 at 06:35:02PM +0100, Alan Cox wrote:
> > Does this mean the ac tree now uses the AA VM, or is this a merge
> > with everything but the VM, like the earlier 2.4.1x-ac trees?
> 
> It still uses buffer cache based raw disk access (so things like DVD players

btw, AFIK the fact dvd player can hang some millisecond across a
close/open cycle, isn't really because of the blkdev in pagecache but
simply because the <2.4.10 buffer cache layer wasn't able to do proper
readahead on the blkdev. Now we do readahead properly and so in turn
the the lack of media-change trust of the vfs shows up. So as far I can
tell the right fix have no influence on the blkdev in pagecache, but it
only consists in resurrecting the media-change detection with a
per-device bitflag whitelist. I cannot see other source of stalls across
a close/open cycle.

Andrea

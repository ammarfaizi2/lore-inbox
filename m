Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265711AbTL3K2B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 05:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265731AbTL3K2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 05:28:01 -0500
Received: from [24.35.117.106] ([24.35.117.106]:31118 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S265711AbTL3K1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 05:27:53 -0500
Date: Tue, 30 Dec 2003 05:27:04 -0500 (EST)
From: Thomas Molina <tmolina@cablespeed.com>
X-X-Sender: tmolina@localhost.localdomain
To: William Lee Irwin III <wli@holomorphy.com>
cc: Martin Schlemmer <azarah@nosferatu.za.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 performance problems
In-Reply-To: <20031230050934.GM27687@holomorphy.com>
Message-ID: <Pine.LNX.4.58.0312300524370.8179@localhost.localdomain>
References: <Pine.LNX.4.58.0312291647410.5288@localhost.localdomain>
 <Pine.LNX.4.58.0312291420370.1586@home.osdl.org>
 <Pine.LNX.4.58.0312291755080.5835@localhost.localdomain>
 <1072739685.25741.65.camel@nosferatu.lan> <20031230050934.GM27687@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Dec 2003, William Lee Irwin III wrote:

> On Tue, 2003-12-30 at 00:58, Thomas Molina wrote:
> >> It certainly looks like DMA is enabled.  Under 2.4 I get:
> >> [root@lap root]# hdparm /dev/hda
> [...]
> >>  readahead    =  8 (on)
> [...]
> >> Under 2.6  I get:
> >> [root@lap root]# hdparm /dev/hda
> [...]
> >>  readahead    = 256 (on)
> 
> On Tue, Dec 30, 2003 at 01:14:45AM +0200, Martin Schlemmer wrote:
> > Increase your readahead:
> >  # hdparm -a 8192 /dev/hda
> > BTW:  As we really do get this question a _lot_ of times, why
> >       don't the ide layer automatically set a higher readahead
> >       if there is enough cache on the drive or something?
> 
> Could you try lowering 2.6's readahead to 2.4's levels in order to rule
> out readahead-induced thrashing?

I thought I had already sent that.  The timings for readahead of 8 was:

real    25m39.653s
user    0m37.594s
sys     0m55.454s

Increasing readahead in 2.6 to 8192 likewise doesn't help.

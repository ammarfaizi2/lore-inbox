Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265406AbUADMWa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 07:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265438AbUADMWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 07:22:30 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:22196 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265406AbUADMW2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 07:22:28 -0500
Date: Sun, 4 Jan 2004 13:22:24 +0100
From: Jens Axboe <axboe@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Long pauses (IO?) whilst ripping DVDs
Message-ID: <20040104122224.GG3418@suse.de>
References: <2950000.1073111086@[10.10.2.4]> <20040103122614.GW5523@suse.de> <34270000.1073154474@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34270000.1073154474@[10.10.2.4]>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 03 2004, Martin J. Bligh wrote:
> 
> 
> --Jens Axboe <axboe@suse.de> wrote (on Saturday, January 03, 2004 13:26:14 +0100):
> 
> > On Fri, Jan 02 2004, Martin J. Bligh wrote:
> >> Start transcode in one window, doing something like:
> >> "transcode -i /dev/hdc -x dvd -U file_name -y divx4"
> >> on a DVD ... probably pretty CPU intensive as well as IO.
> >> 
> >> Now do ls in another window ... hangs for about 5 seconds before
> >> giving any output ;-( Anyone else seeing that? I do get a lot of
> >> "*** libdvdread: CHECK_VALUE failed in nav_read.c:202 ***"
> >> messages as well ... but I always seem to get those from DVD stuff.
> > 
> > DMA or PIO? vmstat info would be very handy here.
> > 
> > -- 
> > Jens Axboe
> > 
> > 
> 
> OK, now I'm really confused ... sometimes it happens. sometimes it doesn't
> with no apparent rhyme or reason. You're welcome to the data I have though.

You have periods of excessive system usage, although DMA is enabled on
the drive. Depending on what transcode does, it might still be using pio
though. Any chance you can profile such a 'sy' peak so we can see what's
going on?

Looks odds, though. I'm inclined to guess this is a CPU scheduler
problem. Does booting with elevator=deadline change anything at all?

-- 
Jens Axboe


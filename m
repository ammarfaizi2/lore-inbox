Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263125AbTCLJ5V>; Wed, 12 Mar 2003 04:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263124AbTCLJ5V>; Wed, 12 Mar 2003 04:57:21 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:17668
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S263125AbTCLJ5U>; Wed, 12 Mar 2003 04:57:20 -0500
Date: Wed, 12 Mar 2003 02:07:57 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Jens Axboe <axboe@suse.de>
cc: scott thomason <scott-kernel@thomasons.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bio too big device
In-Reply-To: <20030312090943.GA3298@suse.de>
Message-ID: <Pine.LNX.4.10.10303120205250.391-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


No that is wrong to force all other drives to under perform because on
one.  If you are going to impose 255 then pushi it back to 128 were it is
a single scatter list.  This issue has bugged me for years and now that we
know the exact model we apply an exception rule to it.

This is one silly bug that I have heard about.

Cheers,

On Wed, 12 Mar 2003, Jens Axboe wrote:

> On Wed, Mar 12 2003, Andre Hedrick wrote:
> > 
> > So lets dirty list the one drive by Paul G. and be done.
> > Can we do that?
> 
> Who cares, really? There's not much point in doing it, we're talking 248
> vs 256 sectors in reality. I think it's a _bad_ idea, lets just keep it
> at 255 and avoid silly drive bugs there.
> 
> -- 
> Jens Axboe
> 

Andre Hedrick
LAD Storage Consulting Group


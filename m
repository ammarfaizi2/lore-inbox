Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267208AbTB0WPz>; Thu, 27 Feb 2003 17:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267218AbTB0WPz>; Thu, 27 Feb 2003 17:15:55 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:43018
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S267208AbTB0WPx>; Thu, 27 Feb 2003 17:15:53 -0500
Date: Thu, 27 Feb 2003 13:57:47 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Scott Lee <scottlee@redhot.rose.hp.com>
cc: linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: [PATCH] ide write barriers
In-Reply-To: <200302262031.MAA18505@redhot.rose.hp.com>
Message-ID: <Pine.LNX.4.10.10302271355430.15551-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Feb 2003, Scott Lee wrote:

> > The goal is to make the use of write
> > back cache enabled ide drives safe with journalled file systems.
> 
> Does this mean that having write caching enabled is not safe if you are
> using ext3 on an IDE drive?  Should "hdparm -W 0 /dev/hda" be used for
> example.  (I see a 50% performance hit using "-W 0" when my box is under
> load.)  If this is the case, what is the root cause?  Do IDE drives
> reorder writes when they are cached?

All drives reorder unless instructed not to do so.
ATA drives are just now getting FUA hooks.
So flush cache often.

Cheers,

Andre Hedrick
LAD Storage Consulting Group


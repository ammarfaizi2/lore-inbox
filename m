Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275039AbRIYPXq>; Tue, 25 Sep 2001 11:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275040AbRIYPXh>; Tue, 25 Sep 2001 11:23:37 -0400
Received: from otter.mbay.net ([206.40.79.2]:31248 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S275039AbRIYPXP>;
	Tue, 25 Sep 2001 11:23:15 -0400
Date: Tue, 25 Sep 2001 08:23:10 -0700 (PDT)
From: John Alvord <jalvo@mbay.net>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: [PATCH] 2.4.10 improved reiserfs a lot, but could still be better
In-Reply-To: <107194016.1001432841@[10.132.113.67]>
Message-ID: <Pine.LNX.4.20.0109250820001.28393-100000@otter.mbay.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2001, Alex Bligh - linux-kernel wrote:

> 
> 
> --On Tuesday, September 25, 2001 2:11 AM +0200 Matthias Andree 
> <matthias.andree@stud.uni-dortmund.de> wrote:
> 
> > Why are disk drives slower with their caches disabled on LINEAR writes?
> 
> Probably because sectors are so close together on the physical media.
> If you disable write caching, and are writing sectors 1001, 1002, 1003
> etc., you tell it to write sector 1001, and it doesn't complete until
> it's written it, you IRQ the PC, and it sends the write out for 1002,
> which completes a little later. However, by this time 1002 has
> flown past the drive head, as it wasn't immediately queued on the drive.

There used to be stupid hard disk formatting tricks where the sector
numbers were interleaved

1001 1008 1002 1009 1003 1010 1004 1011 1005 1012 1006 1013 1007 1014

just to gain that enhancement. I also remember an ancient IBM Dasd trick
where the sectors were offset just slightly so that a track to track
switch could pick up the next sector in time.

Ancient history...
john


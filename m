Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313316AbSDPRHU>; Tue, 16 Apr 2002 13:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313338AbSDPRHT>; Tue, 16 Apr 2002 13:07:19 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:35487 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S313316AbSDPRHS>;
	Tue, 16 Apr 2002 13:07:18 -0400
Date: Tue, 16 Apr 2002 19:06:46 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        David Lang <david.lang@digitalinsight.com>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Vojtech Pavlik <vojtech@suse.cz>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.8 IDE 36
Message-ID: <20020416190646.C1711@ucw.cz>
In-Reply-To: <Pine.LNX.4.33.0204160849540.1244-100000@home.transmeta.com> <E16xVjb-0000I7-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2002 at 05:23:11PM +0100, Alan Cox wrote:
> > No, you just need to do the loopback over nbd - you need something to do
> > the byte swapping anyway (ie you can't really use the normal "loop"
> > device: I really just meant the more generic "loop the data back"
> > approach).
> 
> nbd goes via the networking layer and deadlocks if looped. The loop driver
> is also much faster. Partitioned loop doesnt seem hard.

And it'd be very cool for stuff like mounting Bochs disk images and
similar.

> 
> > nbd devices already do partitioning, I'm fairly certain.
> 
> Not when I checked.
> 
> > > the Tivo are examples of that. Interworking requires byteswapping and the
> > > ability to handle byteswapped partition tables.
> > 
> > Note that THAT case is an architecture issue, and should probably be
> > handled by just making the IDE "insw" macro do the byteswapping natively.
> > That way you don't get the current "it can actually corrupt your
> > filesystem on SMP" behaviour.
> 
> Thats still not enough. If you have the ide insw macro then control 
> transfers come out wrong. And to maximise the pain - some Amiga controllers
> are backwards some are not. 
> 	"The use of excessive force has been authorised in the ..."
> 
> And then people stick TiVo disks in their PC's in order to prep them for
> various TiVo hackery.

-- 
Vojtech Pavlik
SuSE Labs

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313714AbSDPRAq>; Tue, 16 Apr 2002 13:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313770AbSDPRAp>; Tue, 16 Apr 2002 13:00:45 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:19103 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S313714AbSDPRAp>;
	Tue, 16 Apr 2002 13:00:45 -0400
Date: Tue, 16 Apr 2002 19:00:14 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Richard Gooch <rgooch@ras.ucalgary.ca>,
        David Lang <david.lang@digitalinsight.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.8 IDE 36
Message-ID: <20020416190014.A1711@ucw.cz>
In-Reply-To: <20020416172434.A1180@ucw.cz> <Pine.LNX.4.33.0204160844090.1167-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2002 at 08:46:31AM -0700, Linus Torvalds wrote:
> 
> On Tue, 16 Apr 2002, Vojtech Pavlik wrote:
> > 
> > Note that the above commands are no help in case of plugging TIVO
> > drive into a PC. While they assure that all ext2 filesystems are LE on
> > the media and all sun disklabels are BE on the media, still if you plug
> > in a BE ext2 into the system (or a BE PC partition table), the kernel
> > won't understand them.
> 
> Please use a the network block device, and teach the ndb deamon to just 
> byteswap each word.
> 
> Problem solved, WITHOUT keeping bugs in the IDE driver.

Yeah, that's a pretty cool idea.

> Oh, and performance improved at the same time.
> 
> What are you guys thinging about? There are two rules here:
>  - optimize for the common case
>  - keep the code clean.

There is also this one:

   - don't remove existing features if you don't have an usable
     replacement or users will hate you.

> Both of them say that Martin is 100% right.

Now that you've come up with the NBD idea, I have to agree.

-- 
Vojtech Pavlik
SuSE Labs

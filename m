Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271432AbRHUDM3>; Mon, 20 Aug 2001 23:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271479AbRHUDMT>; Mon, 20 Aug 2001 23:12:19 -0400
Received: from ns.suse.de ([213.95.15.193]:7690 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S271432AbRHUDMF>;
	Mon, 20 Aug 2001 23:12:05 -0400
Date: Tue, 21 Aug 2001 05:12:19 +0200
From: Andi Kleen <ak@suse.de>
To: Paul Jakma <paul@clubi.ie>
Cc: Andi Kleen <ak@suse.de>, Richard Gooch <rgooch@ras.ucalgary.ca>,
        tytso@mit.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] let Net Devices feed Entropy, updated (1/2)
Message-ID: <20010821051219.A21099@gruyere.muc.suse.de>
In-Reply-To: <oupk7zyqhw3.fsf@pigdrop.muc.suse.de> <Pine.LNX.4.33.0108210353320.7402-100000@fogarty.jakma.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0108210353320.7402-100000@fogarty.jakma.org>; from paul@clubi.ie on Tue, Aug 21, 2001 at 04:02:47AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2001 at 04:02:47AM +0100, Paul Jakma wrote:
> On 21 Aug 2001, Andi Kleen wrote:
> 
> > It is not that they are hard to fix; e.g. a $10 sound card
> > with a noise generating circuit on input and a small daemon to feed
> > /dev/audio to /dev/random can do it; but few people seem to know about
> 
> does this update the entropy count though? from previous 
> discussions, i believe not, which iiuc means /dev/random will block 
> just as frequently/infrequently irrespective of whether you feed 
> stuff into /dev/random.

Just writing into /dev/random feeds it, but only credits a very small
amount of entropy into the store, so you need to feed a lot of data.
To feed it with full accounting you need to use a special ioctl on /dev/random;
e.g. using the rndfeed tool (see ftp.firstfloor.org:/pub/ak/smallsrc/rndfeed.c)

-Andi

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129935AbRCAUfN>; Thu, 1 Mar 2001 15:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129976AbRCAUdx>; Thu, 1 Mar 2001 15:33:53 -0500
Received: from [194.213.32.137] ([194.213.32.137]:4100 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129923AbRCAUbI>;
	Thu, 1 Mar 2001 15:31:08 -0500
Date: Sat, 1 Jan 2000 00:19:15 +0000
From: Pavel Machek <pavel@suse.cz>
To: Andi Kleen <ak@suse.de>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com
Subject: Re: New net features for added performance
Message-ID: <20000101001915.A40@(none)>
In-Reply-To: <3A9842DC.B42ECD7A@mandrakesoft.com> <oupsnl3k5gs.fsf@pigdrop.muc.suse.de> <3A984BDA.190B4D8E@mandrakesoft.com> <20010225011211.A23853@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010225011211.A23853@gruyere.muc.suse.de>; from ak@suse.de on Sun, Feb 25, 2001 at 01:12:11AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > an alloc of a PKT_BUF_SZ'd skb immediately follows a free of a
> > same-sized skb.  100% of the time.
> 
> Free/Alloc gives the mm the chance to throttle it by failing, and also to 
> recover from fragmentation by packing the slabs. If you don't do it you need
> to add a hook somewhere that gets triggered on low memory situations and 
> frees the buffers.

And what? It makes allocation longer lived. Our MM should survive that just
fine.

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.


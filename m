Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130249AbQKFIDf>; Mon, 6 Nov 2000 03:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130289AbQKFIDR>; Mon, 6 Nov 2000 03:03:17 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:37126 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S130249AbQKFIDF>; Mon, 6 Nov 2000 03:03:05 -0500
Date: Mon, 6 Nov 2000 08:02:53 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Oliver Xymoron <oxymoron@waste.org>
cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
In-Reply-To: <Pine.LNX.4.10.10011060135050.8248-100000@waste.org>
Message-ID: <Pine.LNX.4.21.0011060800490.15143-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2000, Oliver Xymoron wrote:

> > 'init module' is still _after_ 'set mixer levels'. There is a period
> > during which the mixer levels are changed.
> 
> Perhaps you mean before? Otherwise you've lost me.

Yeah, sorry, not enough coffee yet this morning.

> > The desired mixer levels should be available to the module at the time of
> > initialisation.
> 
> Is this because active audio sources other than /dev/dsp writers are
> suddenly in and out of the mix? If there's nothing on the inputs, it
> shouldn't matter whether you're changing the levels.

Yes. 

> The right way to do this (according to any sound engineer) is to
> initialize all the levels to zero unless told otherwise. This would
> doubtless annoy the average user, but is more or less equivalent to not
> forwarding packets by default.

The current situation is equivalent to stopping forwarding packets each
time an app on the local machine decides it wants to send its own packets,
after a period of inactivity.

Defaulting to zero on boot is fine. Defaulting to zero after the module
has been auto-unloaded and auto-loaded again is less good.

-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

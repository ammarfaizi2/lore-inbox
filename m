Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129374AbQKFHsw>; Mon, 6 Nov 2000 02:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130266AbQKFHsm>; Mon, 6 Nov 2000 02:48:42 -0500
Received: from waste.org ([209.173.204.2]:55080 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S129374AbQKFHsd>;
	Mon, 6 Nov 2000 02:48:33 -0500
Date: Mon, 6 Nov 2000 01:48:15 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: David Woodhouse <dwmw2@infradead.org>
cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
In-Reply-To: <Pine.LNX.4.21.0011060730410.14068-100000@imladris.demon.co.uk>
Message-ID: <Pine.LNX.4.10.10011060135050.8248-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2000, David Woodhouse wrote:

> On Mon, 6 Nov 2000, Oliver Xymoron wrote:
> 
> > If I understand you correctly:
> > 
> > process 1         process 2
...
> 
> > Is there any reason we ever want to unblock process 1 before process 2
> > terminates?
> 
> No, and I don't think we do. That's not the point.
> 
> 'init module' is still _after_ 'set mixer levels'. There is a period
> during which the mixer levels are changed.

Perhaps you mean before? Otherwise you've lost me.

> The desired mixer levels should be available to the module at the time of
> initialisation.

Is this because active audio sources other than /dev/dsp writers are
suddenly in and out of the mix? If there's nothing on the inputs, it
shouldn't matter whether you're changing the levels.

The right way to do this (according to any sound engineer) is to
initialize all the levels to zero unless told otherwise. This would
doubtless annoy the average user, but is more or less equivalent to not
forwarding packets by default.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

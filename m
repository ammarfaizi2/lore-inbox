Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284717AbSAULfC>; Mon, 21 Jan 2002 06:35:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284732AbSAULex>; Mon, 21 Jan 2002 06:34:53 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:8454 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S284717AbSAULen>;
	Mon, 21 Jan 2002 06:34:43 -0500
Date: Mon, 21 Jan 2002 12:34:30 +0100
From: Jens Axboe <axboe@suse.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Andre Hedrick <andre@linuxdiskcert.org>,
        Davide Libenzi <davidel@xmailserver.org>,
        Anton Altaparmakov <aia21@cam.ac.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.3-pre1-aia1
Message-ID: <20020121123430.B27835@suse.de>
In-Reply-To: <20020121114311.A24604@suse.cz> <Pine.LNX.4.10.10201210308460.14375-100000@master.linux-ide.org> <20020121123243.A24754@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020121123243.A24754@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21 2002, Vojtech Pavlik wrote:
> > If the device is programmed for to do 16 sectors in multimode, it and you
> > issue a read/write multiple pio and short change the device it is not
> > going to like it.  However if it is programmed for multimode and you issue
> > single sector pio transfers command opcodes it is fine.
> > 
> > Do we differ?
> 
> I think so. Check my mail from 11:14:56 GMT today. I fully understand
> that if I supply less data to the device than it expects or get less
> from it than it has, it'll be a problem. But I think the specification
> doesn't prohibit reading amounts not divisible by multimode setting via
> the multimode command. I've read it quite carefully again.

Like I said, if this was indeed a problem it would be _trivial_ to break
2.2/2.4 IDE with enabled multi mode... Basically it would be hard to get
_anything_ done.

-- 
Jens Axboe


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288914AbSAUW6G>; Mon, 21 Jan 2002 17:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288882AbSAUW55>; Mon, 21 Jan 2002 17:57:57 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:21520 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S288842AbSAUW5p>; Mon, 21 Jan 2002 17:57:45 -0500
Date: Mon, 21 Jan 2002 23:57:43 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andre Hedrick <andre@linuxdiskcert.org>
Cc: Jens Axboe <axboe@suse.de>, Davide Libenzi <davidel@xmailserver.org>,
        Anton Altaparmakov <aia21@cam.ac.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.3-pre1-aia1
Message-ID: <20020121235743.A28134@suse.cz>
In-Reply-To: <20020121184433.C1018@suse.de> <Pine.LNX.4.10.10201211133310.15703-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10201211133310.15703-100000@master.linux-ide.org>; from andre@linuxdiskcert.org on Mon, Jan 21, 2002 at 12:18:21PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2002 at 12:18:21PM -0800, Andre Hedrick wrote:

> > > Again, the HOST(Linux) is not following the device side rules so expect
> > > difficulty when we depart.  The Brain Damage is how to talk to the
> > > hardware, and it is clear we are not doing it right because we are bending
> > > the rules stuff it into and API that not acceptable.  However we are
> > > stuck.  Again, simplicity works, generate a MEMPOOL for PIO such that the
> > > buffer pages are contigious and the 4k page dance is a NOOP.  Until that
> > > time we will be fussing about.
> > 
> > Andre,
> > 
> > Do you know how to say "I was wrong"? You are walking off-track again.
> > It's clearly the way that Vojtech and I describe, otherwise current code
> > would just not work. And 2.4, 2.2, 2.0 neither.
> 
> I will and have done so in the past when I am, and it would be nice if you
> and Linus could do the same.  However since both are going to enforce the
> partial completion of IO on page boundaries or 4k, and you are not
> allowed to pause or stop in the middle of a command execution to play
> memory games under ATA/IDE PIO rules, period.

Maybe I'm again totally off-the-track, but I see no reason why I
couldn't stop in the middle of a PIO transfer (that is anytime, not even
on a sector boundary), do whatever I wish, like change the destination
buffer or whatever, and then continue. Sure, I can't send ANY commands
to the drive, and reading the status might not be a good idea either,
but I believe I can do anything else on the system. Is there a reason
why this shouldn't be possible?

-- 
Vojtech Pavlik
SuSE Labs

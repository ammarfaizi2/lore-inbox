Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129866AbQJ0Kxr>; Fri, 27 Oct 2000 06:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129908AbQJ0Kxh>; Fri, 27 Oct 2000 06:53:37 -0400
Received: from office.mandrakesoft.com ([195.68.114.34]:28143 "HELO
	test1.mandrakesoft.com") by vger.kernel.org with SMTP
	id <S129866AbQJ0KxT>; Fri, 27 Oct 2000 06:53:19 -0400
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Martin Mares <mj@suse.cz>, "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Possible critical VIA vt82c686a chip bug (private question)
In-Reply-To: <m3d7gnd31m.fsf@test1.mandrakesoft.com>
	<Pine.LNX.3.95.1001026115039.12337A-100000@chaos.analogic.com>
	<20001026190309.A372@suse.cz>
	<20001027120220.A5741@atrey.karlin.mff.cuni.cz>
	<20001027124947.A476@suse.cz>
From: Yoann Vandoorselaere <yoann@mandrakesoft.com>
Date: 27 Oct 2000 12:58:12 +0200
In-Reply-To: Vojtech Pavlik's message of "Fri, 27 Oct 2000 12:49:47 +0200"
Message-ID: <m38zrablff.fsf@test1.mandrakesoft.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.6
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz> writes:

> On Fri, Oct 27, 2000 at 12:02:20PM +0200, Martin Mares wrote:
> 
> > > So this is not our problem here. Anyway I guess it's time to hunt for
> > > i8259 accesses in the kernel that lack the necessary spinlock, even when
> > > they're not probably the cause of the problem we see here.
> > 
> > BTW what about trying to modify your work-around code to make it
> > attempt to read the timer again? This way we could test whether it was
> > a race condition during timer read or really timer jumping to a bogus
> > value.
> 
> Actually if I don't reprogram the timer (and just ignore the value for
> example), the work-around code keeps being called again and again very
> often (between 1x/minute to 100x/second) after the first failure, even
> when the system is idle.
> 
> When reprogramming, next failure happens only after stressing the system
> again.
> 
> So it's not just a race, the impact of the failure on the chip is
> permanent and stays till it's reprogrammed.

Are you sure there is not an error in the way the 
chipset is programmed ?

-- 
		-- Yoann http://www.mandrakesoft.com/~yoann/
"Programming is a race between programmers, who try and make more and more
idiot-proof software, and universe, which produces more and more remarkable
idiots. Until now, universe leads the race"  -- R. Cook
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

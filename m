Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129089AbQJZUMU>; Thu, 26 Oct 2000 16:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129251AbQJZUMK>; Thu, 26 Oct 2000 16:12:10 -0400
Received: from r109m245.cybercable.tm.fr ([195.132.109.245]:1540 "HELO
	alph.dyndns.org") by vger.kernel.org with SMTP id <S129089AbQJZUL4>;
	Thu, 26 Oct 2000 16:11:56 -0400
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Possible critical VIA vt82c686a chip bug (private question)
In-Reply-To: <20001026190309.A372@suse.cz>
	<Pine.LNX.3.95.1001026134131.13342A-100000@chaos.analogic.com>
	<20001026200220.A492@suse.cz>
From: Yoann Vandoorselaere <yoann@mandrakesoft.com>
Date: 26 Oct 2000 22:11:54 +0200
In-Reply-To: Vojtech Pavlik's message of "Thu, 26 Oct 2000 20:02:20 +0200"
Message-ID: <878zrbl5v9.fsf@alph.dyndns.org>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz> writes:

> On Thu, Oct 26, 2000 at 01:42:29PM -0400, Richard B. Johnson wrote:
> 
> > > > ../drivers/block/ide.c, line 162, on version 2.2.17 does bad things
> > > > to the timer. It writes 0 to the control-word for timer 0. This
> > > > does the following:
> > [Snipped...]
> > >  
> > > Well, at least on 2.4.0-test9, the above timing code is #ifed to
> > > DISK_RECOVERY_TIME > 0, which in turn is #defined to 0 in
> > > include/linux/ide.h.
> > > 
> > > So this is not our problem here. Anyway I guess it's time to hunt for
> > > i8259 accesses in the kernel that lack the necessary spinlock, even when
> > > they're not probably the cause of the problem we see here.
> > 
> > Okay, good.
> 
> Ok, here is a list of places within the kernel that access the PIT
> timer, plus the method of locking (i386 arch only):

[...]

Ok, I just tested if the problem was always present without
the IDE subsystem...

The answer is it is not... so it isn't an IDE problem.

-- 
		-- Yoann http://www.mandrakesoft.com/~yoann/
   An engineer from NVidia, while asking him to release cards specs said :
	"Actually, we do write our drivers without documentation."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

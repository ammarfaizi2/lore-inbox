Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276935AbRJHP30>; Mon, 8 Oct 2001 11:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276938AbRJHP3Q>; Mon, 8 Oct 2001 11:29:16 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:39482 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S276935AbRJHP3G>; Mon, 8 Oct 2001 11:29:06 -0400
To: Pavel Machek <pavel@suse.cz>
Cc: Nicholas Berry <nikberry@med.umich.edu>, root@mauve.demon.co.uk,
        linux-kernel@vger.kernel.org
Subject: Re: Odd keyboard related crashes.
In-Reply-To: <sbbd8e9c.096@mail-02.med.umich.edu>
	<20011007092352.A454@bug.ucw.cz>
From: ebiederman@uswest.net (Eric W. Biederman)
Date: 08 Oct 2001 09:18:02 -0600
In-Reply-To: <20011007092352.A454@bug.ucw.cz>
Message-ID: <m1eloew47p.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> writes:

> Hi!
> 
> > >>> Ian Stirling <root@mauve.demon.co.uk> 10/05/01 05:01AM >>>
> > >I'm running 2.4.10, and the ps/2 keyboard came out of it's socket.
> > 
> > >On plugging back in, all worked fine, until 10 seconds later there was a
> > >crash. (the keyboard worked after being plugged in)
> > >No oops, just a reboot.
> > >Thinking this must just have been a wierd coincidence, after the system
> > >came back up, I tried it again, and again it crashed a few seconds
> afterwards.
> 
> > 
> > >It doesn't seem to want to do this again though.
> > 
> > When the keyboard is powered up (or plugged in), it goes through a self test,
> and reports the status back to the PC. Normally, a start up dialogue takes place
> between the PC and the keyboard at this point.
> 
> > That's fine when you boot your PC, but if you unplug then re-plug the
> keyboard, the PC will be sent data it's really not expecting, and the BIOS will
> be very confused.
> 
> > If you ever want to switch a keyboard between PCs, make sure you leave power
> supplied to it at all times.
> 
> 
> BIOS is not alive enough at the time linux boots. This can't be BIOS
> issue.

Unless the BIOS has some weird power management issues, then it may be almost
impossible to kill.  I had one machine once where the BIOS misreported
it's memory usage, and there wasn't an option to disable power
management.  Then the BIOS and the kernel were both using the top of
memory and weird things happened.

That being said I have seen at least one machine where there was a
crash with hot plugging the keyboard and at the time I figured it was
simply bad hardware that couldn't handle it for some reason.

And unless a BIOS is doing something really strange it shouldn't
touch the keyboard after linux is going.

Eric





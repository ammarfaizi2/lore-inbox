Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262800AbUDGK4x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 06:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbUDGK4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 06:56:53 -0400
Received: from hauptpostamt.charite.de ([193.175.66.220]:14809 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S262800AbUDGK4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 06:56:48 -0400
Date: Wed, 7 Apr 2004 12:56:35 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5: keyboard lockup on a Toshiba laptop
Message-ID: <20040407105635.GO20293@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200404071222.21397.rjwysocki@sisk.pl> <Pine.LNX.4.58.0404071227430.10871@alpha.polcom.net> <20040407103934.GG20293@charite.de> <Pine.LNX.4.58.0404071247120.10871@alpha.polcom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0404071247120.10871@alpha.polcom.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Grzegorz Kulewski <kangur@polcom.net>:
> On Wed, 7 Apr 2004, Ralf Hildebrandt wrote:
> 
> > * Grzegorz Kulewski <kangur@polcom.net>:
> > 
> > > > FYI, I've just had a keyboard lockup on a Toshiba laptop (Satellite 1400-103) 
> > > > with the 2.6.5 kernel.
> > 
> > I've seen the very same on 2.6.5-rc3 as well!
> > Toshiba Satellite Pro 6100
> > 
> > > Was anything in your logs about that?
> > > 
> > > I think that maybe you should disable PREEMPTION.
> > 
> > I see these problems without preemption.
> > 
> > > Or use different distribution than RH9. They often modify gcc and other 
> > > programs, maybe even X - maybe try to compile your kernel on "vanilla" gcc 
> > > 3.3.3. I can give you a shell on computer with Gentoo and working gcc. Or 
> > > change distribution: Gentoo works ok for me and my friends! :-)
> > 
> > Debian
> > 
> > From dmesg:
> > input: AT Translated Set 2 keyboard on isa0060/serio0
> > input: AT Translated Set 2 keyboard on isa0060/serio0
> > input: AT Translated Set 2 keyboard on isa0060/serio0
> > input: AT Translated Set 2 keyboard on isa0060/serio0
> > input: AT Translated Set 2 keyboard on isa0060/serio0
> > input: AT Translated Set 2 keyboard on isa0060/serio0
> 
> Did you see these messages 6 times at once? 

No, I'm quite sure they happen sporadically. See:

# uptime
12:53:58 up 7 days,  4:14,  2 users,  load average: 3.12, 2.46, 1.93

# grep "input: AT Translated Set" syslog
Apr  7 09:19:05 hummus2 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Apr  7 09:19:43 hummus2 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Apr  7 09:19:49 hummus2 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Apr  7 09:35:18 hummus2 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Apr  7 09:35:48 hummus2 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Apr  7 09:39:08 hummus2 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Apr  7 09:43:01 hummus2 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Apr  7 09:56:38 hummus2 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Apr  7 11:14:13 hummus2 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Apr  7 11:28:41 hummus2 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Apr  7 11:35:44 hummus2 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Apr  7 11:36:24 hummus2 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Apr  7 11:47:17 hummus2 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Apr  7 12:38:31 hummus2 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0

> Was it after the boot process ended?

Yes. See above.

> They only appear at boot time for me (just once of course). Maybe
> your keyboard was disconnected or kernel was thinking that it was
> disconnected and connected again?...

Nope. It's a laptop!

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-916
IT-Zentrum Standort Campus Mitte                          AIM.  ralfpostfix

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262286AbREUAqP>; Sun, 20 May 2001 20:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262288AbREUAqF>; Sun, 20 May 2001 20:46:05 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:26632 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S262286AbREUApx>;
	Sun, 20 May 2001 20:45:53 -0400
To: esr@thyrsus.com
Cc: David Woodhouse <dwmw2@infradead.org>,
        Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Background to the argument about CML2 design philosophy
In-Reply-To: <20010518105353.A13684@thyrsus.com> <3B053B9B.23286E6C@redhat.com> <20010518112625.A14309@thyrsus.com> <20010518113726.A29617@devserv.devel.redhat.com> <20010518114922.C14309@thyrsus.com> <8485.990357599@redhat.com> <20010520111856.C3431@thyrsus.com> <15823.990372866@redhat.com> <20010520114411.A3600@thyrsus.com> <16267.990374170@redhat.com> <20010520131457.A3769@thyrsus.com>
From: Jes Sorensen <jes@sunsite.dk>
Date: 21 May 2001 02:45:03 +0200
In-Reply-To: "Eric S. Raymond"'s message of "Sun, 20 May 2001 13:14:57 -0400"
Message-ID: <d3wv7bzg1c.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Eric" == Eric S Raymond <esr@thyrsus.com> writes:

Eric> The first candidates I found were questions associated with
Eric> built-in SCSI and Ethernet on Macintoshes, on the Sun 3 and
Eric> Sun3x, and with built-in facilities on the MVME147 single-board
Eric> computer.  So I wrote derivations that looked like this:

[snip derive rules]

Eric> # These were separate questions in CML1 derive MAC_SCC from MAC
Eric> & SERIAL derive MAC_SCSI from MAC & SCSI derive SUN3_SCSI from
Eric> (SUN3 | SUN3X) & SCSI

Eric> By doing this I killed two birds with one stone -- got rid of
Eric> some holes in Configure.help and (more importantly) moved the
Eric> configuration experience away from low-level, hardware-oriented
Eric> questions towards where I think it ought to be. That is, you
Eric> specify a platform and the services you want and the ruleset
Eric> computes the low-level facilities to be linked in.

And you suddenly imposed decisions on people.

Wether or not you are an expert it is reasonable to expect that you
want to use modules just as it is just as reasonable to expect that
you do not. In some cases you want your Ethernet as a module in some
case you want the low level SCSI driver but not the SCSI mid
layer.

Eric> After some back-and-forthing about the technical facts, several
Eric> things emerged:

Eric> 1. The Mac derivations were half-right.  The MAC_SCC one is good
Eric> but Macs can have either of two different SCSI controllers.  I
Eric> fixed that with help from Ray Knight, who maintains the 68K Mac
Eric> port.

Eric> 2. Nobody had a problem with the SUN3_SCSI derivation.

Did you ever get an ACK on it or no answer?

Eric> 3. The MVME derivations are correct *if* (and only if) you agree
Eric> to ignore the possibility that somebody could want to ignore the
Eric> onboard hardware, plug outboard disk or Ethernet cards into the
Eric> VME-bus connector, and do something like running SCSI-over-ATAPI
Eric> to the outboard device.  (I missed these possibilities when I
Eric> wrote the derivations.)

Or wants to use modules. And yes Aunt Tillie might want to do so, if
the person who sold her her Linux CD provided a bunch of scripts for
packing up things in a specific way.

Eric> The MVME situation is an almost perfect test case, because while
Eric> breaking the assumption behind that derivation is physically
Eric> possible it would be a rather perverse thing to do.  The VME147
Eric> is an old design, dating from 1988; it's long since been
Eric> superseded by MPCxxx SBCs based on the PowerPC that have a
Eric> better processor, lower power consumption, and more on-board
Eric> peripheral hardware.  IDE/ATAPI didn't exist during most of its
Eric> design lifetime, and the only way anyone is ever going to hook
Eric> an outboard device to one of these puppies again is if some
Eric> hacker pulls a dusty one off a shelf for some garage project.

Bzzzzt wrong. The MVME cards are still heavily used in control systems
and similar places. It's the only place where m68k usage is not dying
for real.

Eric> So far, I have to say I'm disappointed in the quality of the
Eric> debate.  Almoist nobody seems to want to think about this
Eric> tradeoff globally, as a systems design issue.  Instead, I'm
Eric> hearing a lot of reflexive chuntering that we have to do things
Eric> a certain way because we've always done them a certain way, and
Eric> who am I to even dare *think* about raising different
Eric> possibilities?

So far the introduction of CML2 has been overly disppointing, from day
one it's been 'I have this great idea and since I think it's great,
you obviously have to think so as well'.

Now I take it the derived rules are still only enforced under the
'novice' option, though you haven't exactly made that clear in the
discussion (nor did you do so when you initially brought it up).

Jes

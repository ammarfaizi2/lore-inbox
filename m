Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132958AbRDSTLg>; Thu, 19 Apr 2001 15:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133005AbRDSTLU>; Thu, 19 Apr 2001 15:11:20 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:9234 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132895AbRDSTKN>; Thu, 19 Apr 2001 15:10:13 -0400
Date: Thu, 19 Apr 2001 12:09:34 -0700 (PDT)
From: Patrick Mochel <mochel@transmeta.com>
To: John Fremlin <chief@bandits.org>
cc: "Acpi-PM (E-mail)" <linux-power@phobos.fachschaften.tu-muenchen.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Next gen PM interface
In-Reply-To: <m24rvkpvjt.fsf@bandits.org>
Message-ID: <Pine.LNX.4.10.10104191206100.7690-100000@nobelium.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > >         (1) Battery status, power status, UPS status polling. It
> > > >         should be possible for lots of processes to do this
> > > >         simultaneously. [That does not prohibit a single process
> > > >         querying the kernel and all the others querying it.]
> > > 
> > > Solution. Have a bunch of procfs or dev nodes each giving info on a
> > > particular power source, like now, but vaguely standardise the output.
> 
> [...]
> 
> > I can see at least two types of events - (forgive the lack of colorful
> > terminology) passive and active. Passive events are simply providing
> > status updates, much like the events described above. These are simply so
> > some UI can notify the user of things like a low battery or detection of
> > an AC adapter. These can be handled in much the same way as described
> > above.
> 
> No they can't. They only happen once. Battery status exists all the
> time.

Yes they can. My point was they can be handled from userspace in the same
way that battery status does - by doing a select on a file in /proc or
/dev. Once in a while (or constantly) they get data from the kernel -
battery status, AC change, etc - that can be then translated and displayed
in the UI.

	-pat


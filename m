Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263060AbSJGOGR>; Mon, 7 Oct 2002 10:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263062AbSJGOGR>; Mon, 7 Oct 2002 10:06:17 -0400
Received: from bohnice.netroute.lam.cz ([212.71.169.62]:50429 "EHLO
	vagabond.cybernet.cz") by vger.kernel.org with ESMTP
	id <S263060AbSJGOGQ>; Mon, 7 Oct 2002 10:06:16 -0400
Date: Mon, 7 Oct 2002 16:11:22 +0200
From: Jan Hudec <bulb@ucw.cz>
To: Oliver Neukum <oliver@neukum.name>
Cc: Helge Hafting <helgehaf@aitel.hist.no>,
       "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 - (NUMA))
Message-ID: <20021007141122.GA14423@vagabond>
Mail-Followup-To: Jan Hudec <bulb@ucw.cz>,
	Oliver Neukum <oliver@neukum.name>,
	Helge Hafting <helgehaf@aitel.hist.no>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel@vger.kernel.org
References: <m17yCIx-006hSwC@Mail.ZEDAT.FU-Berlin.DE> <1281002684.1033892373@[10.10.2.3]> <3DA140ED.6512D1A1@aitel.hist.no> <m17yUp7-006fgcC@Mail.ZEDAT.FU-Berlin.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m17yUp7-006fgcC@Mail.ZEDAT.FU-Berlin.DE>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2002 at 11:18:44AM +0200, Oliver Neukum wrote:
> On Monday 07 October 2002 10:08, Helge Hafting wrote:
> > "Martin J. Bligh" wrote:
> > > > Then there's the issue of application startup. There's not enough
> > > > read ahead. This is especially sad, as the order of page faults is
> > > > at least partially predictable.
> > >
> > > Is the problem really, fundamentally a lack of readahead in the
> > > kernel? Or is it that your application is huge bloated pig?
> >
> > Often the latter.  People getting interested in linux
> > seems to believe that openoffice is the msoffice replacement,
> > and that _is_ a huge bloated pig.  It needs 50M to start
> > the text editor - and lots of _cpu_.  It takes a long time
> > to start on a 266MHz machine even when the disk io
> > is avoided by the pagecahce.
> 
> OpenOffice _is_ an important application, whether we like it or not.
> 
> How does one measure and profile application startup other than with
> a stopwatch ? I'd like to gather some objective data on this.

Add some debuging output to the program (mainly at the very begining of
main) and then launch it with simple program that will note time right
before it forks and then wait for the application to output something
(which should be the debuging write at the start od main) and note time
it returned from select.

> > A snappy desktop is trivial with 2.5, even with a slow machine.
> > Just stay away from gnome and kde, use a ugly fast
> 
> A desktop machine needs to run a desktop enviroment. Only a window manager is 
> not enough.

Please, could someone explain to me, what is desktop enviroment in
addition to window manager and horde of libraries for UI and IPC.

(No, panel is not important thing and even if it were, it's a simple
fast application, providing it's implemented sanely (I mean, gnome panel
is currently buggy))

> > window manager like icewm or twm (and possibly lots
> > of others I haven't even heard about.)
> > X itself is snappy enough, particularly with increased
> > priority.
> > Take some care when selecting apps (yes - there is choice!)
> > and the desktop is just fine.  Openoffice is a nice
> > package of programs, but there are replacements for most
> > of them if speed is an issue.  If the machine is powerful
> > enough to run ms software snappy then speed probably
> > isn't such a big issue though.
> 
> KDE and friends _are_ not quite optimised for speed. That however doesn't 
> mean that the kernel should not make an effort to allow them to run as fast 
> as they can.

No, it does not.

-------------------------------------------------------------------------------
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

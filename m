Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135612AbREBQNl>; Wed, 2 May 2001 12:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135617AbREBQNc>; Wed, 2 May 2001 12:13:32 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:18443 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135612AbREBQNW>; Wed, 2 May 2001 12:13:22 -0400
From: "H. Peter Anvin" <hpa@transmeta.com>
Message-ID: <3AF03213.5613E21A@transmeta.com>
Date: Wed, 02 May 2001 09:13:07 -0700
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Maximum files per Directory
In-Reply-To: <272800000.988750082@hades> <E14uhI2-0002NH-00@the-village.bc.nu> <9cnbs0$uk3$1@cesium.transmeta.com> <20010502122250.J3305@nightmaster.csn.tu-chemnitz.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser wrote:
> 
> On Tue, May 01, 2001 at 03:03:44PM -0700, H. Peter Anvin wrote:
> > > Bit of both. You exceeded the max link count, and your
> > > performance would have been abominable too. cyrus should be
> > > using heirarchies of directories for very large amounts of
> > > stuff.
> Right.
> 
> > But also showing, once again, that this particular scalability problem
> > really is a headache for some people.
> 
> If you do ls on that directory as an admin, you'll see, what the
> REAL cause of this headache is:
> 
>             The application doing such stupid thing!
> 
> People (writing applications) building up such large directories
> should be forced to read every entry of it aloud.
> 
> Then they'll learn[1] and the problem is solved.
> 

"Violence is the last refuge of the incompetent."

Seriously, I don't buy this "the application is doing something stupid." 
The application is using the VFS the way it is advertised to work.  If
you think doing ls on an extrememly large directory is painful, you have
never seen the droppings of an application which tries to do
load-balancing between directories by doing real hashing.  THAT is
painful!  At least in the first case you can use grep.

The only ones we fool by repeating the mantra "stupid admin, stupid
application" is ourselves.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt

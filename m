Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129156AbRBWRS3>; Fri, 23 Feb 2001 12:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129164AbRBWRSK>; Fri, 23 Feb 2001 12:18:10 -0500
Received: from sportingbet.gw.dircon.net ([195.157.147.30]:60420 "HELO
	sysadmin.sportingbet.com") by vger.kernel.org with SMTP
	id <S129156AbRBWRSE>; Fri, 23 Feb 2001 12:18:04 -0500
Date: Fri, 23 Feb 2001 17:14:40 +0000
From: Sean Hunter <sean@dev.sportingbet.com>
To: Matt Johnston <mlkm@caifex.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: random PID generation
Message-ID: <20010223171440.K10620@dev.sportingbet.com>
Mail-Followup-To: Sean Hunter <sean@dev.sportingbet.com>,
	Matt Johnston <mlkm@caifex.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <27525795B28BD311B28D00500481B7601F0F02@ftrs1.intranet.ftr.nl> <01022323403700.00325@box.caifex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01022323403700.00325@box.caifex.org>; from mlkm@caifex.org on Fri, Feb 23, 2001 at 11:40:37PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have already written a 2.2 implementation which does not suffer from these
problems.  It was rejected because Alan Cox (and others) felt it only provided
security through obscurity.

Sean

On Fri, Feb 23, 2001 at 11:40:37PM +0800, Matt Johnston wrote:
> OpenBSD has a working implementation, might be worth looking at???
> 
> Cheers,
> Matt Johnston.
> 
> On Fri, 23 Feb 2001 23:34, Heusden, Folkert van wrote:
> > >> My code runs trough the whole task_list to see if a chosen pid is
> > >> already
> > >>
> > >> in use or not.
> > >
> > > But it doesn't check for a recently used PID. Lets say your system is
> > > exhausting 1000 PIDs/second, and that there is a window of 20ms between
> >
> > you
> >
> > > determining which PID to send to, and the recipient process receiving it.
> >
> > Ah, I get your point. Good point :o)
> >
> > I was thinking: I could split the PIDs up in 2...16383 and 16384-32767 and
> > then
> > switch between them when a process ends? nah, that doesn't help it.
> > hmmm.
> > I think random increments (instead of last_pid+1) would be the best thing
> > to do then?
> >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

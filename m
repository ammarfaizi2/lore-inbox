Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278646AbRJSUOv>; Fri, 19 Oct 2001 16:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278647AbRJSUOm>; Fri, 19 Oct 2001 16:14:42 -0400
Received: from toscano.org ([64.50.191.142]:38366 "HELO bubba.toscano.org")
	by vger.kernel.org with SMTP id <S278646AbRJSUOa>;
	Fri, 19 Oct 2001 16:14:30 -0400
Date: Fri, 19 Oct 2001 16:15:03 -0400
From: Pete Toscano <pete.lkml@toscano.org>
To: linux-kernel@vger.kernel.org
Subject: Re: USB stability - possibly printer related
Message-ID: <20011019161503.A24088@bubba.toscano.org>
Mail-Followup-To: Pete Toscano <pete.lkml@toscano.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <1003518067.16964.22.camel@cr156960-a> <AHEMIKPKMHEEJBKHLIGHEEFGCAAA.stano@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AHEMIKPKMHEEJBKHLIGHEEFGCAAA.stano@meduna.org>
User-Agent: Mutt/1.3.20i
X-Unexpected: The Spanish Inquisition
X-Uptime: 4:09pm  up 5 days, 23:04,  7 users,  load average: 0.00, 0.00, 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've heard others (Alan Cox?) say that the USB subsystem was not
entirely MP safe.  I saw similar problems with my SMP system.  Usually,
it'd lock just after printing a few lines.  If I let the system sit for
a while without rebooting, it'd start printing "random" parts of files.
(I'm guessing that these parts are not random at all, but I don't know
how they relate... maybe location on disk..?  Anyway...)  My guess is
that some pointer to the location of the data to send to the printer
gets mucked with and it sends the kernel off to never-never land... Just
a guess as I've gone back to a UP system.

pete

On Fri, 19 Oct 2001, Stanislav Meduna wrote:

> Hi,
> 
> > I have not had time to risk killing my system again but
> > it appears to be either related to postscript printing
> > or the lm_sensors modules. Do you by chance use lm_sensors?
> 
> No, I don't.
> 
> > I am pretty sure I can make it happen again but I don't have
> > the time to reinstall my system right now...
> 
> I can experiment, provided that only the mounted partitions
> can be hosed this way. But if this is some memory corruption,
> maybe anything could go wrong...
> 
> > > - I got a corruption of the files that were surely _not_
> > >   opened for writing.
> > 
> > Here too. Many system libs were corrupted. When fsck tried
> > to repair the file system it spewed all kinds of errors
> > about libs.
> 
> Kernel gurus: it seems this is a common symptom. Could someone
> give some explanation/speculation, what mechanismus can lead
> to this kind of corruption (not necessarily related to USB)?
> 
> Regards
> -- 
>                                    Stano

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313811AbSDIHk1>; Tue, 9 Apr 2002 03:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313813AbSDIHk0>; Tue, 9 Apr 2002 03:40:26 -0400
Received: from [62.245.135.174] ([62.245.135.174]:27558 "EHLO mail.teraport.de")
	by vger.kernel.org with ESMTP id <S313811AbSDIHkZ>;
	Tue, 9 Apr 2002 03:40:25 -0400
Message-ID: <3CB29AE3.E3447952@TeraPort.de>
Date: Tue, 09 Apr 2002 09:40:19 +0200
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Reply-To: m.knoblauch@TeraPort.de
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.19-pre5-ac3 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [swsusp fixes] Re: Linux 2.4.19pre5-ac3
In-Reply-To: <3CB1B89D.13DDF456@TeraPort.de> <20020408215908.GI31172@atrey.karlin.mff.cuni.cz>
X-MIMETrack: Itemize by SMTP Server on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 04/09/2002 09:40:19 AM,
	Serialize by Router on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 04/09/2002 09:40:25 AM,
	Serialize complete at 04/09/2002 09:40:25 AM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> 
> Hi!
> 
> > > +
> > > +You have two ways to use this code. The first one is if you've compiled in
> > > +sysrq support then you may press Sysrq-D to request suspend. The other way
> > > +is with a patched SysVinit (my patch is against 2.76 and available at my
> > > +home page). You might call 'swsusp' or 'shutdown -z <time>'.
> > > +
> > > +Either way it saves the state of the machine into active swaps and then
> > > +reboots. By the next booting the kernel's resuming function is either triggered
> > > +by swapon -a (which is ought to be in the very early stage of booting) or you
> > > +may explicitly specify the swap partition/file to resume from with ``resume=''
> > > +kernel option. If signature is found it loads and restores saved state. If the
> >
> >  Does it have to be an "active swap partition"? What about systems
> > without active swap, but space enough for a partition?
> 
> There you just make it partition and then mkswap/swapon it. Or did I
> misunderstand the question?
>                                                                 Pavel
Pavel,

 maybe I was unclear. For reasons of interactivity, I do not have any
swap enabled on my Notebook. The 320 MB are enough for my workload and I
am willing to accept the OOM Killer when I do really stupid things. If I
enable swap the (all of them to some degree :-) VM decides to swap out
"unused" processes. Most of them are desktop related and if I need them
the system responds sluggish. Therefore - no swap activated.

 My question was: can I have a system without active swap and still use
swsusp? Creating a swap/suspend partition of appropriate size is not a
problem. I just do not want to "swapon" it.

Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759

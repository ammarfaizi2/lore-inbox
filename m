Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261956AbREZQdR>; Sat, 26 May 2001 12:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261889AbREZQdH>; Sat, 26 May 2001 12:33:07 -0400
Received: from crunchy.sound.net ([205.242.194.25]:13211 "HELO
	crunchy.sound.net") by vger.kernel.org with SMTP id <S261956AbREZQcy>;
	Sat, 26 May 2001 12:32:54 -0400
Message-ID: <3B0FC26B.D210E416@sound.net>
Date: Sat, 26 May 2001 09:49:16 -0500
From: A Duston <hald@sound.net>
X-Mailer: Mozilla 4.77 [en] (Win98; U)
X-Accept-Language: en,el
MIME-Version: 1.0
To: "Axboe, Jens" <axboe@suse.de>
CC: "Gortmaker, Paul" <p_gortmaker@yahoo.com>,
        "Andersen, Rasmus" <rasmus@jaquet.dk>, linux-kernel@vger.kernel.org
Subject: Re: PS/2 Esdi patch #8
In-Reply-To: <Pine.GSO.4.10.10105231748550.23376-200000@sound.net> <3B0D733F.1829DC88@yahoo.com> <20010525164615.C14899@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

> On Thu, May 24 2001, Paul Gortmaker wrote:
> > Hal Duston wrote:
> >
> > > http://www.sound.net/~hald/projects/ps2esdi/ps2esdi-2.4.4-patch4
> > >
> > > Hal Duston
> > > hald@sound.net
> >
> > You PS/2 ESDI guys might want to set the max sectors for your
> > driver - old default used to be 128, currently 255 (which maybe
> > hardware can handle ok?) - the xd and hd drivers were broken until
> > a similar fix was added to them.
> >
> > Probably makes sense for driver to set it regardless, seeing
> > as default (MAX_SECTORS) has changed several times over last
> > few months.  At least then it will be under driver control
> > and not at the mercy of some global value.
>
> You might want to assign that max_sect array too, otherwise it's just
> going to waste space :-)
>
> Take a look at how ps2esdi handles requests -- always processing just
> the first segment. Alas, it doesn't matter how big the request is.

OK, obviously I am still missing something here from when I got the
driver booting again.  Presumably something with current_nr_sectors,
vs nr_sectors, maybe?  I thought it was odd that all the transfers were
exactly 2 blocks. I'll go ahead and take this one.  I will also go ahead
and check to see how much data the hardware can transfer at once
as well, but I expect it is quite a bit.  I am still working on getting a

group of folks to test patch #5 to see if it works as well.  Anyone
with appropriate hardware willing to test can contact me.  All I have
access to is my thinkpad 700 PS/2, and a 50Z that is a 286.

Thanks,
Hal Duston
hald@sound.net


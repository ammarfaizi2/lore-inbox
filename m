Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267295AbRHAO7a>; Wed, 1 Aug 2001 10:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266381AbRHAO7U>; Wed, 1 Aug 2001 10:59:20 -0400
Received: from unthought.net ([212.97.129.24]:2228 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S267295AbRHAO7O>;
	Wed, 1 Aug 2001 10:59:14 -0400
Date: Wed, 1 Aug 2001 16:59:07 +0200
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Roger Abrahamsson <hyperion@gnyrf.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: resizing of raid5?
Message-ID: <20010801165907.A1293@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Neil Brown <neilb@cse.unsw.edu.au>,
	Roger Abrahamsson <hyperion@gnyrf.net>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <996657922.3b67cb02ba717@stargate.gnyrf.net> <15207.63232.611617.37794@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <15207.63232.611617.37794@notabene.cse.unsw.edu.au>; from neilb@cse.unsw.edu.au on Wed, Aug 01, 2001 at 10:33:04PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2001 at 10:33:04PM +1000, Neil Brown wrote:
> On Wednesday August 1, hyperion@gnyrf.net wrote:
> > Hello.
> > 
> > Just figured if anyone could give some information about resizing of software
> > raid5 systems (2.4.x kernels)? I've been looking all over for information about
> > if this is possible or not currently, and if not, how this system of raid
> > cluster blocks work in conjunction with ext2. The code is a bit tricky and not
> > too many comments to help one try and get a hold of how it works.
> > Any pointers for this would be nice.
> 
> The only way to resize a raid5 array is to back up, rebuild, and
> re-load.  Any attempt to re-organise the data, or the linkage, to
> avoid this would be more trouble that it is worth.

Well, yes and no.

I wrote a resizing tool for raid0 (this is code "A").  I later re-wrote that code
so that it could convert between raid-levels, and do resizing of those levels too
(this is code "B").

However, code "B" was never finished, it had some serious bugs.  Code "A" has
been "mostly stable" (meaning, users and myself have resized several hundred
gigabytes of RAID-0, and I only know of one array that has been trashed).

Now, code "A" was shipped to one company - they re-wrote it to do RAID-5
resizing.

Code "B" was shipped to another company - they fixed the bugs.

Somewhere out there, there should be a tool that will do not only resizing of
the raid levels, but also conversion between them.  It's GPL, it's based on my
code, but I haven't seen it yet   :)

I have not had the changes back from any of those two companies - but this is
mainly because I've been too busy to care.  They seem to intend to release the
changes (after all, my code was GPL),  and I'm going to follow up on this when
I'm done with my thesis - which will be about in a month from now.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:

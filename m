Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317232AbSEXSEB>; Fri, 24 May 2002 14:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317233AbSEXSEB>; Fri, 24 May 2002 14:04:01 -0400
Received: from [209.184.141.163] ([209.184.141.163]:11236 "HELO UberGeek")
	by vger.kernel.org with SMTP id <S317232AbSEXSD7>;
	Fri, 24 May 2002 14:03:59 -0400
Subject: Re: [BUG] 2.4 VM sucks. Again
From: Austin Gonyou <austin@digitalroadkill.net>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org
In-Reply-To: <433620000.1022262234@flay>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 24 May 2002 13:03:54 -0500
Message-Id: <1022263434.9591.60.camel@UberGeek>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-05-24 at 12:43, Martin J. Bligh wrote:
> > I assume that you mean by "not worth using x86" you're referring to say,
> > degraded performance over other platforms? Well...if you talk
> > price/performance, using x86 is perfect in those terms since you can buy
> > more boxes and have a more fluid architecture, rather than building a
> > monolithic system. Monolithic systems aren't always the best. Just look
> > at Fermilab!
> 
> Well, to be honest, with the current mainline kernel on >4Gb x86 machines,
> we're not talking about slow performance on mainline kernel, we're talking
> about "falls flat on it's face, in a jibbering heap" (if you actually stress the
> machine with real workloads). If we apply a bunch of patches, we can get 
> the ostritch to just about fly (most of the time), but we're working towards good 
> performance too ... it's not that far off. 

Understood, I think that's everyone's goal in the end anyway.

> Of course, this means that we actually have to get these patches accepted
> for them to be of much use ;-). -aa kernel works best in this area, on the 
> workloads I've been looking at so far ... this area is very much "under active
> development" at the moment.
> 
> M.

Yes, After using a -AA series, then recompiling Glibc with some
optimizations, kind of re-purifying the system a few times. 
Then applying some Oracle patches, (to fix some Oracle bugs in our
environment) then voila!  We can have a *very* fast Linux box on 4P or
8P with 4-8GB RAM with an uptime of >60 days. I've never a box longer
than that to prove otherwise, but it was stable from a *production*
point of view. 

Also, adjusting the bdflush parms greatly increases stability I've found
in this respect. On top of all of that though, using XFS with increased
logbuffers and LVM or EVMS to do striping really improved performance
with IO too. 

Problem is, my tests are *unofficial* but I plan to do something perhaps
at OSDL and see what we can show in a max single-box config with real
hardware, etc. 

Anyway, I digress. 

Austin

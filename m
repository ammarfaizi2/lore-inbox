Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbWIORrH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWIORrH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 13:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbWIORrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 13:47:07 -0400
Received: from chain.digitalkingdom.org ([64.81.49.134]:32132 "EHLO
	chain.digitalkingdom.org") by vger.kernel.org with ESMTP
	id S932127AbWIORrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 13:47:05 -0400
Date: Fri, 15 Sep 2006 10:47:01 -0700
To: Bharath Ramesh <krosswindz@gmail.com>
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
Subject: Re: Same MCE on 4 working machines (was Re: Early boot hang on recent 2.6 kernels (> 2.6.3), on x86-64 with 16gb of RAM)
Message-ID: <20060915174701.GN4610@chain.digitalkingdom.org>
References: <20060912223258.GM4612@chain.digitalkingdom.org> <20060914190548.GI4610@chain.digitalkingdom.org> <1158261249.7948.111.camel@mindpipe> <20060914191555.GJ4610@chain.digitalkingdom.org> <c775eb9b0609142242r45d184d2h8d7edd7dd5bc2a26@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c775eb9b0609142242r45d184d2h8d7edd7dd5bc2a26@mail.gmail.com>
User-Agent: Mutt/1.5.12-2006-07-14
From: Robin Lee Powell <rlpowell@digitalkingdom.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't know about mce=bootlog.  Neat.  It doesn't change anything,
though.  I've tried noacpi and many variants thereon; no change.

The most severe set of options I have record of trying is:

nosmp noapic mem=512M ide=nodma apm=off acpi=off desktop showopts

but there were lots of others.

mce=nobootlog doesn't help either, for the record.

If mce=bootlog actually sticks logs somewhere I should retrieve and
show to you, please tell me; ./Documentation/x86_64/boot-options.txt
doesn't say anything about it.

-Robin

On Fri, Sep 15, 2006 at 01:42:49AM -0400, Bharath Ramesh wrote:
> Have you tried booting newer kernel post 2.6.13 with the boot
> option mce=bootlog and see if it goes past the current failure.
> Try the same with with noacpi.
> 
> Bharath
> 
> On 9/14/06, Robin Lee Powell <rlpowell@digitalkingdom.org> wrote:
> >On Thu, Sep 14, 2006 at 03:14:08PM -0400, Lee Revell wrote:
> >> On Thu, 2006-09-14 at 12:05 -0700, Robin Lee Powell wrote:
> >> > This isn't just me.  All the Debian kernels hang too.  I've tried
> >> > all of the following:
> >> >
> >> > Linux version 2.6.8-12-amd64-generic (buildd@bester) (gcc version
> >> > 3.4.4 20050314 (prerelease) (Debian 3.4.3-13)) #1 Mon Jul 17 01:12:05
> >> > UTC 2006
> >> >
> >> > Linux version 2.6.8-12-amd64-k8 (buildd@bester) (gcc version 3.4.4
> >> > 20050314 (prerelease) (Debian 3.4.3-13)) #1 Mon Jul 17 01:39:03 UTC
> >> > 2006
> >> >
> >> > Linux version 2.6.8-12-amd64-k8-smp (buildd@bester) (gcc version 3.4.4
> >> > 20050314 (prerelease) (Debian 3.4.3-13)) #1 SMP Mon Jul 17 00:17:20
> >> > UTC 2006
> >>
> >> Have you tried a *recent* 2.6 kernel like 2.6.17 or 2.6.18-rc*?
> >>
> >> 2.6.8 is way too old to debug.
> >
> >Yes; that's what my previous post was about.  See
> >http://lkml.org/lkml/2006/9/12/300
> >
> >I was doing 2.6.17.11, which was kernel.org's latest stable at the
> >time I started all this.
> >
> >I tried the Debian kernels just to show that it wasn't just me
> >screwing up my kernel configs.
> >
> >These machines will not boot an any kernel > 2.6.3 that I have
> >tried, and I've tried about 8 different ones at this point.
> >
> >I noted in the release notes for 2.6.4 that the mce code was
> >entirely replaced; I'm suspecting that's the problem, but I have no
> >idea how to debug it.  Whether the problem is the kernel or the
> >motherboard is also certainly open to debate.
> >
> >-Robin
> >
> >--
> >http://www.digitalkingdom.org/~rlpowell/ *** http://www.lojban.org/
> >Reason #237 To Learn Lojban: "Homonyms: Their Grate!"
> >Proud Supporter of the Singularity Institute - http://singinst.org/
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> >

-- 
http://www.digitalkingdom.org/~rlpowell/ *** http://www.lojban.org/
Reason #237 To Learn Lojban: "Homonyms: Their Grate!"
Proud Supporter of the Singularity Institute - http://singinst.org/

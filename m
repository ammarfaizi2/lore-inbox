Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263999AbTCWX4K>; Sun, 23 Mar 2003 18:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264000AbTCWX4K>; Sun, 23 Mar 2003 18:56:10 -0500
Received: from smtp08.iddeo.es ([62.81.186.18]:4345 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id <S263999AbTCWX4J>;
	Sun, 23 Mar 2003 18:56:09 -0500
Date: Mon, 24 Mar 2003 01:07:13 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, James Bourne <jbourne@mtroyal.ab.ca>,
       linux-kernel@vger.kernel.org, Robert Love <rml@tech9.net>,
       Martin Mares <mj@ucw.cz>, Alan Cox <alan@redhat.com>,
       Stephan von Krawczynski <skraw@ithnet.com>, szepe@pinerecords.com,
       arjanv@redhat.com, Pavel Machek <pavel@ucw.cz>
Subject: Re: Ptrace hole / Linux 2.2.25
Message-ID: <20030324000713.GA17795@werewolf.able.es>
References: <20030323195606.GA15904@atrey.karlin.mff.cuni.cz> <1048450211.1486.19.camel@phantasy.awol.org> <402760000.1048451441@[10.10.2.4]> <20030323203628.GA16025@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.51.0303231410250.17155@skuld.mtroyal.ab.ca> <920000.1048456387@[10.10.2.4]> <3E7E335C.2050509@pobox.com> <1240000.1048460079@[10.10.2.4]> <3E7E4486.8080302@pobox.com> <6850000.1048463137@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <6850000.1048463137@[10.10.2.4]>; from mbligh@aracnet.com on Mon, Mar 24, 2003 at 00:45:38 +0100
X-Mailer: Balsa 2.0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.24, Martin J. Bligh wrote:
> >> O(1) sched may be a bad example ... how about the fact that mainline VM
> >> is totally unstable? Witness, for instance, the buffer_head stuff. Fixes
> >> for that have been around for ages. 
> > 
> > "totally unstable" being defined as:  My computers don't crash, and my
> > 100%-mainline test kernels pass various Cerberus/LTP/crashme runs.
> > 
> > Of course, I am not totally focused on multi-million-dollar computers, so
> > maybe my perspective is skewed...  ;-)
> 
> Last time I checked, a 2x machine with 4Gb of RAM didn't cost millions of
> dollars ;-)
> 
> > Fixes should be applied to 2.4-mainline, certainly.  Anything else just
> > wastes developer brain cycles and slows the move to 2.6.
> 
> Common vendor _features_ is maybe better done in a separate tree, I'd
> accept ... I'm just frustrated with the current lack of commonality between
> distros, I guess.
> 

You will never get distros to follow that. A 'featured-kernel-for-distro'...
Just take RH and SuSE (correct me if I'm wrong...)
RH ships -ac. SuSE ships -aa. At least both (-ac and -aa) have O(1) scheduler
now. -ac ships rmap, -aa ships -aa (;)). That means O(1) goes in your kernel,
but how about the VM subsystem ? 

But now that -ac does not include rmap, perhaps the VM can be chosen as the
one from Andrea...

(BTW, I have been runnin plan -pres for a couple of weeks, and now that I run
-aa again, my computer looks like a new one...)

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Bamboo) for i586
Linux 2.4.21-pre5-jam1 (gcc 3.2.2 (Mandrake Linux 9.1 3.2.2-3mdk))

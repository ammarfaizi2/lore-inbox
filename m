Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267431AbUJBRuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267431AbUJBRuf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 13:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267438AbUJBRue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 13:50:34 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:21940 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267431AbUJBRu3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 13:50:29 -0400
Date: Sat, 2 Oct 2004 10:47:02 -0700
From: Paul Jackson <pj@sgi.com>
To: "Marc E. Fiuczynski" <mef@CS.Princeton.EDU>
Cc: akpm@osdl.org, nagar@watson.ibm.com, ckrm-tech@lists.sourceforge.net,
       efocht@hpce.nec.com, mbligh@aracnet.com, lse-tech@lists.sourceforge.net,
       hch@infradead.org, steiner@sgi.com, jbarnes@sgi.com,
       sylvain.jeaugey@bull.net, djh@sgi.com, linux-kernel@vger.kernel.org,
       colpatch@us.ibm.com, Simon.Derr@bull.net, ak@suse.de, sivanich@sgi.com,
       llp@CS.Princeton.EDU
Subject: Re: [ckrm-tech] Re: [Lse-tech] [PATCH] cpusets - big numa cpu and
 memory placement
Message-Id: <20041002104702.4c68daf9.pj@sgi.com>
In-Reply-To: <NIBBJLJFDHPDIBEEKKLPCEFLCHAA.mef@cs.princeton.edu>
References: <20041001164118.45b75e17.akpm@osdl.org>
	<NIBBJLJFDHPDIBEEKKLPCEFLCHAA.mef@cs.princeton.edu>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc writes:
>
> For PlanetLab (www.planet-lab.org) we also care very much about isolation
> between different users.  Maybe not to the same degree as your users.
> Nonetheless, penning in resource hogs is very important to us. 

Thank-you for your report, Marc.

Before I look at code, I think we could do with a little more
discussion of usage patterns and requirements.

Despite my joke about "1) isolation, 2) isolation, and 3) isolation"
being the most important requirements on cpusets, there are further
requirements presented by typical cpuset users, which I tried to spell
out in my previous post.

Could you do a couple more things to further help this discussion:

 1) I know nothing at this moment of what PlanetLab is or what
    they do.  Could you describe this a bit - your business, your
    customers usage patterns and how these make use of CKRM?  Perhaps
    a couple of web links will help here.  I will also do a Google
    search now, in an effort to become more educated on PlanetLab.

    I might come away from this thinking one of:

	a. Dang - that sounds alot like what my cpuset users are
	   doing.  If CKRM meets PlanetLab's needs, it might meet
	   my users needs too.  I should put aside my skepticism
	   and approach Andrew's proposal to have CKRM supplant
	   cpusets with a more open mind than (I will confess)
	   I have now.

	b. No, no - that's something different.  PlanetLab doesn't
	   have the particular requirements x, y and z that my cpuset
	   users do.  Rather they have other requirements, a, b and
	   c, that seem to fit my understanding of CKRM well, but
	   not cpusets.

 2) I made some effort to present the usage patterns and
    requirements of cpuset users in my post.  Could you read
    it and comment on the requirements I presented. 

    I'd be interested to know, for each cpuset requirement I
    presented, which of the following multiple choices applies
    in your case:

	a. Huh - I (Marc) don't understand what you (pj) are
           saying here well enough to comment further.

	b. Yes - this sounds just like something PlanetLab needs,
	   perhaps rephrasing the requirement in terms more familiar
	   to you.  And CKRM meets this requirement this way ...

	c. No - this is not a big need PlanetLab has of its resource
	   management technology (perhaps noting in this case,
	   whether, in your understanding of CKRM, CKRM addresses
	   this requirement anyway, even though you don't need it).

I encourage you to stay "down to earth" in this, at least initially.
Speak in terms familiar to you, and present the actual, practical
experience you've gained at PlanetLab.

I want to avoid the trap of premature abstraction:

    Gee - both CKRM and cpusets deal with resource management, both
    have kernel hooks in the allocators and schedulers, both have
    hierarchies and both provide isolation of some sort.  They must
    be two solutions to the same problem (or at least, since CKRM
    is obviously bigger, it must be a solution to a superset of
    the problems that cpusets addresses), and so we should pick one
    (the superset, no doubt) and drop the other to avoid duplication.

Let us begin this discussion with a solid grounding in the actual
experiences we bring to this thread.

Thank-you.

	"I'm thinking of a 4 legged, long tailed, warm blooded
	creature, commonly associated with milk, that makes a
	sound written in my language starting with the letter 'M'.
	The name of the animal is a three letter word starting
	with the letter 'C'.  We had many of them in the barn on
	my Dad's dairy farm."

	Mooo ?		[cow]

	No - meow.	[cat]

	And no, we shouldn't try to catch mice with cows, even
	if they are bigger than cats.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373

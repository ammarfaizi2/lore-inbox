Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315440AbSEQNLM>; Fri, 17 May 2002 09:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315441AbSEQNLL>; Fri, 17 May 2002 09:11:11 -0400
Received: from ns.suse.de ([213.95.15.193]:16145 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S315440AbSEQNLL>;
	Fri, 17 May 2002 09:11:11 -0400
Date: Fri, 17 May 2002 15:11:10 +0200
From: Dave Jones <davej@suse.de>
To: Miles Lane <miles@megapathdsl.net>
Cc: Tomas Szepe <szepe@pinerecords.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel - take 3
Message-ID: <20020517151110.A4712@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Miles Lane <miles@megapathdsl.net>,
	Tomas Szepe <szepe@pinerecords.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <3038.1021588938@ocs3.intra.ocs.com.au> <Pine.LNX.4.44.0205162003360.4117-100000@xanadu.home> <20020517033056.GB4595@louise.pinerecords.com> <1021624966.10049.780.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2002 at 01:42:44AM -0700, Miles Lane wrote:
 > Along the same lines, we have James Bottomly attempting to 
 > get support for the NCR Voyager architecture added to the
 > kernel.  His original submission post was sent 2001-12-23:
 > http://marc.theaimsgroup.com/?l=linux-kernel&m=100913508007485&w=2
 > The latest submission attempt was sent 2002-05-11:
 > http://marc.theaimsgroup.com/?l=linux-kernel&m=102115570805131&w=2

The best solution for niche x86 architectures is to get x86-subarch
support merged first (See how arch/arm is laid out for an example)
James also has patches to do this, but there are a few other bits
pending in this area right now, such as Patrick Mochels work to split
up some of the larger parts. The bigger chunk of this is in my tree,
and has proven to be ok, so I'm pushing that to Linus sometime real
soon.

With that out of the way, the only remaining work in that area
is of small enough scale (apart from ACPI perhaps) that merging
the subarch support should be a logical progression.
And with that merged, things like Voyager, NUMAQ, and other weirdo
x86en can follow on without disrupting any of the common x86 code
that 99.9% of people will be running.

So it's not being ignored, it's just that trying to fit together
a puzzle whilst all the players want to put a piece in the same
place needs an element of coordination.

    Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

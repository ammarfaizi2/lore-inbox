Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280052AbRKDXjz>; Sun, 4 Nov 2001 18:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280051AbRKDXjp>; Sun, 4 Nov 2001 18:39:45 -0500
Received: from unthought.net ([212.97.129.24]:5593 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S280041AbRKDXjk>;
	Sun, 4 Nov 2001 18:39:40 -0500
Date: Mon, 5 Nov 2001 00:39:39 +0100
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Craig Thrall <cthrall@raindance.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Message-ID: <20011105003939.A14001@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Craig Thrall <cthrall@raindance.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <8E3BD6C91C42EC44AF5BEE87C73F9CBC0DB135@mail8-bld.lsv.raindance.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <8E3BD6C91C42EC44AF5BEE87C73F9CBC0DB135@mail8-bld.lsv.raindance.com>; from cthrall@raindance.com on Sun, Nov 04, 2001 at 04:06:25PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 04, 2001 at 04:06:25PM -0700, Craig Thrall wrote:
> > Problem:  Could it be made simpler to parse from scripting languages,
> > without making it less elegant to parse in plain C ?
> 
> Yes.  At one point, somebody suggested XML.  Now, as much as I hate the fact
> that people somehow equate high-tech with tags, I think whomever originally
> suggested it might be on to something.  :)
> 
> Fact is, just about EVERY language out there has some sort of utility to
> parse XML.  There's expat for C, Perl and Python have libs, etc.  We could
> even write a proc DTD that could specify the valid data types.

I would say that it's "less elegant" to have to depend on yet another (big, 
complex, still evolving) library just to read out system metrics.

> 
> There are two problems:
> 
> 1. Performance - it's slower to go through a library that outputs XML than
> do a printf("%d", pid) or the like.

Indeed.

> 
> 2. Space - based on a little experience using XML as a transport, the space
> used by the tags adds up.

Yep.

> 
> 3. Work - writing a good package to do this, and rewriting bits of the
> kernel to use it.  I'll volunteer my time.

4. Stability - A good XML parsing library cannot be "simple" or "small". At
least not when written in C   ;)

5. Lack of benefits - we already have structure because of the filesystem in
which the information would live. The actual "tags" could be so incredibly
simple that using XML would just be shooting birds with tactical nukes. E.g.
lots of fun, but a little expensive and not really necessary.

But maybe I'm just a pessimist and should stop bitching and start coding  ;)

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:

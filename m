Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132373AbREBNcl>; Wed, 2 May 2001 09:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132425AbREBNcb>; Wed, 2 May 2001 09:32:31 -0400
Received: from frege-d-math-north-g-west.math.ethz.ch ([129.132.145.3]:23778
	"EHLO frege.math.ethz.ch") by vger.kernel.org with ESMTP
	id <S132373AbREBNcT>; Wed, 2 May 2001 09:32:19 -0400
Message-ID: <3AF00C53.5EEE8E01@math.ethz.ch>
Date: Wed, 02 May 2001 15:32:03 +0200
From: Giacomo Catenazzi <cate@math.ethz.ch>
Reply-To: cate@dplanet.ch
X-Mailer: Mozilla 4.7C-SGI [en] (X11; I; IRIX 6.5 IP22)
X-Accept-Language: en
MIME-Version: 1.0
To: esr@thyrsus.com
CC: "Giacomo A. Catenazzi" <cate@dplanet.ch>,
        Peter Samuelson <peter@cadcamlab.org>,
        CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Requirement of make oldconfig [was: Re: [kbuild-devel] Re: CML2 
 1.3.1, aka ...]
In-Reply-To: <20010427193501.A9805@thyrsus.com> <15084.12152.956561.490805@gargle.gargle.HOWL> <20010429183526.B32748@thyrsus.com> <15085.37569.205459.898540@gargle.gargle.HOWL> <20010430133932.B28849@thyrsus.com> <20010430141623.A15821@cadcamlab.org> <200
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" wrote:
> 
> Giacomo A. Catenazzi <cate@dplanet.ch>:
> > My proposal is instaed of complain about configuration violatation,
> > you just wrote the possible correct configuration and prompt user to
> > select the correct configuration.
> > In the case you cite, e.g. oldconfig shoud prompt:
> >   1) SMP=n
> >   2) RTC=m
> >   3) RTC=y
> > (assuming the ARCH is invariant).
> 
> You, and the other person who proposed this previously, are getting
> way too hung up on this particular easy case and not thinking about
> the general problem.
> 
> The number of prompts goes up with the number of variables in the constraint.
> But the number of possible correct configurations goes up as 2**n -- actually,
> 3**n because we have trits.
> 

???
No. You propmt only one invalid assertion.
After you this prompt you continue to validate rules and you
will
maybe prompt for another invalid rules. But these invalid
rules
are generally infrequent.

Thus in my proposal the number of questions on the *worste*
case
are equal to your proposal (rm configuration an reconfigure it
again, the vi methods is not serious).


> What you're saying, in effect, is that if f is number of frozen variables
> in the constraint then the configurator ought to generate 3 ** (n - f)
> possible correct models and prompt for one of them.  Since f typically
> equals just 1 that number goes up really fast with n.
>
> And what if one of the variables in the constraint is of integer or
> string type?  In that case the number of possible models to be
> prompted for is effectively infinite.  (Finite but very very large).

It is very unlikely to have constraint on string or on
integer.
But anyway, where is the problem?
You simple ask the new value of this symbol.

> 
> You are proposing an interface that will handle easy cases but blow
> up in the user's face in any hard one.  That's poor design, frustrating
> the user exactly when he/she most needs help.

But how do you help such users? Telling them to use vi?

Broken configuration will always exist (with generally few
errors).
Surelly also you produce incorrect configuration. (You can
garantee
that configuration for CML2 for kernel 2.4.3 is fully
compatible
with rules you use for 2.4.4? and for the 2.5.x?

We make always error. But if you don't correct the behaviour
of
oldconfig we will tend not to correct CML2 rules, because it
can
broke our configuration (and we will prefer a incorrect but
working
configuration that a correct configuration (but that requires
a complete reconfiguration, or some luck with vi)


	giacomo


PS: I think you missundestood my previous email.
No autimatic recovery of broken configuration, but it is need
a 
usefull tool to produce a valid configuration from an (maybe)
invalid or old configuration. In a manual manner.

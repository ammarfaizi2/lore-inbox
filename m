Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272528AbRH3W0R>; Thu, 30 Aug 2001 18:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272531AbRH3W0I>; Thu, 30 Aug 2001 18:26:08 -0400
Received: from egghead.curl.com ([216.230.83.4]:19716 "HELO egghead.curl.com")
	by vger.kernel.org with SMTP id <S272528AbRH3W0A>;
	Thu, 30 Aug 2001 18:26:00 -0400
From: "Patrick J. LoPresti" <patl@cag.lcs.mit.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <Pine.LNX.4.33.0108292018380.1062-100000@penguin.transmeta.com> <20010830165447Z16272-32385+540@humbolt.nl.linux.org> <m266b51c5c.fsf@barnowl.demon.co.uk>
Date: 30 Aug 2001 18:26:18 -0400
In-Reply-To: <mit.lcs.mail.linux-kernel/m266b51c5c.fsf@barnowl.demon.co.uk>
Message-ID: <s5glmk16v79.fsf@egghead.curl.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Graham Murray <graham@barnowl.demon.co.uk> writes:

> Daniel Phillips <phillips@bonn-fries.net> writes:
> 
> > More than anything, it shows that education is needed, not macro patch-ups.
> > We have exactly the same issues with < and >, should we introduce 
> > three-argument macros to replace them?
> 
> Would it not have been much more "obvious" if the rules for
> unsigned/signed integer comparisons (irrespective of the widths
> involved) were
> 
> 1) If the signed element is negative then it is always less than the
>    unsigned element.
> 
> 2) If the unsigned element is greater than then maximum positive value
>    expressible by the signed one then it is always greater.
> 
> 3) Only if both values are positive and within the range of the
>    smaller element are the actual values compared. 

With infinite-precision arithmetic, yes; of course min() should just
return the smaller value.

But what would the C type of "min" be for comparing, say, signed and
unsigned longs?  The range of possible results does not fit in any
integral type.  (Repeat the question for signed/unsigned "long long"
if "long long" is your answer.)

 - Pat

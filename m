Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751210AbVIGM7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbVIGM7N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 08:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbVIGM7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 08:59:13 -0400
Received: from ns.firmix.at ([62.141.48.66]:48096 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1751210AbVIGM7M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 08:59:12 -0400
Subject: RE: kbuild & C++
From: Bernd Petrovitsch <bernd@firmix.at>
To: "Budde, Marco" <budde@telos.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <809C13DD6142E74ABE20C65B11A2439809C4C0@www.telos.de>
References: <809C13DD6142E74ABE20C65B11A2439809C4C0@www.telos.de>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Wed, 07 Sep 2005 14:58:51 +0200
Message-Id: <1126097932.24425.86.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-07 at 14:04 +0200, Budde, Marco wrote:
[...]
> > Yes, this is a general problem with integrated c/c++ stuff like
> > Win-Visual C++. 
> 
> not all Windows users do not know what they are doing :-).
> Speaking for myself: I am programming under Linux and
> Windows (with more than 10 years experience in C and C++)
> and I do know the differences. So please do not call
> people idiots only because the are writing software under
> Windows.

I didn't call anyone an idiot, at most I could have meant just
in-experieced in "C vs C++" things. I just happen to know a lot of
people where above is (sadly enough) correct.

> > People think that they can mix it freely, 
> 
> They can do.

If they know, what they do, yes.

> > in fact they
> > are using *only* C++ (it just happens that some part of the source is
> > compilable with a C compiler, but since you compile everything with
> the
> > C++ compiler pressing F9, no one sees the difference).
> 
> So if I compile a library with gcc and link the code to a g++
> program, the complete program gets compiled with the C++ compiler?
> Interesting :-).

No (and I didn't wrote above either).
And BTW it is quite nice to see the differences between gcc and g++ on
little things like the signedness of enums etc. if you compile identical
C-source with both.
And you have to take care that the linkage is correct. For the largest
part this is already standard and works out of the box. But if the
C-library is self-written, things may be different.

> > We re on linux-kernel@ here, so we don't care *here* for user-space
> > software (only for the interface - i.e. sys-calls).
> 
> When you develop a complete product consisting of the embedded
> firmware, the driver, and the user space software, you always have
> to decide, where to put the code. And in such a case it is really
> nice, when you can use the same language in all layers.

ACK.

> > And for embedded usage C++ is unsusable in user-space too since it
> will
> > ex-bloat the whole software if people simply pull-in usual and/or
> common
> > C++ libraries like the STL and use them without knowing how much
> object
> > code they explode with it (if used without thinking).
> 
> This applies for all languages. If you do not know, what you are doing,
> you can write really awful code. And I cannot agree, that C++ results to
> larger code. 

Not necessarily. But with (badly used) C++ templates (read: using e.g.
STL, I don't know much about the boost lib) things can get much worse
*much* faster then with preprocessor magic.

> > Which is again wrong. You can OO software without OO languages (though
> > you loose some nice features and checking).
> 
> If you are an experienced OO programmer, you do not want to use
> languages like plain C, because they result into worse code and
> make life more difficult. If you do not like any kind of abstraction,

There are environments where you don't have choice. E.g. if your
embedded system must boot from 4MB.

> why are you using C instead of pure assembler?

Because C is only a portable assembler? ;-)
Because there are several quite usable libs around which also fit into
embedded systems?
And the abstraction (or better: the level of abstraction) is the point.
Of course it is easier to use e.g. perl where buffer-overflows are not
possible and strings and arrays are handled natively etc. But you have
probably other problems too and less control (und usually knowledge)
what is really going on in the background.

> Can you estimate what such a redesign would cost our customers?
> You would need several years to redesign the concept.

I leave it up to you and your customers to decide and won't interfere
with the decision.
So apparently you're stuck with the C++-patch from .is to the kernel and
get the driver to work with this.
*If* you do this, I would interested on the needed effort and problems
(like missing features etc.), just to get an rough idea what it really
took in at least one project.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services


Return-Path: <linux-kernel-owner+w=401wt.eu-S1754449AbWLRT1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754449AbWLRT1e (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 14:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754448AbWLRT1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 14:27:33 -0500
Received: from mx1.redhat.com ([66.187.233.31]:38027 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754450AbWLRT1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 14:27:32 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ricardo Galli <gallir@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: GPL only modules
References: <200612161927.13860.gallir@gmail.com>
	<Pine.LNX.4.64.0612161253390.3479@woody.osdl.org>
	<orwt4qaara.fsf@redhat.com>
	<Pine.LNX.4.64.0612170927110.3479@woody.osdl.org>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat OS Tools Group
Date: Mon, 18 Dec 2006 17:27:19 -0200
In-Reply-To: <Pine.LNX.4.64.0612170927110.3479@woody.osdl.org> (Linus Torvalds's message of "Sun\, 17 Dec 2006 09\:59\:51 -0800 \(PST\)")
Message-ID: <orpsah6m3s.fsf@redhat.com>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 17, 2006, Linus Torvalds <torvalds@osdl.org> wrote:

> For example, glibc could easily have just come out and said the thing that 
> is obvious to any sane person: "using this library as just a standard 
> library does not make your program a derived work". 

> There really wassn't much need for the LGPL, I think. 

So I guess you approve of the reformulation of LGPL as an additional
permission on top of GPL, as in its draft at gplv3.fsf.org, right?

>> Some claim that, in the case of static linking, since there part of
>> the library copied to the binary, it is definitely a case of derived
>> work.

> No, the sane way to think about it is that linking just creates an 
> "aggregate" work.

That's your take on it.  It does make sense, but claiming it's *the*
sane way to think about it is making the mistake you accused the FSF
of making.


> Why do people think that using "ln" is _any_ different from using 
> "mkisofs".

Maybe because mkisofs will create a functional filesystem image out of
whatever you could possibly throw at it, while ld will perform a
number of cross-checks between the inputs it is given which indicates
a much closer relationship between the inputs?

You said so yourself, so I guess we agree.


> Does "mkisofs" create a derived work, or an aggregate?

I'd say both.  I understand it's a derived work, but one that happens
to be a mere aggregate of works that might or might not be based on a
GPLed program included in the aggregate.  Now, does this mean that a
court would be pretty much forced to admit the aggregate as a derived
work, and thus that the copyright holder (or the license author) gets
a say on what 'mere aggregate' means in the license chosen by the
copyright holder?

ld creates works that perhaps can be construed as not being mere
aggregates or even derived works, since ld doesn't always copy the
contents of its inputs to the output.  But it does extract some
information that makes to the output, and there is a closer
relationship between the works than in the mere aggregation case of
mkisofs, so there is still room for claiming that the output is a
derived work, and that it's not a mere aggregate.

In fact, it can't possibly be exempt by this paragraph in clause 2 of
the GPL:

  In addition, mere aggregation of another work not based on the
  Program with the Program (or with a work based on the Program) on a
  volume of a storage or distribution medium does not bring the other
  work under the scope of this License.

because we're not talking about mere aggregation of the work (or a
work based on it) with another work not based on the program, but
rather about whether the linker output is based on the program or not.
A court gets to decide whether it is a derived work, but since in the
dynamic linking case you're not aggregating (because you're not
copying the entire library) the program with other works not based on
the program, then this exception doesn't apply, methinks.

>    This particular thing is a non-issue wrt the GPLv2, since you always 
>    have the right to do distribution of aggregates, but it does come up in 
>    some OTHER licenses.

Make it *mere* aggregates.  That *might* turn out to be a relevant
distinction.  E.g., if there's functional dependence of one of the
elements of the aggregate on another, is the aggregate work still the
result of mere aggregation?

-- 
Alexandre Oliva         http://www.lsd.ic.unicamp.br/~oliva/
FSF Latin America Board Member         http://www.fsfla.org/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}

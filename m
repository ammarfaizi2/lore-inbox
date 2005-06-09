Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262353AbVFILWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbVFILWH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 07:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262352AbVFILWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 07:22:07 -0400
Received: from soufre.accelance.net ([213.162.48.15]:11754 "EHLO
	soufre.accelance.net") by vger.kernel.org with ESMTP
	id S262353AbVFILVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 07:21:08 -0400
Message-ID: <42A82619.1010400@xenomai.org>
Date: Thu, 09 Jun 2005 13:20:57 +0200
From: Philippe Gerum <rpm@xenomai.org>
Organization: Xenomai
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: karim@opersys.com
CC: paulmck@us.ibm.com, linux-kernel@vger.kernel.org, bhuey@lnxw.com,
       andrea@suse.de, tglx@linutronix.de, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, RTAI-Users <rtai@rtai.org>
Subject: Re: Attempted summary of "RT patch acceptance" thread
References: <20050608022646.GA3158@us.ibm.com> <42A721F9.2070608@opersys.com>
In-Reply-To: <42A721F9.2070608@opersys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Karim Yaghmour wrote:
 > Paul,
 >
 > I've finished reading your summary and I must say that it's excellent.
 > I don't remember ever reading a non-partisan comparison of this level
 > on the issue of real-time and Linux. Thanks for writing _and_ having
 > the guts to post it :)
 >

I second that. It's refreshing.

 > There is only one issue I would like to further highlight.
 >
 > Note: None of the following should be in any way controversial, I'm
 > just providing further background.
 >
 > Paul E. McKenney wrote:
 >
 >>the corresponding approach's strengths and weaknesses.  I do not address
 >>"strength of community", even though this may well be the decisive 
factor.
 >

[snip][snip][snip]

 >
 > In the past few years, though, a new bread of real-time developers
 > have become interested in making Linux fit for real-time
 > applications. Unlike the previous generation, though, these folks
 > have concentrated their efforts on working within the framework
 > already agreed upon by existing kernel developers: the LKML. And
 > in that, they have achieved a level of awareness amongst the kernel
 > crowd that I think RTAI and Adeos have not yet reached.
 >
 > I've tried to remedy to this situation as best I can, by pointing
 > out what was obvious to me when appropriate.

Ack, and you should be thanked for this. Especially since in some
occasions, RTAI, as a community project, did likely get on your
nerves, by not presenting its progress in this area on a more regular
basis, if it ever bothered presenting it at all. Well, ok, no excuse.

Btw, taking the risk to piss you off a little bit more :o), I don't
resist to announce here, two weeks late, that RTAI/fusion (0.7.5) has
been ported over ia64, thanks to the contribution of the HYADES
project (http://www.hyades-itea.org/).

 > However, it must be
 > said that I haven't been actively involved with either Adeos or
 > RTAI in quite some time. So while I did play a part in the
 > history of both projects, there are others that are in a much
 > better position than I am to present to the LKML the work done
 > by the RTAI and Adeos communities.
 >
 > In essence, therefore, what I have to say is this:
 > - To those who are actively involved in the development of RTAI
 > and Adeos, now is the time to drop the historical tendency of
 > acting as an entirely separate community and to start sharing
 > your work on the LKML.

Needless to remind you that some of us, in the Adeos/RTAI side of the
universe, finally acknowledged some time ago that not participating on
a regular basis to the LKML was a mistake, and FWIW, I'm one of these
people.

This said, the following might help understanding why it has not been
as "natural" as one would have thought, for us to have a regular
presence so far, in the discussions around the kernel framework:

1. Adeos is basically an enabler for real-time cores that are
steadfastly designed to run side-by-side with the Linux kernel, for
various reasons involving predictability, complexity, scalability and
performances; I won't rehash those here. Meanwhile, no consensus seems 
to exist among the kernel contributors and users, on the best way to
provide real-time support, either natively inside the kernel, or
cooperatively with, but outside of it, which is obviously a crucial
design issue with long-term implications. People don't even seem to
settle on the definition of "real-time", which indeed covers various 
application requirements in terms of predictability. Accordingly, /me, 
as an Adeos contributor, did not see the point in waving hands too much 
or submit patches for inclusion. Some may say that it's precisely 
because of the latter that Adeos gets no opportunity of ever being 
considered by the kernel people, but hey, nobody said I was a smart guy 
neither.

2. RTAI is a common client of the Adeos layer, and as such, it's an
external piece of code which in turn is loaded by the Linux kernel,
and runs embodied in plain kernel modules. For the most part, people
in the RTAI project usually don't write core kernel code, but are
using a limited subset of its documented interface "as is". For this
reason, these people tend to keep the noise / signal ratio as low as
possible, and do not appear that much on the LKML, just because their
contribution might be of no direct interest to the "vanilla" kernel
folks.

But,... fact is that RTAI is evolving, and that people working on the
development track called "fusion" have a year ago decided to reach a
seamless cooperation between the Linux kernel and the real-time core for
their users, so that people using RTAI are now able to keep the best
of both worlds. This approach preserves the common Linux programming 
model in user-space, and offers a consistent integration of the regular 
Linux services into the RTAI space. Hopefully, this cooperation of 
real-time designs will someday translate into the cooperation of people 
promoting these designs.

Accordingly, we already closely track what's going on the
LKML on a daily basis, don't doubt of it. All in all, being more
present in the kernel community for us is more about finding the best
way to submit the most useful information to the LKML, and perhaps get
over some shyness to do it. Anyway, we will learn.

 > - To those who are actively involved in finding solutions to the
 > real-time issues in Linux, do not be fooled by the apparent lack
 > of activity in the Adeos or RTAI projects, they are both very
 > active and warrant consideration.
 >
 > As you correctly state, "strength of community" is likely a decisive
 > factor. What is important here is not to confuse "apparent" strength
 > of community -- or lack thereof -- with "actual" strength of
 > community -- or lack thereof.
 >
 > Thanks again for a great piece.
 >
 > Karim Yaghmour

-- 

Philippe.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264627AbUGBOnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264627AbUGBOnL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 10:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264629AbUGBOnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 10:43:11 -0400
Received: from out007pub.verizon.net ([206.46.170.107]:30344 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S264627AbUGBOnE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 10:43:04 -0400
Message-Id: <200407021442.i62EguXr014169@localhost.localdomain>
To: William Lee Irwin III <wli@holomorphy.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.X, NPTL, SCHED_FIFO and JACK 
In-reply-to: Your message of "Fri, 02 Jul 2004 00:37:49 PDT."
             <20040702073749.GK21066@holomorphy.com> 
Date: Fri, 02 Jul 2004 10:42:56 -0400
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [141.152.253.159] at Fri, 2 Jul 2004 09:43:02 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Not only are lowlat-alike changes in mainline 2.6, the algorithms where
>lowlat found explicit preemption points were necessary have been changed
>in a number of cases to be asymptotically faster.

*Some* of the algorithms. 

>So you gave no feedback. What do you expect us to do? There are

Actually, the linux audio community gave quite a lot of feedback early
in the life of 2.5, most of it directly to andrew, ingo and robert
(love). The situation wasn't good at all. It wasn't all the scheduler
(although that was pretty bad) and explicit preemption (which was
basically missing inspite of the preemption patch) - the VM system was
hosed for massive disk streaming, for example - and the feedback we
got, while sympathetic, was basically of the form "2.{5,6} isn't going
to the lowlat route, please wait and see what we come up with". So we
waited.

>> about similar issues in 2.5 before it was even half-done. I tested
>> just about every MM patch from andrea and rik that came out for
>> 2.3/2.4 - I did not have time to do that with 2.5.
>
>This level of participation is by no means a requirement. Just show

Given my sporadic observations of the kernel mailing list over the
last five years, I'd say that it often is a requirement, especially if
you are dealing with workloads and application behaviour that is
fundamentally different to the usual "linux stuff" and cannot be
reduced to simple test cases. And I've been happy to provide it when
there is some indication that the resulting feedback will make a
difference. Andrea, Ingo and Andrew all provided that sense of purpose
for 2.4.

>The thing that went wrong here is that the report is very non-specific.

We don't have anything very specific to report. Sometimes, the most
helpful bug reports start life as someone asking "this doesn't seem to
work very well under conditions X, Y but its OK with Z". Someone turns
around and says "oh, duh!" and the problem is fixed. Apparently, in
this situation, that may not be the case. No problem. We'll come back
with more specifics.

>really the way things are supposed to work. Narrowing the presumed
>kernel issue down to a small enough userspace testcase or section of
>code that you can reasonably post it is pretty much a burden you should
>have taken on.

And I/we're willing to do that (and have been doing that) once its
clear that this is the right path.

>For one, the description of the nasty kludges or code that worked in
>2.4 but not 2.6 should have been up-front. e.g. "I'm trying to get an

There were *no* nasty kludges in JACK for 2.4 unless you refer to a
technique recommended by many *nix programming books and wizards over
the last 20 years to deal with the rather limited security model that
Linux was offering in 2.4 along with its POSIX cousins. And I note in
passing that as within a week or two of us discovering the security
module system in 2.6, someone in the audio community immediately wrote
a very nice kernel module to remove the need for jackstart.

It would also be nice if you could at least implicitly acknowledge
that the one of the major reasons (mvista being the other) that the
latency performance of linux has improved in the last 4 years is
because us RT audio guys have done such nasty, fucked up, useless,
pathetic job of requesting and collaborating on efforts to improve
it. The preemption patch came from a different direction, and didn't
accomplish the same thing - hardly anyone on the kernel list seemed to
care that the kernel was filled with 50ms interrupt masks until we
started explaining how it made linux unusable for certain things that
worked OK on windows + macos; this then led to many of us helping ingo
and andrew in their incredible attempts to fix things.

That doesn't let us off the hook of decent bug reporting, but if you
could at least quit the adult-lecturing-recalcitrant-adolescent tone,
there would be more useful exchanges going on.

--p

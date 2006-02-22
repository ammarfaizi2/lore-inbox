Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751360AbWBVQVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbWBVQVw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 11:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbWBVQVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 11:21:52 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:60620 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751360AbWBVQVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 11:21:52 -0500
Date: Wed, 22 Feb 2006 11:21:35 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: etsman@cs.huji.ac.il
cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: klogger: kernel tracing and logging tool 
In-Reply-To: <43FC8261.9000207@gmail.com>
Message-ID: <Pine.LNX.4.58.0602221110410.4164@gandalf.stny.rr.com>
References: <43FC8261.9000207@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


YALU (Yet Another Logging Utility :)

On Wed, 22 Feb 2006, Yoav Etsion wrote:

> Hi all,
>
> This may look like a shameless plug, but it is intended as an RFC:
> over the past few years I've developed a kernel logging tool called
> Klogger: http://www.cs.huji.ac.il/~etsman/klogger
>
> In some senses, it is similar to the LTT - Linux Trace Toolkit (and was
> actually developed because LTT did not suit my needs).
> However, Klogger is much more flexible. The two key points being:
> 1.
> it offers extremely low logging overhead (better than LTT and Dtrace) by
> auto-generating the logging code from user-specified config files.
> 2.
> it allows new events to be defined, and more importantly shared among
> subsystems' developers, thus allowing to understand module/subsystem
> interactions without an all encompassing knowledge.
> This feature can allow developers to design the performance logging
> while designing the subsystem to be logged, allowing other
> developers/researchers to get some insights without having to fully
> understand a subsystem's code.
>
> I am very interested in the community's opinion on this matter, so if
> anyone is interested you can find the design document, a HOWTO and
> patches against 2.6.14/2.6.9 on my website:
> http://www.cs.huji.ac.il/~etsman/klogger
> or
> http://linux-klogger.sf.net
>
> Currently, we use this tool at the the Hebrew University, but if there
> is public interest I can work on it further so it adheres to kernel code
> standards (the tool currently does obscene things like writing to disk
> from kernel threads :-P --- it was written before relayfs was out there).
>

Interesting.  I'll take a look to see how you did things.  I have my own
little logging utility that works wonders in finding race conditions and
was also written before relayfs. In fact, Tom Zanussi once made relayfs a
back end for the tool.  But relayfs still has separate buffers for each
CPU and I usually use my tool to see how the CPUs interract, and time
stamps just don't cut it (my tool is best on a lock up, BUG or panic).

You can take a look at what I did, but the documentation is a little out
of date.  I don't think I recorded yet edprint(char *fmt,...) which
records automatically, the cpu, function and line number as well as the
message. Also the print format has changed on how my logread program
prints it out.

Anyway, mine's called logdev and can be found here:

http://www.kihontech.com/logdev

hmmph, maybe someday I'll go back to updating the documentation.

-- Steve

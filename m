Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270224AbRHMOcV>; Mon, 13 Aug 2001 10:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270225AbRHMOcL>; Mon, 13 Aug 2001 10:32:11 -0400
Received: from twinlark.arctic.org ([204.107.140.52]:50956 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S270224AbRHMOcB>; Mon, 13 Aug 2001 10:32:01 -0400
Date: Mon, 13 Aug 2001 07:32:13 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Rik van Riel <riel@conectiva.com.br>
cc: David Ford <david@blue-labs.org>, <linux-kernel@vger.kernel.org>
Subject: Re: VM nuisance
In-Reply-To: <Pine.LNX.4.33L.0108102347050.3530-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.33.0108130716321.20672-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Aug 2001, Rik van Riel wrote:

> I haven't got the faintest idea how to come up with an OOM
> killer which does the right thing for everybody.

maybe the concept is flawed?  not saying that it is flawed necessarily,
but i've often wondered why linux vm issues never seem to be solved in the
years i've been reading linux-kernel.

if i understand the OOM killer correctly it's intended to make some sort
of intelligent choice as to which application to shoot when the system is
out of memory.

honestly, if applications can't stomach being shot then the bug is in the
application, not in the kernel.  vi can handle being shot because it does
the right thing:  it checkpoints state periodically.  it's a simple model
which any sane application could follow, and many do actually follow.

getting shot for OOM or getting shot because of power failure, or 2-bit
RAM failure, or backhoe fade, or ... what's really the difference?

so why not just use the most simple OOM around:  shoot the first app which
can't get its page.  app writers won't like it, and users won't like it
until the app writers fix their bugs, but then nobody likes the current
situation, so what's the difference?

maybe kernel support for making checkpointing easier would be a good way
to advance the science?  there certainly are tools which exist that do
part of the problem already -- except for sockets and pipes and such
interprocess elements it's pretty trivial to checkpoint.  interprocess
elements probably require some extra kernel support.  network elements are
where it really becomes challenging.

i would happily give up 10 to 20% system resources for checkpoint overhead
if it meant that i'd be that much closer to a crashproof system.  after a
year the performance deficit would be made up by hardware improvements.

i know it's a big pill to swallow, but i've been impressed time and time
again by the will of linux kernel hackers to just say "this is how it will
be, because it is the only known way to perfection, deal."

-dean


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbWIPKSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbWIPKSp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 06:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbWIPKSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 06:18:45 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:5537 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751294AbWIPKSo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 06:18:44 -0400
Message-ID: <450BCF97.3000901@sgi.com>
Date: Sat, 16 Sep 2006 12:19:03 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060907)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, tglx@linutronix.de, karim@opersys.com,
       Paul Mundt <lethal@linux-sh.org>, Roman Zippel <zippel@linux-m68k.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060915132052.GA7843@localhost.usen.ad.jp>	<Pine.LNX.4.64.0609151535030.6761@scrub.home>	<20060915135709.GB8723@localhost.usen.ad.jp>	<450AB5F9.8040501@opersys.com>	<450AB506.30802@sgi.com>	<450AB957.2050206@opersys.com>	<20060915142836.GA9288@localhost.usen.ad.jp>	<450ABE08.2060107@opersys.com>	<1158332447.5724.423.camel@localhost.localdomain>	<20060915111644.c857b2cf.akpm@osdl.org>	<20060915181907.GB17581@elte.hu> <20060915131317.aaadf568.akpm@osdl.org>
In-Reply-To: <20060915131317.aaadf568.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Fri, 15 Sep 2006 20:19:07 +0200
> Ingo Molnar <mingo@elte.hu> wrote:
> 
>> * Andrew Morton <akpm@osdl.org> wrote:
>>
>>> What Karim is sharing with us here (yet again) is the real in-field 
>>> experience of real users (ie: not kernel developers).
>> well, Jes has that experience and Thomas too.
> 
> systemtap and ltt are the only full-scale tracing tools which target
> sysadmins and applciation developers of which I am aware..

Just to clarify, the stuff I have looked at in the field was based on
LTT, but not part of the official LTT. It simply goes to show that end
users cannot agree on a small set of fixed tracepoints because someone
always wants a slightly different view of things, like in the cases I
looked at. Not to mention that the changes LTT users make, at times, to
shoehorn their stuff in, especially in sensitive codepaths such as the
syscall path, have side effects which clearly weren't considered.

In one case I ended up doing an alternative implementation using kprobes
to prove that similar results could be achieved in that manner.
Strangely enough I was right :)

I don't have any objections to markers as Ingo suggested. I just don't
buy the repeated argument that LTT has been around for years and barely
changed. It's simply a case of the LTT team not being aware (or deciding
to ignore, I cannot say which) what users have actually done with the
LTT codebase, but it seems obvious they are not aware what everyone is
doing with it. But we have seen before how if an infrastructure like LTT
goes into the kernel, many more users will pop up and want to have their
stuff added.

The other part is the constantly repeated performance claim, which to
this point hasn't been backed up by any hard evidence. If we are to take
that argument serious, then I strongly encourage the LTT community to
present some real numbers, but until then it can be classified as
nothing but FUD.

I shall be the first to point out that kprobes are less than ideal,
especially the current ia64 implementation suffers from some tricky
limitations, but thats an implementation issue.

Cheers,
Jes

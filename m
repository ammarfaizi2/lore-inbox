Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbWIVTNy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbWIVTNy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 15:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbWIVTNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 15:13:54 -0400
Received: from opersys.com ([64.40.108.71]:15374 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S932169AbWIVTNx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 15:13:53 -0400
Message-ID: <45143850.3000005@opersys.com>
Date: Fri, 22 Sep 2006 15:24:00 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
CC: Ingo Molnar <mingo@elte.hu>, Martin Bligh <mbligh@google.com>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Linux Kernel Markers 0.5 for Linux 2.6.17 (with probe
  management)
References: <20060921160009.GA30115@Krystal> <20060921160656.GA24774@elte.hu> <20060921214248.GA10097@Krystal> <20060922070714.GB4167@elte.hu> <20060922150810.GB20839@Krystal> <45140E33.9030509@opersys.com> <20060922161353.GA1569@Krystal> <45141759.8060600@opersys.com> <20060922180654.GA12645@Krystal>
In-Reply-To: <20060922180654.GA12645@Krystal>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mathieu Desnoyers wrote:
> Here is the implementation :-)

Trigger happy :)

> To change it, we can dynamically overwrite the __mark_near_jump_select_##name
> value (a byte) to (__mark_jump_call_##name - __mark_near_jump_##name).

Hmm... I don't know if you won't still need to resort to int3 and
then overwrite the byte. From my understanding it sounds like you
wouldn't but that's where Richard's insight on the errata stuff
might come in handy.

Have you actually tried to run this code by any chance? *If* it did
work, I think this might just mean that you don't need either
kprobes or djprobes.

> So we have one architecture specific optimisation within the architecture
> agnostic marking mechanism.

That would seem reasonable, I think. You might want to test out
your mechanism, get confirmation from Richard and then post an
update to your patches.

Karim


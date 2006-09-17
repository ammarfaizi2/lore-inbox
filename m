Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965034AbWIQRSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965034AbWIQRSy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 13:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965035AbWIQRSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 13:18:54 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:10683 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S965034AbWIQRSx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 13:18:53 -0400
Date: Sun, 17 Sep 2006 19:18:22 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: Paul Mundt <lethal@linux-sh.org>, Karim Yaghmour <karim@opersys.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: tracepoint maintainance models
In-Reply-To: <20060917150953.GB20225@elte.hu>
Message-ID: <Pine.LNX.4.64.0609171816390.6761@scrub.home>
References: <450D182B.9060300@opersys.com> <20060917112128.GA3170@localhost.usen.ad.jp>
 <20060917143623.GB15534@elte.hu> <Pine.LNX.4.64.0609171651370.6761@scrub.home>
 <20060917150953.GB20225@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 17 Sep 2006, Ingo Molnar wrote:

> of course it's easy to have static markup that is usable for both types 
> of tracers - but that is of little use. Static tracers also need the 
> guarantee of a _full set_ of static markups. It is that _guarantee_ of a 
> full set that i'm arguing against primarily. Without that guarantee it's 
> useless to have markups that can be used by static tracers as well: you 
> wont get a full set of tracepoints and the end-user will complain. 
> (partial static markups are of course still very useful to dynamic 
> tracers)

And yet again, you offer no prove at all and just work from assumptions.
You throw in some magic "_full set_" of marker and just assume any change 
in that will completely break static tracers.
You just assume that we absolutely must make this "guarantee" for static 
tracers, as if static tracer can't be updated at all.
You completely ignore that it might be possible to create some rules and 
educate users that the amount of exported events can't be completely 
static.
What is so special between users of dynamic and static tracers, that the 
former will never complain, if some tracepoint doesn't work anymore?

Do you really think that users of static tracers are that stupid, that 
they are not aware of its limitations? Of course they sometimes have to 
maintain their own set of tracepoints (especially in the area of kernel 
development). That still doesn't change the fact that _any_ trace user 
will benefit from a base set of tracepoints, which you seem to think 
can't exist.

bye, Roman

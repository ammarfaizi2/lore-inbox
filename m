Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751418AbWIRDxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbWIRDxp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 23:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbWIRDxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 23:53:45 -0400
Received: from opersys.com ([64.40.108.71]:16913 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S1751418AbWIRDxo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 23:53:44 -0400
Message-ID: <450E1D2E.3080705@opersys.com>
Date: Mon, 18 Sep 2006 00:14:38 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Nicholas Miell <nmiell@comcast.net>, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: tracepoint maintainance models
References: <450D182B.9060300@opersys.com> <20060917112128.GA3170@localhost.usen.ad.jp> <20060917143623.GB15534@elte.hu> <1158524390.2471.49.camel@entropy> <20060917230623.GD8791@elte.hu> <450DEEA5.7080808@opersys.com> <20060918005624.GA30835@elte.hu> <450DFFC8.5080005@opersys.com> <20060918033027.GB11894@elte.hu>
In-Reply-To: <20060918033027.GB11894@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar wrote:
> Amazing! So the trace data provided by those removed static markups 
> (which were moved into dynamic scripts and are thus still fully 
> available to dynamic tracers) are still available to LTT users? How is 
> that possible, via quantum tunneling perhaps? ;-)

Please run it one more time Mr. DJ:
> What is sufficient for tracing a given set of events by means
> of binary editing *that-does-not-require-out-of-tree-maintenance*
> can be made to be sufficient for the tracing of events using
  ^^^^^^^^^^^^^^
> direct inlined static calls.

Do I really need to explain this one to you? Do I?

Bahhh, ok, here we go:

Previously alluded to script can easily be made to read mainlined
dynamic scripts and generate alternate build files for the
designate source. Let me know if I need to expand on this.

You know what, let's cut through the chase. Go ahead an mainline
any infrastructure you think will be sufficient to make it
possible to maintain SystemTap's essential _in the tree_. *Anything*
that you insert in there to make it possible to make *any*
dynamic tracer mainline can and likely will be used to obtain direct
static calls. The only way this doesn't work is if the dynamic
tracer folks have to continue maintaining their stuff out of tree.

See, this not only is Karim evil, but so too are the facts. Even
when manipulated by Ingo, *mechanism* continues to be orthogonal
to *markup*. Now that's evil.

Karim
-- 
President  / Opersys Inc.
Embedded Linux Training and Expertise
www.opersys.com  /  1.866.677.4546

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263571AbTEOBb4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 21:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263582AbTEOBbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 21:31:55 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:1192 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263571AbTEOBbw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 21:31:52 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andrew Theurer <habanero@us.ibm.com>
Reply-To: habanero@us.ibm.com
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: [patch] Re: Bug 619 - sched_best_cpu does not pick best cpu (1/1)
Date: Wed, 14 May 2003 20:48:53 -0500
User-Agent: KMail/1.4.3
Cc: anton@samba.org, "" <colpatch@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Dave Hansen <haveblue@us.ibm.com>, Bill Hartner <bhartner@us.ibm.com>,
       Andrew Morton <akpm@zip.com.au>, Robert Love <rml@tech9.net>,
       "" <linux-kernel@vger.kernel.org>
References: <3EB70EEC.9040004@us.ibm.com> <200305142029.45413.habanero@us.ibm.com> <Pine.LNX.4.50.0305142124440.19782-100000@montezuma.mastecende.com>
In-Reply-To: <Pine.LNX.4.50.0305142124440.19782-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200305142048.53530.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 May 2003 20:26, Zwane Mwaikambo wrote:
> On Wed, 14 May 2003, Andrew Theurer wrote:
> > +int nr_cpus_in_node[MAX_NUMNODES] = { [0 ... (MAX_NUMNODES -1)] = 0};
>
> [snip...]
>
> > +static inline int nr_cpus_node(int node)
> > +{
> > +	return nr_cpus_in_node[node];
> > +}
> > +
> >  static inline int cpu_to_node(int cpu)
> >  {
> >  	int node;
>
> How about an hweight() on node_to_cpumask?

I'd rather cache it.  I believe hweight() will be the asm-generic routine.

-Andrew


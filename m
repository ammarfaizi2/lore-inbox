Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263587AbTEOBW4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 21:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263585AbTEOBW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 21:22:56 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:17794
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S263582AbTEOBWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 21:22:54 -0400
Date: Wed, 14 May 2003 21:26:18 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Andrew Theurer <habanero@us.ibm.com>
cc: anton@samba.org, "" <colpatch@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Dave Hansen <haveblue@us.ibm.com>, Bill Hartner <bhartner@us.ibm.com>,
       Andrew Morton <akpm@zip.com.au>, Robert Love <rml@tech9.net>,
       "" <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Re: Bug 619 - sched_best_cpu does not pick best cpu
 (1/1)
In-Reply-To: <200305142029.45413.habanero@us.ibm.com>
Message-ID: <Pine.LNX.4.50.0305142124440.19782-100000@montezuma.mastecende.com>
References: <3EB70EEC.9040004@us.ibm.com> <200305142029.45413.habanero@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 May 2003, Andrew Theurer wrote:

> +int nr_cpus_in_node[MAX_NUMNODES] = { [0 ... (MAX_NUMNODES -1)] = 0};
[snip...]
> +static inline int nr_cpus_node(int node)
> +{
> +	return nr_cpus_in_node[node];
> +}
> +
>  static inline int cpu_to_node(int cpu)
>  {
>  	int node;

How about an hweight() on node_to_cpumask?

	Zwane
-- 
function.linuxpower.ca

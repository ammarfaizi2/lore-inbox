Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751006AbWINSf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbWINSf1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 14:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751003AbWINSf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 14:35:26 -0400
Received: from tomts16.bellnexxia.net ([209.226.175.4]:54421 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1750708AbWINSf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 14:35:26 -0400
Date: Thu, 14 Sep 2006 14:35:23 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Ingo Molnar <mingo@elte.hu>
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060914183523.GA15178@Krystal>
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu> <Pine.LNX.4.64.0609141537120.6762@scrub.home> <20060914135548.GA24393@elte.hu> <Pine.LNX.4.64.0609141623570.6761@scrub.home> <20060914171320.GB1105@elte.hu> <Pine.LNX.4.64.0609141935080.6761@scrub.home> <20060914181557.GA22469@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20060914181557.GA22469@elte.hu>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 14:29:39 up 22 days, 15:38,  6 users,  load average: 0.40, 0.31, 0.28
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ingo Molnar (mingo@elte.hu) wrote:
> 
> that's not true, and this is the important thing that i believe you are 
> missing. A dynamic tracepoint is _detached_ from the normal source code 
> and thus is zero maintainance overhead. You dont have to maintain it 
> during normal development - only if you need it. You dont see the 
> dynamic tracepoints in the source code.
> 

What happen if someone need trace points in "normal kernel development" (which
appears to be the case, see blktrace and latency tracer) ?

> a static tracepoint, once it's in the mainline kernel, is a nonzero 
> maintainance overhead _until eternity_. It is a constant visual 
> hindrance and a constant build-correctness and boot-correctness problem 
> if you happen to change the code that is being traced by a static 
> tracepoint. Again, I am talking out of actual experience with static 
> tracepoints: i frequently break my kernel via static tracepoints and i 
> have constant maintainance cost from them. So what i do is that i try to 
> minimize the number of static tracepoints to _zero_. I.e. i only add 
> them when i need them for a given bug.
> 

What kind of code are you calling from your instrumentation sites to break your
kernel so easily ? Or perhaps are you instrumenting the page fault handler
which, yes, can have side effects? My goal is exctly to provide the kind of
code that can be called from any kernel site without breaking it!


Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 

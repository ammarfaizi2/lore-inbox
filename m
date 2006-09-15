Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751643AbWIOUAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751643AbWIOUAN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 16:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751654AbWIOUAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 16:00:13 -0400
Received: from tomts36-srv.bellnexxia.net ([209.226.175.93]:40404 "EHLO
	tomts36-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751643AbWIOUAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 16:00:11 -0400
Date: Fri, 15 Sep 2006 16:00:09 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Andrew Morton <akpm@osdl.org>
Cc: tglx@linutronix.de, karim@opersys.com, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>, Roman Zippel <zippel@linux-m68k.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060915200009.GB7133@Krystal>
References: <20060915132052.GA7843@localhost.usen.ad.jp> <Pine.LNX.4.64.0609151535030.6761@scrub.home> <20060915135709.GB8723@localhost.usen.ad.jp> <450AB5F9.8040501@opersys.com> <450AB506.30802@sgi.com> <450AB957.2050206@opersys.com> <20060915142836.GA9288@localhost.usen.ad.jp> <450ABE08.2060107@opersys.com> <1158332447.5724.423.camel@localhost.localdomain> <20060915111644.c857b2cf.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20060915111644.c857b2cf.akpm@osdl.org>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 15:50:30 up 23 days, 16:59,  2 users,  load average: 0.38, 0.41, 0.55
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> Of course, it they are properly designed, the one set of tracepoints could
> be used by different tracing backends - that allows us to separate the
> concepts of "tracepoints" and "tracing backends".

If I try to develop your idea a little further, we could this of dividing the
tracing problem into four layers :

- tracepoints (where the code is instrumented)
  - identifying code
  - accessing data surrounding the code
- tracing backend (how to add the tracepoints)
- tracing infrastructure (what code will serialize the information)
- data extraction (getting the data out to disk, network, ...)

I think that, if we agree on this segmentation of the problem, this thread is
generally debating on the tracing backends and their respective limitations.
I just want to point out that the patch I have submitted adresses mainly the
"tracing infrastructure" and "data extraction" topics.

Regards,

Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 

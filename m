Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030287AbWISRoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030287AbWISRoA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 13:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030393AbWISRoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 13:44:00 -0400
Received: from tomts20.bellnexxia.net ([209.226.175.74]:58822 "EHLO
	tomts20-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1030395AbWISRn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 13:43:58 -0400
Date: Tue, 19 Sep 2006 13:43:57 -0400
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Vara Prasad <prasadav@us.ibm.com>
Cc: "Martin J. Bligh" <mbligh@google.com>, Ingo Molnar <mingo@elte.hu>,
       "Frank Ch. Eigler" <fche@redhat.com>, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Linux Kernel Markers
Message-ID: <20060919174357.GB26339@Krystal>
References: <20060918234502.GA197@Krystal> <20060919081124.GA30394@elte.hu> <451008AC.6030006@google.com> <45101598.7050309@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <45101598.7050309@us.ibm.com>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 13:41:37 up 27 days, 14:50,  4 users,  load average: 0.88, 0.37, 0.22
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Vara Prasad (prasadav@us.ibm.com) wrote:
> It is an interesting idea but there appears to be following hard issues 
> (some of which you have already listed) i am not able to see how we can 
> overcome them
> 
> 1) We are going to have a duplicate of the whole function which means 
> any significant changes in the original function needs to be done on the 
> copy as well, you think maintainers would like this double work idea.
> 
Not with my marker proposal. There is only need to compile it with different
flags.

> 2) Inline functions is often the place where we need a fast path to 
> overcome the current kprobes overhead.
> 
> 3) As you said it is not trivial across all the platforms to do a switch 
> to the instrumented function from the original during the execution.  
> This problem is similar to the issue we are dealing with djprobes.
> 

I would really like to know how good djprobes is at instrumenting the
prologue of a function.

Mathieu

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 

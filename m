Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751978AbWISTWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978AbWISTWH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 15:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751979AbWISTWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 15:22:06 -0400
Received: from tomts25.bellnexxia.net ([209.226.175.188]:47591 "EHLO
	tomts25-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751978AbWISTWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 15:22:05 -0400
Date: Tue, 19 Sep 2006 15:16:52 -0400
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Vara Prasad <prasadav@us.ibm.com>
Cc: Martin Bligh <mbligh@google.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, "Frank Ch. Eigler" <fche@redhat.com>,
       Ingo Molnar <mingo@elte.hu>, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Linux Kernel Markers
Message-ID: <20060919191652.GC30556@Krystal>
References: <20060918234502.GA197@Krystal> <20060919081124.GA30394@elte.hu> <451008AC.6030006@google.com> <20060919154612.GU3951@redhat.com> <4510151B.5070304@google.com> <20060919093935.4ddcefc3.akpm@osdl.org> <45101DBA.7000901@google.com> <20060919063821.GB23836@in.ibm.com> <45102641.7000101@google.com> <4510413F.2030200@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <4510413F.2030200@us.ibm.com>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 15:14:38 up 27 days, 16:23,  6 users,  load average: 0.40, 0.23, 0.15
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Vara Prasad (prasadav@us.ibm.com) wrote:
> Martin Bligh wrote:
> 
> >[...]
> >Depends what we're trying to fix. I was trying to fix two things:
> >
> >1. Flexibility - kprobes seem unable to access all local variables etc
> >easily, and go anywhere inside the function. Plus keeping low overhead
> >for doing things like keeping counters in a function (see previous
> >example I mentioned for counting pages in shrink_list).
> >
> Using tools like systemtap on can consult DWARF information and put 
> probes in the middle of the function and access local variables as well, 
> that is not the real problem. The issue here is compiler doesn't seem to 
> generate required DWARF information in some cases due to optimizations.  
> The other related problem is when there exists debug information, the 
> way to specify the breakpoint location is using line number which is not 
> maintainable, having a marker solves this problem as well. Your proposal 
> still doesn't solve the need for markers if i understood correctly.
> 

His implementation makes a heavy use of a marker mechanism : this is exactly
what permits to create the instrumented objects from the same source code, but
with different #defines.

Mathieu
 
OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 

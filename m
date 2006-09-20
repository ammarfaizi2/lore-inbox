Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbWITRVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWITRVK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 13:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbWITRVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 13:21:10 -0400
Received: from tomts25-srv.bellnexxia.net ([209.226.175.188]:61124 "EHLO
	tomts25-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S932077AbWITRVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 13:21:08 -0400
Date: Wed, 20 Sep 2006 13:15:54 -0400
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Karim Yaghmour <karim@opersys.com>
Cc: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
       Martin Bligh <mbligh@google.com>, prasanna@in.ibm.com,
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
Message-ID: <20060920171554.GB18333@Krystal>
References: <4510151B.5070304@google.com> <20060919093935.4ddcefc3.akpm@osdl.org> <45101DBA.7000901@google.com> <20060919063821.GB23836@in.ibm.com> <45102641.7000101@google.com> <20060919070516.GD23836@in.ibm.com> <451030A6.6040801@google.com> <45105B5E.9080107@opersys.com> <451141B1.40803@hitachi.com> <451178B0.9030205@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <451178B0.9030205@opersys.com>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 13:14:44 up 28 days, 14:23,  5 users,  load average: 0.47, 0.47, 0.40
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Karim Yaghmour (karim@opersys.com) wrote:
> 
> Masami Hiramatsu wrote:
> > This method is very similar to the djprobe.
> > And I had gotten the same idea to support preemptive kernel.
> ...
> > This means the below code, doesn't this?
> > ---
> > 	jmp 1f /* short jump consumes 2 bytes */
> > 	nop
> > 	nop
> > 	nop
> > 1:
> 
> Actually this is slightly different (and requires more support
> on behalf of the underlying mechanism then what I was suggesting.)
> Basically, as was discussed elsewhere, there is some complex
> mechanisms required for taking care of the case where you got
> an interrupt at, say, the second or third nop. With the
> mechanism I'm suggesting (replacing a 5 byte jmp with a 5 byte
> jmp), the underlying mechanics do not require having to take
> care of the above-mentioned case.
> 

Karim, the jmp already there targets the end of the region : no possible
executioni of the three following nops. Clever :)

Mathieu

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 

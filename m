Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751321AbWIWQ5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbWIWQ5E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 12:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWIWQ5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 12:57:04 -0400
Received: from tomts10.bellnexxia.net ([209.226.175.54]:61633 "EHLO
	tomts10-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751321AbWIWQ5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 12:57:01 -0400
Date: Sat, 23 Sep 2006 12:51:35 -0400
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Martin Bligh <mbligh@google.com>, "Frank Ch. Eigler" <fche@redhat.com>,
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
Subject: Re: [PATCH] Linux Kernel Markers 0.5 for Linux 2.6.17 (with probe management)
Message-ID: <20060923165135.GA375@Krystal>
References: <20060921160009.GA30115@Krystal> <20060921160656.GA24774@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20060921160656.GA24774@elte.hu>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 12:50:16 up 31 days, 13:58,  2 users,  load average: 0.09, 0.19, 0.14
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ingo Molnar (mingo@elte.hu) wrote:
> but tracing a raw pagefault at the arch level is a bad idea anyway, we 
> want to trace __handle_mm_fault(). That way you can avoid having to 
> modify every architecture's pagefault handler ...
> 

The problem with __handle_mm_fault() is that the struct pt_regs * is not
passed to this function. An event containing both the address where the fault
occurs and the instruction pointer that caused the fault is very useful.

Mathieu

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 

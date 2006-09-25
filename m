Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751639AbWIYXS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639AbWIYXS6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 19:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751645AbWIYXS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 19:18:57 -0400
Received: from tomts40.bellnexxia.net ([209.226.175.97]:52920 "EHLO
	tomts40-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751639AbWIYXS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 19:18:56 -0400
Date: Mon, 25 Sep 2006 19:13:43 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Martin Bligh <mbligh@google.com>, "Frank Ch. Eigler" <fche@redhat.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Karim Yaghmour <karim@opersys.com>,
       Pavel Machek <pavel@suse.cz>, Joe Perches <joe@perches.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       "Jose R. Santos" <jrs@us.ibm.com>
Subject: Re: [PATCH] Linux Kernel Markers 0.11 for 2.6.17
Message-ID: <20060925231343.GA12011@Krystal>
References: <20060925151028.GA14695@Krystal> <45181CE9.1080204@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <45181CE9.1080204@goop.org>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 19:04:52 up 33 days, 20:13,  5 users,  load average: 0.01, 0.11, 0.14
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jeremy Fitzhardinge (jeremy@goop.org) wrote:
> If you're going to put different types in the .markers section 
> (presumably per-architecture, rather than different types for within one 
> architecture) you should probably also define a structure in the same 
> place, if nothing
> 

For now, I only expect two kinds of structures :

One for the architectures which implements the MARK_JUMP optimisation and one
where they don't. Does it make sense to assume that each architecture will offer
the possibility to write a 1 byte offset calculated from the difference between
two addresses ? If not, then, it can be useful to think of a per archtecture
structure, but module.c shall be modified accordingly too. So for now, I would
stay with only one definition in linux/marker.h and if we see the need for it,
we can put the structures in asm-*/marker.h and adapt module.c per architecture
accordingly (probably by using a macro).

Mathieu

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 

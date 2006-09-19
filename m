Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751044AbWISTg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbWISTg2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 15:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751958AbWISTg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 15:36:28 -0400
Received: from tomts22.bellnexxia.net ([209.226.175.184]:21233 "EHLO
	tomts22-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751044AbWISTg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 15:36:27 -0400
Date: Tue, 19 Sep 2006 15:36:24 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: "Frank Ch. Eigler" <fche@redhat.com>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>,
       Douglas Niehaus <niehaus@eecs.ku.edu>, Tom Zanussi <zanussi@us.ibm.com>,
       Paul Mundt <lethal@linux-sh.org>, Jes Sorensen <jes@sgi.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       systemtap@sources.redhat.com, ltt-dev@shafik.org
Subject: Re: [PATCH] Linux Kernel Markers 0.2 for Linux 2.6.17
Message-ID: <20060919193623.GA9459@Krystal>
References: <20060919183447.GA16095@Krystal> <y0m4pv3ek49.fsf@ton.toronto.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <y0m4pv3ek49.fsf@ton.toronto.redhat.com>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 15:32:14 up 27 days, 16:40,  6 users,  load average: 1.98, 1.32, 0.68
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Frank Ch. Eigler (fche@redhat.com) wrote:
> If you don't allow yourself to presume on-the-fly function
> recompilation, then these markers would need to be made run-time
> rather than compile-time configurable.  That is, not like this:
> 
> > +/* Menu configured markers */
> > +#ifndef CONFIG_MARK
> > +#define MARK	MARK_INACTIVE
> > +#elif defined(CONFIG_MARK_PRINT)
> > +#define MARK	MARK_PRINT
> > +#elif defined(CONFIG_MARK_FPROBE)
> > +#define MARK	MARK_FPROBE
> > +#elif defined(CONFIG_MARK_KPROBE)
> > +#define MARK	MARK_KPROBE
> > +#elif defined(CONFIG_MARK_JPROBE)
> > +#define MARK	MARK_JPROBE
> > +#endif

By making them run-time configurable, I don't see any whay not to bloat the
kernel. How can be embed calls to printk+function+kprobe+djprobe without
having some kind of performance impact ?

Do you have any suggestion for this ? (or maybe am I missing your point ?)

Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 

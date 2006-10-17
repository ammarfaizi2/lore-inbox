Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbWJQTYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbWJQTYn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 15:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbWJQTYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 15:24:43 -0400
Received: from tomts5.bellnexxia.net ([209.226.175.25]:44268 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751181AbWJQTYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 15:24:42 -0400
Date: Tue, 17 Oct 2006 15:19:24 -0400
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, mbligh@google.com, fche@redhat.com,
       masami.hiramatsu.pt@hitachi.com, prasanna@in.ibm.com, akpm@osdl.org,
       mingo@elte.hu, lethal@linux-sh.org, linux-kernel@vger.kernel.org,
       jes@sgi.com, zanussi@us.ibm.com, richardj_moore@uk.ibm.com,
       michel.dagenais@polymtl.ca, hch@infradead.org, gregkh@suse.de,
       tglx@linutronix.de, wcohen@redhat.com, ltt-dev@shafik.org,
       systemtap@sources.redhat.com, alan@lxorguk.ukuu.org.uk,
       karim@opersys.com, pavel@suse.cz, joe@perches.com, rdunlap@xenotime.net,
       jrs@us.ibm.com
Subject: Re: [PATCH] Linux Kernel Markers 0.20 for 2.6.17
Message-ID: <20061017191924.GA14092@Krystal>
References: <20060930180443.GB25761@Krystal> <20061018.005122.07644172.anemo@mba.ocn.ne.jp> <453522B1.7040103@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <453522B1.7040103@goop.org>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 15:17:42 up 55 days, 16:26,  5 users,  load average: 0.53, 0.35, 0.41
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jeremy Fitzhardinge (jeremy@goop.org) wrote:
> Atsushi Nemoto wrote:
> >When I compiled this with gcc 4.1.1 (mips), ".markers" section was
> >empty.
> >
> >I suppose "unused" attribute is not suitable for modern gcc.  Maybe
> >__attribute_used__ should be used?
> >  
> 
> It should be, but it still won't work.  There's a gcc bug which ignores 
> the attribute for local-scope static variables:  
> http://gcc.gnu.org/bugzilla/show_bug.cgi?id=29299
> 
> 
>    J
> 

I guess the correct way to handle it will be to put a "used" attribute in the
asm-generic/marker.h code, remove the unnecessary "unused" attribute in
asm-powerpc/marker.h and tell people to upgrade their gcc when it is broken.
The other way around would be to make the macro "use" the structure somewhere
without any impact.

Mathieu

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 

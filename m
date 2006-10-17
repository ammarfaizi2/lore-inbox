Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751414AbWJQSgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbWJQSgr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 14:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbWJQSgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 14:36:44 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:41955 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751414AbWJQSgk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 14:36:40 -0400
Message-ID: <453522B1.7040103@goop.org>
Date: Tue, 17 Oct 2006 11:36:33 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC: compudj@krystal.dyndns.org, mbligh@google.com, fche@redhat.com,
       masami.hiramatsu.pt@hitachi.com, prasanna@in.ibm.com, akpm@osdl.org,
       mingo@elte.hu, mathieu.desnoyers@polymtl.ca, lethal@linux-sh.org,
       linux-kernel@vger.kernel.org, jes@sgi.com, zanussi@us.ibm.com,
       richardj_moore@uk.ibm.com, michel.dagenais@polymtl.ca,
       hch@infradead.org, gregkh@suse.de, tglx@linutronix.de,
       wcohen@redhat.com, ltt-dev@shafik.org, systemtap@sources.redhat.com,
       alan@lxorguk.ukuu.org.uk, karim@opersys.com, pavel@suse.cz,
       joe@perches.com, rdunlap@xenotime.net, jrs@us.ibm.com
Subject: Re: [PATCH] Linux Kernel Markers 0.20 for 2.6.17
References: <20060930180443.GB25761@Krystal> <20061018.005122.07644172.anemo@mba.ocn.ne.jp>
In-Reply-To: <20061018.005122.07644172.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Atsushi Nemoto wrote:
> When I compiled this with gcc 4.1.1 (mips), ".markers" section was
> empty.
>
> I suppose "unused" attribute is not suitable for modern gcc.  Maybe
> __attribute_used__ should be used?
>   

It should be, but it still won't work.  There's a gcc bug which ignores 
the attribute for local-scope static variables:  
http://gcc.gnu.org/bugzilla/show_bug.cgi?id=29299


    J


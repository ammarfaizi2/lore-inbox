Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751186AbWJQTcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbWJQTcZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 15:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbWJQTcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 15:32:25 -0400
Received: from gw.goop.org ([64.81.55.164]:54214 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751186AbWJQTcY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 15:32:24 -0400
Message-ID: <4535318B.2050408@goop.org>
Date: Tue, 17 Oct 2006 12:39:55 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
CC: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, mbligh@google.com, fche@redhat.com,
       masami.hiramatsu.pt@hitachi.com, prasanna@in.ibm.com, akpm@osdl.org,
       mingo@elte.hu, lethal@linux-sh.org, linux-kernel@vger.kernel.org,
       jes@sgi.com, zanussi@us.ibm.com, richardj_moore@uk.ibm.com,
       michel.dagenais@polymtl.ca, hch@infradead.org, gregkh@suse.de,
       tglx@linutronix.de, wcohen@redhat.com, ltt-dev@shafik.org,
       systemtap@sources.redhat.com, alan@lxorguk.ukuu.org.uk,
       karim@opersys.com, pavel@suse.cz, joe@perches.com, rdunlap@xenotime.net,
       jrs@us.ibm.com
Subject: Re: [PATCH] Linux Kernel Markers 0.20 for 2.6.17
References: <20060930180443.GB25761@Krystal> <20061018.005122.07644172.anemo@mba.ocn.ne.jp> <453522B1.7040103@goop.org> <20061017191924.GA14092@Krystal>
In-Reply-To: <20061017191924.GA14092@Krystal>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Desnoyers wrote:
> I guess the correct way to handle it will be to put a "used" attribute in the
> asm-generic/marker.h code, remove the unnecessary "unused" attribute in
> asm-powerpc/marker.h and tell people to upgrade their gcc when it is broken.
>   

It's subtle because it quietly drops the section with no other 
symptoms.  It could slip by unnoticed for quite a while.

> The other way around would be to make the macro "use" the structure somewhere
> without any impact.
>   
asm volatile("" : : "m" (thing));

    J

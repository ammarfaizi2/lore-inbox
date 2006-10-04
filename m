Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932395AbWJDHEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbWJDHEq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 03:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbWJDHEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 03:04:46 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:63433
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932395AbWJDHEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 03:04:45 -0400
Message-Id: <45237973.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Wed, 04 Oct 2006 08:05:55 +0100
From: "Jan Beulich" <jbeulich@novell.com>
To: "Ingo Molnar" <mingo@elte.hu>, "Andi Kleen" <ak@suse.de>
Cc: <tilman@imap.cc>, "Andrew Morton" <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, "Randy Dunlap" <rdunlap@xenotime.net>
Subject: Re: [2.6.18-rc7-mm1] slow boot
References: <4516B966.3010909@imap.cc>
 <20060924145337.ae152efd.akpm@osdl.org> <451BFFA9.4030000@imap.cc>
 <200609281912.01858.ak@suse.de> <451C58AC.5060601@imap.cc>
 <20060928163046.055b3ce0.rdunlap@xenotime.net>
 <20060928163046.055b3ce0.rdunlap@xenotime.net> <451C65A0.1080002@imap.cc>
 <451CE2F0.76E4.0078.0@novell.com> <p73lko2ircn.fsf@verdi.suse.de>
 <20060929183959.GA13991@elte.hu>
In-Reply-To: <20060929183959.GA13991@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Ingo Molnar <mingo@elte.hu> 29.09.06 20:39 >>>
>
>* Andi Kleen <ak@suse.de> wrote:
>
>> "Jan Beulich" <jbeulich@novell.com> writes:
>> 
>> > There's nothing stack trace/unwind related among the functions listed at all afaics.
>> > I don't know much about how profiling works, is it perhaps just missing something?
>> 
>> Perhaps lockdep calls them with interrupts off? The old profiler 
>> doesn't support profiling with interrupts off. oprofile does, but it 
>> cannot be used at early boot.
>
>Yes, lockdep does everything that changes the dependency graph(s) with 
>irqs off. Jan, i bounced you the mail with the function traces included, 
>that should show you the overhead points.

Okay, makes sense then. I'll get to addressing the (already identified) cause
as soon as I can.

Jan

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161106AbWI2QNL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161106AbWI2QNL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 12:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161098AbWI2QNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 12:13:11 -0400
Received: from ns2.suse.de ([195.135.220.15]:51875 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932318AbWI2QNG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 12:13:06 -0400
To: "Jan Beulich" <jbeulich@novell.com>
Cc: "Ingo Molnar" <mingo@elte.hu>, "Andrew Morton" <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, "Randy Dunlap" <rdunlap@xenotime.net>,
       tilman@imap.cc
Subject: Re: [2.6.18-rc7-mm1] slow boot
References: <4516B966.3010909@imap.cc> <20060924145337.ae152efd.akpm@osdl.org>
	<451BFFA9.4030000@imap.cc> <200609281912.01858.ak@suse.de>
	<451C58AC.5060601@imap.cc>
	<20060928163046.055b3ce0.rdunlap@xenotime.net>
	<20060928163046.055b3ce0.rdunlap@xenotime.net>
	<451C65A0.1080002@imap.cc> <451CE2F0.76E4.0078.0@novell.com>
From: Andi Kleen <ak@suse.de>
Date: 29 Sep 2006 18:12:56 +0200
In-Reply-To: <451CE2F0.76E4.0078.0@novell.com>
Message-ID: <p73lko2ircn.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jan Beulich" <jbeulich@novell.com> writes:

> There's nothing stack trace/unwind related among the functions listed at all afaics.
> I don't know much about how profiling works, is it perhaps just missing something?

Perhaps lockdep calls them with interrupts off?
The old profiler doesn't support profiling with interrupts off.
oprofile does, but it cannot be used at early boot.

-Andi

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbVH3LNx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbVH3LNx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 07:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbVH3LNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 07:13:53 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:18140 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751373AbVH3LNx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 07:13:53 -0400
Date: Tue, 30 Aug 2005 13:14:28 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.52-01
Message-ID: <20050830111428.GA14363@elte.hu>
References: <1123035909.11101.1.camel@c-67-188-6-232.hsd1.ca.comcast.net> <1123036936.1590.69.camel@localhost.localdomain> <1123037933.11101.11.camel@c-67-188-6-232.hsd1.ca.comcast.net> <1123080606.1590.119.camel@localhost.localdomain> <1123087447.1590.136.camel@localhost.localdomain> <20050812125844.GA13357@elte.hu> <1125030249.5365.23.camel@localhost.localdomain> <20050826060815.GB17783@elte.hu> <1125055250.5365.33.camel@localhost.localdomain> <1125399509.1910.6.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125399509.1910.6.camel@sisko.sctweedie.blueyonder.co.uk>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Stephen C. Tweedie <sct@redhat.com> wrote:

> On Fri, 2005-08-26 at 12:20, Steven Rostedt wrote:
> 
> > > could you try a), how clean does it get? Personally i'm much more in 
> > > favor of cleanliness. On the vanilla kernel a spinlock is zero bytes on 
> > > UP [the most RAM-sensitive platform], and it's a word on typical SMP.
> 
> It's a word, maybe; but it's a word used only by ext3 afaik, and it's 
> getting added to the core buffer_head.  Not very nice.  It certainly 
> looks like the easiest short-term way out for a development patch 
> series, though.

but ext3 is pretty much the only mainstream FS that still makes use of 
buffer_heads, so it should be fine. Any other solution looks _way_ too 
hacky - and the current bit-spin-lock solution is less than charming 
too.

	Ingo

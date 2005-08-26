Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932522AbVHZGHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932522AbVHZGHz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 02:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932523AbVHZGHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 02:07:55 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:42217 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932522AbVHZGHy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 02:07:54 -0400
Date: Fri, 26 Aug 2005 08:08:15 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.52-01
Message-ID: <20050826060815.GB17783@elte.hu>
References: <1123011928.1590.43.camel@localhost.localdomain> <1123025895.25712.7.camel@dhcp153.mvista.com> <1123027226.1590.59.camel@localhost.localdomain> <1123035909.11101.1.camel@c-67-188-6-232.hsd1.ca.comcast.net> <1123036936.1590.69.camel@localhost.localdomain> <1123037933.11101.11.camel@c-67-188-6-232.hsd1.ca.comcast.net> <1123080606.1590.119.camel@localhost.localdomain> <1123087447.1590.136.camel@localhost.localdomain> <20050812125844.GA13357@elte.hu> <1125030249.5365.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125030249.5365.23.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> So, the only other solutions that I can think of is:
> 
> a) add yet another (bloat) lock to the buffer head.
> 
> b) Still use your b_update_lock for the jbd_lock_bh_journal_head and 
> change the jbd_lock_bh_state to what I discussed earlier, and that 
> being the hash wait_on_bit code.

could you try a), how clean does it get? Personally i'm much more in 
favor of cleanliness. On the vanilla kernel a spinlock is zero bytes on 
UP [the most RAM-sensitive platform], and it's a word on typical SMP.

	Ingo

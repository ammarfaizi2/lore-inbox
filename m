Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750960AbWBPV4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbWBPV4x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 16:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932561AbWBPV4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 16:56:53 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:40921 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750960AbWBPV4x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 16:56:53 -0500
Date: Thu, 16 Feb 2006 22:55:05 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Christopher Friesen <cfriesen@nortel.com>
Cc: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       Ulrich Drepper <drepper@redhat.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 0/6] lightweight robust futexes: -V3
Message-ID: <20060216215505.GB2612@elte.hu>
References: <20060216094130.GA29716@elte.hu> <1140107585.21681.18.camel@localhost.localdomain> <20060216172435.GC29151@elte.hu> <1140111257.21681.26.camel@localhost.localdomain> <20060216202357.GA21415@elte.hu> <Pine.LNX.4.64.0602161229390.30911@dhcp153.mvista.com> <20060216212651.GB25738@elte.hu> <43F4F397.5000704@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F4F397.5000704@nortel.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Christopher Friesen <cfriesen@nortel.com> wrote:

> Ingo Molnar wrote:
> 
> >basically, ->futex_offset is not blindly trusted by the kernel either: 
> >it's simply used to calculate a "userspace pointer" value, which it then 
> >uses in a (secure) get_user() access, to do a FUTEX_WAKEUP. [Note that 
> >FUTEX_WAKEUP is already done at do_exit() time via the ->clear_child_tid 
> >userspace pointer.] All in one: this is totally safe.
> 
> As mentioned by Paul...how do you deal with 32/64 compatibility where 
> your pointers are different sizes?

i just replied to Paul's mail with details about this. (Please reply to 
that mail if there are any open questions.)

	Ingo

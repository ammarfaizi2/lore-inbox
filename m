Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbVH3LBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbVH3LBR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 07:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbVH3LBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 07:01:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:21421 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751362AbVH3LBQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 07:01:16 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.52-01
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <1125030249.5365.23.camel@localhost.localdomain>
References: <1122944010.6759.64.camel@localhost.localdomain>
	 <20050802101920.GA25759@elte.hu>
	 <1123011928.1590.43.camel@localhost.localdomain>
	 <1123025895.25712.7.camel@dhcp153.mvista.com>
	 <1123027226.1590.59.camel@localhost.localdomain>
	 <1123035909.11101.1.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <1123036936.1590.69.camel@localhost.localdomain>
	 <1123037933.11101.11.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <1123080606.1590.119.camel@localhost.localdomain>
	 <1123087447.1590.136.camel@localhost.localdomain>
	 <20050812125844.GA13357@elte.hu>
	 <1125030249.5365.23.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1125399648.1910.9.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Tue, 30 Aug 2005 12:00:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2005-08-26 at 05:24, Steven Rostedt wrote:

> Well, I just spent several hours trying to use the b_update_lock in
> implementing something to replace the bit spinlocks for RT.  It's
> getting really ugly and I just hit a stone wall.
> 
> The problem is that I have two locks to work with. A
> jbd_lock_bh_journal_head and a jbd_lock_bh_state.  ...

For now, yes.

> So, the only other solutions that I can think of is:
> 
> a) add yet another (bloat) lock to the buffer head.

This one looks like the right answer for now, just to get the patch
series running.  I've got a WIP patch under development which removes
the bh_journal_head lock entirely; if that works out, you may find
things get a bit easier.

--Stephen


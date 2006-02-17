Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751447AbWBQV7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbWBQV7l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 16:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbWBQV7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 16:59:41 -0500
Received: from nevyn.them.org ([66.93.172.17]:3539 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S1751447AbWBQV7k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 16:59:40 -0500
Date: Fri, 17 Feb 2006 16:59:33 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       drepper@redhat.com, tglx@linutronix.de, arjan@infradead.org,
       dsingleton@mvista.com
Subject: Re: [patch 0/5] lightweight robust futexes: -V1
Message-ID: <20060217215933.GA1874@nevyn.them.org>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	drepper@redhat.com, tglx@linutronix.de, arjan@infradead.org,
	dsingleton@mvista.com
References: <20060215151711.GA31569@elte.hu> <20060215134556.57cec83a.akpm@osdl.org> <20060215221434.GA20104@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060215221434.GA20104@elte.hu>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2006 at 11:14:34PM +0100, Ingo Molnar wrote:
> > Why do we need sys_get_robust_list(other task)?
> 
> just for completeness for debuggers - when i added the TLS syscalls 
> debugging people complained that there was no easy way to query the TLS 
> settings of a thread. I didnt want to add yet another ptrace op - but 
> maybe that's the right solution? ptrace is a bit clumsy for things like 
> this - the task might not be ptrace-able, while querying the list head 
> is such an easy thing.

If it isn't ptraceable, then why should we need to ask the kernel for a
pointer into its memory?  Except maybe for attacking it :-)

-- 
Daniel Jacobowitz
CodeSourcery

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267856AbUJLVYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267856AbUJLVYu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 17:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267860AbUJLVYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 17:24:50 -0400
Received: from smtp.Lynuxworks.com ([207.21.185.24]:62991 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S267856AbUJLVYg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 17:24:36 -0400
Date: Tue, 12 Oct 2004 14:24:08 -0700
To: Bill Huey <bhuey@lnxw.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, dwalker@mvista.com,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       amakarov@ru.mvista.com, ext-rt-dev@mvista.com,
       LKML <linux-kernel@vger.kernel.org>, "Bill Huey (hui)" <bhuey@lnxw.com>
Subject: Re: [Ext-rt-dev] Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
Message-ID: <20041012212408.GA28707@nietzsche.lynx.com>
References: <41677E4D.1030403@mvista.com> <20041010084633.GA13391@elte.hu> <1097437314.17309.136.camel@dhcp153.mvista.com> <20041010142000.667ec673.akpm@osdl.org> <20041010215906.GA19497@elte.hu> <1097517191.28173.1.camel@dhcp153.mvista.com> <20041011204959.GB16366@elte.hu> <1097607049.9548.108.camel@dhcp153.mvista.com> <1097610393.19549.69.camel@thomas> <20041012211201.GA28590@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041012211201.GA28590@nietzsche.lynx.com>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2004 at 02:12:01PM -0700, Bill Huey wrote:
> On Tue, Oct 12, 2004 at 09:46:34PM +0200, Thomas Gleixner wrote:
> > enter_critical_section(TYPE, &var, &flags, whatever);
> > leave_critical_section(TYPE, &var, flags, whatever);
> 
> FreeBSD uses these things, but it they create severe pipeline stalls
> since they toggle interrupt flags on entry and exit. The current scheme
> in Linux with preempt_count use to be a curse when I was working on an
> equivalent implementation of there stuff at:
> 
> 	http://mmlinux.sf.net

Duh, I didn't finish the sentence. I meant this method above is nasty
filled with pipeline stalls. Don't know if that's what were saying, but
non-preemptable critical sections denoted by preempt_count must have some
kind of conceptual overlap with local_irq* functions. I use to curse the
seperation of the two since it made my own conception irregular, but I
have come to the conclusion that using relatively something light weight
like preempt_count() for that functionality instead. That's what I
meant. :)

bill


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261796AbVE3Wqs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbVE3Wqs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 18:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261803AbVE3Wpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 18:45:38 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:14091 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S261804AbVE3Woy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 18:44:54 -0400
Date: Mon, 30 May 2005 15:49:49 -0700
To: Karim Yaghmour <karim@opersys.com>
Cc: "Bill Huey (hui)" <bhuey@lnxw.com>, Esben Nielsen <simlo@phys.au.dk>,
       Nick Piggin <nickpiggin@yahoo.com.au>, kus Kusche Klaus <kus@keba.com>,
       James Bruce <bruce@andrew.cmu.edu>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050530224949.GE9972@nietzsche.lynx.com>
References: <Pine.OSF.4.05.10505301934001.31148-100000@da410.phys.au.dk> <429B61F7.70608@opersys.com> <20050530223434.GC9972@nietzsche.lynx.com> <429B9880.1070604@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429B9880.1070604@opersys.com>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2005 at 06:49:36PM -0400, Karim Yaghmour wrote:
> Bill Huey (hui) wrote:
> >>From my memory DRM drivers have direct path to the vertical retrace
> > through the current ioctl() interface. It's not an issue for that driver
> > and probably many others that use simple syscalls like that.
> 
> This is rather short. Can you elaborate a little on what you're trying
> to say here? thanks.

Paths entering back into userspace are simple like the use of read() to
respond to events.

> I didn't say the RT patch was hard to maintain. I said that it increased
> the cost of maintenance for the rest of the kernel (which is the feeling
> that seems to be echoed by other peoples' answers in this thread.)

Sorry, the RT patch really doesn't effect general kernel development
dramatically. It's just exploiting SMP work already in place to get data
safety and the like. It does however kill all bogus points in the kernel
that spin-waits for something to happen, which is a positive thing for the
kernel in general since it indicated sloppy code. If anything it makes the
kernel code cleaner.

This is last day of vacation, but it doesn't feel like it unfortunately :}

bill


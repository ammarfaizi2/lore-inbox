Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbWI3IhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbWI3IhE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 04:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWI3Igt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 04:36:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61855 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751087AbWI3Igh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 04:36:37 -0400
Date: Sat, 30 Sep 2006 01:36:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: Re: [patch 03/23] GTOD: persistent clock support, i386
Message-Id: <20060930013612.92e12313.akpm@osdl.org>
In-Reply-To: <20060929234439.158061000@cruncher.tec.linutronix.de>
References: <20060929234435.330586000@cruncher.tec.linutronix.de>
	<20060929234439.158061000@cruncher.tec.linutronix.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2006 23:58:22 -0000
Thomas Gleixner <tglx@linutronix.de> wrote:

> persistent clock support: do proper timekeeping across suspend/resume,
> i386 arch support.
> 

This description implies that the patch implements something for i386

>  arch/i386/kernel/apm.c  |   44 ---------------------------------------
>  arch/i386/kernel/time.c |   54 +---------------------------------------------

but all it does is delete stuff.

I _assume_ that it switches i386 over to using the (undescribed) generic
core, and it does that merely by implementing read_persistent_clock().

But I'd have expected to see some Kconfig change in there as well?

Does this implementation support all forms of persistent clock which are
known to exist on i386 platforms?

If/when you issue new changelogs, please describe what has to be done to
port other architectures over to use this overall framework.

Do ports for other architectures exist?

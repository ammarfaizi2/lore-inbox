Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261452AbSJUQWC>; Mon, 21 Oct 2002 12:22:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261457AbSJUQWC>; Mon, 21 Oct 2002 12:22:02 -0400
Received: from zero.aec.at ([193.170.194.10]:31251 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S261452AbSJUQWB>;
	Mon, 21 Oct 2002 12:22:01 -0400
Date: Mon, 21 Oct 2002 18:26:16 +0200
From: Andi Kleen <ak@muc.de>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Andrea Arcangeli <andrea@suse.de>, Andi Kleen <ak@muc.de>,
       Jeff Dike <jdike@karaya.com>, john stultz <johnstul@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>,
       george anzinger <george@mvista.com>
Subject: Re: [PATCH] linux-2.5.43_vsyscall_A0
Message-ID: <20021021162616.GA9368@averell>
References: <20021019031002.GA16404@averell> <200210190450.XAA06161@ccure.karaya.com> <20021019041019.GI23930@dualathlon.random> <20021019044556.GA22201@averell> <20021019050139.GM23930@dualathlon.random> <1035215009.1209.1.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1035215009.1209.1.camel@dell_ss3.pdx.osdl.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2002 at 05:43:29PM +0200, Stephen Hemminger wrote:
> Would it be possible to allow UML to use mmap to put an alternative text
> page at the fixed address with the UML appropriate version of the
> vsyscall?
nly with lots of special cases in the VM. vsyscall is currently located
in the kernel fixing, giving user mmap access to kernel mappings
would need quite some changes.

Global sysctl is much easier and safer. As soon as x86-64 gets useful
vsyscalls again I will implement it (as I said earlier it is currently
turned off because of problems with the timers)

-Andi


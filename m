Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263089AbRGBKL7>; Mon, 2 Jul 2001 06:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263031AbRGBKLs>; Mon, 2 Jul 2001 06:11:48 -0400
Received: from smtp.mailbox.co.uk ([195.82.125.32]:10447 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S262997AbRGBKLm>; Mon, 2 Jul 2001 06:11:42 -0400
Date: Mon, 2 Jul 2001 10:41:34 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Riley Williams <rhw@memalpha.cx>
Cc: Keith Owens <kaos@ocs.com.au>, Adam J Richter <adam@yggdrasil.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: 2.4.6p6: dep_{bool,tristate} $CONFIG_ARCH_xxx bugs
Message-ID: <20010702104134.A28123@flint.arm.linux.org.uk>
In-Reply-To: <26219.994058622@kao2.melbourne.sgi.com> <Pine.LNX.4.33.0107020827060.18977-101000@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0107020827060.18977-101000@infradead.org>; from rhw@MemAlpha.CX on Mon, Jul 02, 2001 at 09:25:50AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2001 at 09:25:50AM +0100, Riley Williams wrote:
>  Q> dep_arch_tristate '  AM79C961A support' CONFIG_ARM_AM79C961A \
>  Q>	ACORN $CONFIG_NET_ETHERNET

Before we go and create a patch for Linus to apply, please note that the
above is totally bogus and is in fact 100% wrong.  Don't create a patch
yourself.  Let me know how you propose to do it, and I will create the
patch using the correct symbols.

Also note that the majority of the machine-dependent symbols for StrongARM
platforms (of which there are around 43) start CONFIG_SA1100_*, not
CONFIG_ARCH_*.  Unfortunately, its far too late to get around this
special case (I'm not too happy that we have this special case either,
so don't whinge at me please).

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


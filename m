Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268206AbRHCKHy>; Fri, 3 Aug 2001 06:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268382AbRHCKHo>; Fri, 3 Aug 2001 06:07:44 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:41633 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S268206AbRHCKHZ>; Fri, 3 Aug 2001 06:07:25 -0400
Message-ID: <3B6A78C1.7A1B13AB@veritas.com>
Date: Fri, 03 Aug 2001 15:41:13 +0530
From: "Amit S. Kale" <akale@veritas.com>
Organization: Veritas Software (India)
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jalaja devi <jala_74@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: kgdb ksymtab_addr not found!!
In-Reply-To: <20010802174730.76395.qmail@web13704.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jalaja devi wrote:
> 
> Hi,
> 
> I have 2 quesions here:
> 
> 1. Could any plz tell me what am i missing out here?
> 
> I basically, trying to debug my my loadable module in
> kernel in kernel2.4.6 version. I patched the kernel
> with 2.4.6 kgdb patch, using the recent version.
> 
> I am using the modutils shell script to load my module
> loadmodule.sh which creates a gdbscript. When I source
> the gdbscript I get the following warnings:
> 
> warning : section _ksymtab not found in mymodule.o
> warning : section _archdata not found in mymodule.o
> 
> Do I need to patch the kernel with the modutils. Why
> do I get these warnings.

These warnings can be safely ignored.

> 
> 2. How can I put a breakpoint to debug my init_module?
> Which is the Kernel Fxn to be invoked to put a
> breakpoint in my init_module?

You can place a breakpoint just before the the statement
where kernel calls init_module. Then load the generated
gdb script into gdb once the breakpoint is hit. Now you
can place a breakpoint directly into any statement in the
module code.


> 
> Thanks in advance,
> 
> Jalaja
> 
> __________________________________________________
> Do You Yahoo!?
> Make international calls for as low as $.04/minute with Yahoo! Messenger
> http://phonecard.yahoo.com/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Amit Kale
Veritas Software ( http://www.veritas.com )

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283618AbRK3L20>; Fri, 30 Nov 2001 06:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283619AbRK3L2R>; Fri, 30 Nov 2001 06:28:17 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:53777 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S283618AbRK3L2F>;
	Fri, 30 Nov 2001 06:28:05 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Gianni Tedesco <gianni@ecsc.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PANIC]: Panic out of the blue in timer_bh (possibly bogus) 
In-Reply-To: Your message of "30 Nov 2001 09:49:50 -0000."
             <1007113790.22600.0.camel@lemsip> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 30 Nov 2001 22:27:51 +1100
Message-ID: <4594.1007119671@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Nov 2001 09:49:50 +0000, 
Gianni Tedesco <gianni@ecsc.co.uk> wrote:
>Ksymoops gives a couple of warnings, im not sure exactly how relevent
>they are but I'm pretty damn sure its using the correct ksyms/system.map
>etc.
>
>Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base
>says c029b670, System.map says c014e3e0.  Ignoring ksyms_base entry

Two symbols called partition_name, one of which is exported.  Can you
say "bad choice of name"?

>Warning (compare_maps): mismatch on symbol tulip_max_interrupt_work  ,
>tulip says d09a26ec, /lib/modules/2.4.9/kernel/drivers/net/tulip/tulip.o
>says d09a1cac.  Ignoring
>/lib/modules/2.4.9/kernel/drivers/net/tulip/tulip.o entry
>Warning (compare_maps): mismatch on symbol tulip_rx_copybreak  , tulip
>says d09a26f0, /lib/modules/2.4.9/kernel/drivers/net/tulip/tulip.o says
>d09a1cb0.  Ignoring /lib/modules/2.4.9/kernel/drivers/net/tulip/tulip.o
>entry

Bug in address calculation for exported bss symbols, fixed in ksymoops
2.4.2.


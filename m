Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268947AbUIQPyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268947AbUIQPyV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 11:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268828AbUIQPvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 11:51:52 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:45229 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S268881AbUIQPoU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 11:44:20 -0400
From: Jon Mason <jdmason@us.ibm.com>
Organization: IBM
To: Francois Romieu <romieu@fr.zoreil.com>
Subject: Re: 2.6.9-rc1-bk11+ and 2.6.9-rc1-mm3,4 r8169: freeze during boot (FIX included)
Date: Fri, 17 Sep 2004 10:43:21 -0500
User-Agent: KMail/1.6.2
Cc: Hans-Frieder Vogt <hfvogt@arcor.de>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com, netdev@oss.sgi.com
References: <200409130035.50823.hfvogt@arcor.de> <20040916070211.GA32592@electric-eye.fr.zoreil.com> <200409161320.16526.jdmason@us.ltcfwd.linux.ibm.com>
In-Reply-To: <200409161320.16526.jdmason@us.ltcfwd.linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409171043.21772.jdmason@us.ltcfwd.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 September 2004 01:20 pm, Jon Mason wrote:
> > Jon, if your ppc64 box offers 64 bits wide PCI slots, it would be nice if
> > you could ttry 2.6.9-rc2-bkX, apply
> > http://www.fr.zoreil.com/people/francois/misc/r8169-xx0.patch
> > and report the content of the "Config2" line in the logs of the kernel.
>
> Here is the info you requested:
>
> r8169 Gigabit Ethernet driver 1.6LK loaded
> eth8: Identified chip type is 'RTL8169s/8110s'.
> eth8: RTL8169 at 0xa0000000800b7000, 00:40:f4:96:fc:3f, IRQ 131
> r8169: eth8: Config2 = 0x01
> r8169: eth8: link up
>
> My p630 has 64bit PCI-X slots, but my r8169 adapter is a 32bit adapter. 
> See lspci output below (with a 64bit PCI-X e1000 adapter as a comparison).
> .....
> 0001:61:01.1 Ethernet controller: Intel Corp. 82546GB Gigabit Ethernet
> Controller (rev 03)
>         Subsystem: IBM: Unknown device 0289
>         Flags: bus master, 66Mhz, medium devsel, latency 144, IRQ 122
>         Memory at cc100000 (64-bit, non-prefetchable) [size=cc000000]
>         Memory at cc040000 (64-bit, non-prefetchable) [size=256K]
>         I/O ports at 12ec00 [size=64]
>         Expansion ROM at 00040000 [disabled]
>         Capabilities: [dc] Power Management version 2
>         Capabilities: [e4]      Capabilities: [f0] Message Signalled
> Interrupts: 64bit+ Queue=0/0 Enable-
> ......
> 0002:01:01.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169
> Gigabit Ethernet (rev 10)
>         Subsystem: Realtek Semiconductor Co., Ltd. RTL-8169 Gigabit
> Ethernet Flags: bus master, 66Mhz, medium devsel, latency 74, IRQ 131 I/O
> ports at 20fc00 [size=e0000000]
>         Memory at e0020000 (32-bit, non-prefetchable) [size=256]
>         Expansion ROM at 00020000 [disabled]
>         Capabilities: [dc] Power Management version 2
>
>
> I think my AMD64 system at home has a 64bit integrated adapter, as the
> performance on it is 2.5x faster (either that or r8169 and ppc don't play
> well together).  I will verify this when I get home.

Well, it appears that my home system only has a 32bit adapter as well (see 
below).

0000:00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169 
Gigabit Ethernet (rev 10)
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 702c
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 16
        I/O ports at c800 [size=cff20000]
        Memory at cfffb700 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at 00020000 [disabled]
        Capabilities: [dc] Power Management version 2

Before I make any sweeping comments about the performance on ppc64, I should 
probably do some more tests.  I'll have to get back to you regarding that.

Would you like me to run the "Config2" patch on my amd64 system?

-- 
Jon Mason
jdmason@us.ibm.com

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264637AbTE1Jnl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 05:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264638AbTE1Jnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 05:43:41 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:54474 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S264637AbTE1Jnk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 05:43:40 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "Brian J. Murrell" <brian@interlinx.bc.ca>
Date: Wed, 28 May 2003 11:56:29 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: local apic timer ints not working with vmware: nolocala
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <2C8EEAE5E5C@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 May 03 at 20:53, Brian J. Murrell wrote:
> Using a distribution (Mandrake's Cooker) patched kernel, I am unable to
> successfully boot at 2.4.20ish kernel on VMware 2.0.4 build 1142.  The
> problem seems to be with using local apic timer interrupts.  The last few
> lines of the boot sequence before the kernel hangs are (copied by hand, so
> please excuse typos):
> 
> Using local APIC timer interrupts.
> calibrating APIC timer ...
> ..... CPU clock speed is 1658.7651 MHz.
> ..... host bus clock speed is 0.0000 MHz.
> cpu: 0, clocks: 0, slice: 0
> 
> I do know that I could simply build a kernel with the CONFIG_X86_UP_APIC
> to work around this problem, but that means a "special" kernel just for
> VMware and also means not being able to use vendor supplied kernels, or
> vendor supplied boot media (i.e. CD-ROMs).

Just get VMware 3 or 4 - they (properly) emulate APIC timer and you'll
get information that host bus is running at 66.xxxx MHz. With VMware 2
you have to boot with noapic.
                                                Petr Vandrovec
                                                


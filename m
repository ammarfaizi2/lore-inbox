Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751618AbWIYAkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618AbWIYAkK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 20:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751621AbWIYAkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 20:40:10 -0400
Received: from gw.goop.org ([64.81.55.164]:60833 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751618AbWIYAkI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 20:40:08 -0400
Message-ID: <4517256E.10606@goop.org>
Date: Sun, 24 Sep 2006 17:40:14 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Andi Kleen <ak@muc.de>, Chuck Ebbert <76306.1226@compuserve.com>,
       Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       linux-kernel@vger.kernel.org
Subject: Re: i386 pda patches
References: <20060924013521.13d574b1.akpm@osdl.org>
In-Reply-To: <20060924013521.13d574b1.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> I am unable to correlate what's in Andi's tree with the PDA-related emails
> on this list.  Why is this?
>   

I'm not sure what's in Andi's tree.  He mentioned that he had trouble 
merging a previous patch I had, but it wasn't a particularly big change.

Andi, where can I get your tree?

> Anyway, the PDA patches are causing my little old dual-pIII to reboot about
> one second into the boot process.
>   

Interesting.  Have there been any other complaints about -mm crashing?  
There's nothing in here which is "new cpu"; it should work the same all 
the way back to an i386.

> Bisection says:
>
> x86_64-mm-i386-pda-asm-offsets.patch
> x86_64-mm-i386-pda-basics.patch                         OK
> x86_64-mm-i386-pda-init-pda.patch                       oops
> x86_64-mm-i386-pda-use-gs.patch				reboot
> x86_64-mm-i386-pda-user-abi.patch                       BAD
> x86_64-mm-i386-pda-vm86.patch
> x86_64-mm-i386-pda-smp-processorid.patch
> x86_64-mm-i386-pda-current.patch
>
>
> So x86_64-mm-i386-pda-init-pda.patch causes the below oops and
> x86_64-mm-i386-pda-use-gs.patch causes the instareboot.
>
>
>
> Compat vDSO mapped to ffffe000.
> Checking 'hlt' instruction... OK.
> SMP alternatives: switching to UP code
> CPU0: Intel Pentium III (Coppermine) stepping 03
> SMP alternatives: switching to SMP code
> Booting processor 1/1 eip 2000
> Initializing CPU#1
> general protection fault: 0080 [#1]
> SMP 
> last sysfs file: 
> Modules linked in:
> CPU:    1
> EIP:    0060:[<c010ad63>]    Not tainted VLI
> EFLAGS: 00010086   (2.6.18 #8) 
> EIP is at cpu_init+0x153/0x2b0
>   
What line does this EIP correspond to?

    J

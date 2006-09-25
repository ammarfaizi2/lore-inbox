Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751472AbWIYSxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbWIYSxE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 14:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbWIYSxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 14:53:04 -0400
Received: from gw.goop.org ([64.81.55.164]:1421 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751472AbWIYSxD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 14:53:03 -0400
Message-ID: <45182585.6010004@goop.org>
Date: Mon, 25 Sep 2006 11:52:53 -0700
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
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> I am unable to correlate what's in Andi's tree with the PDA-related emails
> on this list.  Why is this?
>
> Anyway, the PDA patches are causing my little old dual-pIII to reboot about
> one second into the boot process.
>
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

Hm, I can't repro this. I just rolled a new set of i386-pda patches 
against 2.6.18-mm1, and tried your .config, but it boots fine for me. I 
may have fixed a problem in the process of generating new patches, but 
nothing stands out. The oops you're getting is pretty bad; it doesn't 
seem like it should be .config-dependent or in any way intermittent (ie, 
everyone should be seeing this if anyone does).

Anyway, could you try again with the new i386-pda patches? I'll post 
them shortly.

Thanks,
J

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264370AbTLEUo6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 15:44:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264384AbTLEUo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 15:44:58 -0500
Received: from fed1mtao01.cox.net ([68.6.19.244]:40069 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP id S264370AbTLEUo5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 15:44:57 -0500
Date: Fri, 5 Dec 2003 13:55:18 -0700
From: Jesse Allen <the3dfxdude@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Catching NForce2 lockup with NMI watchdog
Message-ID: <20031205205518.GA471@tesore.local>
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49F877@mail-sc-6.nvidia.com> <20031205201812.GA10538@localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031205201812.GA10538@localnet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 05, 2003 at 09:18:12PM +0100, cheuche+lkml@free.fr wrote:
> With a little patch in arch/i386/kernel/mpparse.c in the acpi section, I
> managed to get the timer interrupt back on IO-APIC-edge, maybe the nmi
> watchdog could work with the ioapic then ?

Maybe!  thanks!

> 
> With the patch, the interrupt flood on IRQ7 I reported on the nvidia2 
> lockups thread also disappeared, but then I noticed something odd when
> there is ide activity :

Yeah, I have been writing trace code to try to identify where it fails.  
Somehow what I did seem to have made IRQ 7 less noisy but I have no idea why? =)
So I do think the IRQ is related somehow...

> 
> There may be something wrong with the timer using apic and the
> amd/nforce ide driver does not handle this situation that should not
> occur and juste freezes. This is pure speculation of course.
> 
> *Disclaimer*
> The modification is certainly not the proper fix, does a wrong thing,
> but it shows an interesting behavior, especially it fixed the
> interrupt flood on IRQ7 I and some others are able to see.
> 
> Here the little patch of arch/i386/kernel/mpparse.c I used :
> 

I'll check it out.

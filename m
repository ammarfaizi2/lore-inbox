Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261913AbVDESw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbVDESw7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 14:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbVDESvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 14:51:21 -0400
Received: from hammer.engin.umich.edu ([141.213.40.79]:60126 "EHLO
	hammer.engin.umich.edu") by vger.kernel.org with ESMTP
	id S261916AbVDEStO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 14:49:14 -0400
Date: Tue, 5 Apr 2005 14:49:07 -0400 (EDT)
From: Christopher Allen Wing <wingc@engin.umich.edu>
To: Andi Kleen <ak@muc.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: clock runs at double speed on x86_64 system w/ATI RS200 chipset
In-Reply-To: <20050405183141.GA27195@muc.de>
Message-ID: <Pine.LNX.4.58.0504051444240.13242@hammer.engin.umich.edu>
References: <200504031231.j33CVtHp021214@harpo.it.uu.se>
 <Pine.LNX.4.58.0504041050250.32159@hammer.engin.umich.edu> <m18y3x16rj.fsf@muc.de>
 <Pine.LNX.4.58.0504051351200.13242@hammer.engin.umich.edu>
 <20050405183141.GA27195@muc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 5 Apr 2005, Andi Kleen wrote:

> Some more debugging first might be good. Perhaps it is the same issue
> many Nvidia boards have with the APIC timer override being wrong;
> although in this case it should more not tick at all, but might
> be still worth a try.
> Try booting with acpi_skip_timer_override

That doesn't work on x86_64, because unfortunately I think
arch/x86_64/kernel/setup.c is missing the code to parse for that option.


I'll add in the code from arch/i386/kernel/setup.c, rebuild the kernel and
see what happens.

-Chris

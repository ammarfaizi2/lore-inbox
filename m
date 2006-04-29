Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWD2UgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWD2UgP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 16:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWD2UgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 16:36:14 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:24211 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750751AbWD2UgO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 16:36:14 -0400
Message-ID: <4453CE37.8010705@garzik.org>
Date: Sat, 29 Apr 2006 16:36:07 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@it.uu.se>
CC: discuss@x86-64.org, linux-input@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] make PC Speaker driver work on x86-64
References: <200604291830.k3TIUA23009336@harpo.it.uu.se>
In-Reply-To: <200604291830.k3TIUA23009336@harpo.it.uu.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.0 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.0 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> I have a pair of Athlon64 machines that dual-boot 32-bit and
> 64-bit kernels. One annoying difference between the kernels
> is that the PC Speaker driver (CONFIG_INPUT_PCSPKR=y) only
> works in the 32-bit kernels. In the 64-bit kernels it remains
> inactive and doesn't even generate any boot-time initialisation
> or error messages.
> 
> Today I debugged that issue, and found that the PC Speaker
> driver's ->probe() routine doesn't even get called in the
> 64-bit kernels. The reason for that is that the arch code
> apparently has to explictly add a "pcspkr" platform device
> in order for the driver core to call the ->probe() routine.
> arch/i386/kernel/setup.c unconditionally adds a "pcspkr"
> device, but the x86_64 kernel has no code at all related to
> the PC Speaker.

Wow, thanks.

I was wondering why my PC speaker didn't seem to work.  And here I was, 
blaming Fedora...
	
	Jeff



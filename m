Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262038AbVATEDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbVATEDL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 23:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbVATEDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 23:03:11 -0500
Received: from fsmlabs.com ([168.103.115.128]:42657 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S262038AbVATEDI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 23:03:08 -0500
Date: Wed, 19 Jan 2005 21:02:24 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Tony Lindgren <tony@atomide.com>
cc: Pavel Machek <pavel@ucw.cz>, George Anzinger <george@mvista.com>,
       john stultz <johnstul@us.ibm.com>, Andrea Arcangeli <andrea@suse.de>,
       Con Kolivas <kernel@kolivas.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dynamic tick patch
In-Reply-To: <20050119000556.GB14749@atomide.com>
Message-ID: <Pine.LNX.4.61.0501192100060.3010@montezuma.fsmlabs.com>
References: <20050119000556.GB14749@atomide.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jan 2005, Tony Lindgren wrote:

> Hi all,
> 
> Attached is the dynamic tick patch for x86 to play with
> as I promised in few threads earlier on this list.[1][2]
> 
> The dynamic tick patch does following:
> 
> - Separates timer interrupts from updating system time
> 
> - Allows updating time from other interrupts in addition
>   to timer interrupt
> 
> - Makes timer tick dynamic
> 
> - Allows power management modules to take advantage of the
>   idle time inbetween skipped ticks
> 
> - Might help with the whistling caps?

This doesn't seem to cover the local APIC timer, what do you do about the 
1kHz tick which it's programmed to do?

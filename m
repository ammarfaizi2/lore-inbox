Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423479AbWJaPWB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423479AbWJaPWB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 10:22:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423483AbWJaPWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 10:22:00 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:47334 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1423479AbWJaPWA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 10:22:00 -0500
Message-ID: <454769BE.6070300@gmail.com>
Date: Tue, 31 Oct 2006 16:20:30 +0100
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       support@specialix.co.uk
Subject: Re: [PATCH 4/9] Char: sx, remove unneeded stuff
References: <17859287641876623669@karneval.cz> <20061031074907.GA2031@bitwizard.nl>
In-Reply-To: <20061031074907.GA2031@bitwizard.nl>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: jirislaby@gmail.com
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogier Wolff wrote:
> 
> Hi,
> 
> When you work on a driver, it has happened to me multiple times that
> I forget to acknowledge the interrupt to the hardware. This is when
> the "rate limit" converts a solid hang ("what the <beep> is going on?)
> into a console message that "your interrupt is triggering too much". 
> 
> This reduces development time on the driver, which I think is worth
> the 20 or so inactive lines-of-code that this requires in the source. 
> 
> Also proposed to be deleted the defines that I added to remind me
> of the possibility to report fifo overruns. Other drivers have this
> capability, but much smaller buffers. So it hasn't been neccesary
> yet. For now it remains unimplemented. But I would prefer to keep
> the notes of the possibility of this enhancement in the driver source
> instead of somewhere else. 

Aaah, OK.

> Apparently, someone deleted the call to the word-wide memory test. So 
> now the memory test seems dead code. I've had clients call for support 
> where after debugging a while, the conclusion was: you may have a corruption
> problem between the CPU and the card. Enable memory test, and voila!
> Proof that there is something seriously wrong with the hardware setup!

Maybe we could have this as a CONFIG_SX_MEMTEST option?

> This debugging feature is uncommon enough that I recommend leaving it
> compile-time-disabled. The other debugging features are compile time
> enabled, run-time-disabled. This allows end-users to send in detailed
> debugging reports without having to recompile the driver, which usually
> costs them a lot of time. 

I agree.

> The other "small" cleanups look ok. 

Ok, thanks for notes,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E

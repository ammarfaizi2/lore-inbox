Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbWD2LFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWD2LFK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 07:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750703AbWD2LFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 07:05:10 -0400
Received: from cantor.suse.de ([195.135.220.2]:20615 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750720AbWD2LFI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 07:05:08 -0400
From: Andi Kleen <ak@suse.de>
To: minyard@acm.org
Subject: Re: [PATCH] x86_64: add nmi_exit to die_nmi
Date: Sat, 29 Apr 2006 12:58:55 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060427175551.GA22941@i2.minyard.local>
In-Reply-To: <20060427175551.GA22941@i2.minyard.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604291258.55430.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 April 2006 19:55, Corey Minyard wrote:
> Playing with NMI watchdog on x86_64, I discovered that it didn't
> do what I expected.  It always panic-ed, even when it didn't
> happen from interrupt context.  

Hmm, I don't think that's true. Or at least it worked at some point.
Ok maybe something regressed.


> This patch solves that 
> problem for me.  Also, in this case, do_exit() will be called
> with interrupts disabled, I believe.  Would it be wise to also
> call local_irq_enable() after nmi_exit()?


Probably yes. I added that with the the patch.

Thanks,
-Andi


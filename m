Return-Path: <linux-kernel-owner+w=401wt.eu-S932456AbWLLVxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbWLLVxT (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 16:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbWLLVxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 16:53:19 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:44943 "EHLO
	fr.zoreil.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932456AbWLLVxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 16:53:18 -0500
Date: Tue, 12 Dec 2006 22:49:39 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@davemloft.net>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [patch] net, 8139too.c: fix netpoll deadlock
Message-ID: <20061212214939.GA470@electric-eye.fr.zoreil.com>
References: <20061212101656.GA5064@elte.hu> <20061212124935.GA4356@elte.hu> <457EAE62.8090404@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <457EAE62.8090404@garzik.org>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jeff@garzik.org> :
> Ingo Molnar wrote:
[...]
> >fix deadlock in the 8139too driver: poll handlers should never forcibly 
> >enable local interrupts, because they might be used by netpoll/printk 
> >from IRQ context.
> 
> ACK
> 
> (I'll queue it, if Linus doesn't pick it up; please CC me in the future)

I have lived with the "NAPI ->poll() handler runs in BH irq enabled context"
rule for years. Is it definitely false/dead ?

If so at least 8139cp needs the same fix.

-- 
Ueimor

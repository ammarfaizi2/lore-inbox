Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273906AbTHFGnI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 02:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274858AbTHFGnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 02:43:08 -0400
Received: from adsl-216-102-91-59.dsl.snfc21.pacbell.net ([216.102.91.59]:58628
	"EHLO nasledov.com") by vger.kernel.org with ESMTP id S273906AbTHFGnG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 02:43:06 -0400
Date: Tue, 5 Aug 2003 23:42:54 -0700
To: OSDL <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5/2.6 PCMCIA Issues
Message-ID: <20030806064254.GA3887@nasledov.com>
References: <20030804232204.GA21763@nasledov.com> <20030805144453.A8914@flint.arm.linux.org.uk> <20030806045627.GA1625@nasledov.com> <200308060559.h765xhI05860@mail.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308060559.h765xhI05860@mail.osdl.org>
User-Agent: Mutt/1.5.4i
From: Misha Nasledov <misha@nasledov.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 05, 2003 at 10:59:43PM -0700, OSDL wrote:
> Can you try with PnP and the i82365 support _disabled_. I find this sequence
> very suspicious:
> 
>         Intel PCIC probe: PNP <6>pnp: Device 00:17 activated.
>         invalid resources ?
>         pnp: Device 00:17 disabled.
>         not found.
> 
> and I bet it messes up some of the register state that the yenta probe had
> just set up.

I tried with i82365 support disabled and my card's module successfully
loaded and all was in order. When I tried ejecting the card at first,
it seemed like it would fail as I got a message in my syslog saying
"unregister_netdevice: waiting for eth0 to become free. Usage count =
3", but after a few patient moments, the module was finally unloaded.

Thanks for your help!
-- 
Misha Nasledov
misha@nasledov.com
http://nasledov.com/misha/

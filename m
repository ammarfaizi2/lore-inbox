Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbTEKR2C (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 13:28:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbTEKR2C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 13:28:02 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:17537
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S261790AbTEKR2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 13:28:00 -0400
Date: Sun, 11 May 2003 13:31:32 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Jeff Garzik <jgarzik@pobox.com>
cc: Daniel Ritz <daniel.ritz@gmx.ch>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@diego.com>
Subject: Re: [bug 2.5.69] xirc2ps_cs, irq 3: nobody cared, shutdown hangs
In-Reply-To: <3EBE8768.4000007@pobox.com>
Message-ID: <Pine.LNX.4.50.0305111324530.15337-100000@montezuma.mastecende.com>
References: <200305111647.32113.daniel.ritz@gmx.ch>
 <Pine.LNX.4.50.0305111202510.15337-100000@montezuma.mastecende.com>
 <3EBE8768.4000007@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 May 2003, Jeff Garzik wrote:

> If this patch works, it's mainly a signal to dig deeper.
> 
> If netif_device_present() returns false, we think the hardware has 
> disappeared.  So that implies a bug in calling netif_device_detach() no 
> a bug in the irq handler return value.
> 
> This is _especially_ true for pcmcia, even more than pci.  PCI ejects 
> (including cardbus) are electrically safe, whereas pcmcia is different. 
>   If pcmcia hardware disappears on you, you _really_ don't want to be 
> bitbanging its ports.

Could possibly be a problem in CardServices, it appears to defer free'ing 
interrupts.

-- 
function.linuxpower.ca

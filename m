Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbTEKW1F (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 18:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbTEKW1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 18:27:05 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:49045
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261352AbTEKW1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 18:27:04 -0400
Subject: Re: [bug 2.5.69] xirc2ps_cs, irq 3: nobody cared, shutdown hangs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Zwane Mwaikambo <zwane@linuxpower.ca>,
       Daniel Ritz <daniel.ritz@gmx.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@diego.com>
In-Reply-To: <1052690907.15307.10.camel@imladris.demon.co.uk>
References: <200305111647.32113.daniel.ritz@gmx.ch>
	 <Pine.LNX.4.50.0305111202510.15337-100000@montezuma.mastecende.com>
	 <3EBE8768.4000007@pobox.com>
	 <1052673649.29921.15.camel@dhcp22.swansea.linux.org.uk>
	 <1052690907.15307.10.camel@imladris.demon.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052689233.30506.1.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 May 2003 22:40:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-05-11 at 23:08, David Woodhouse wrote:
> PCMCIA has varying pin length for the CD pins and hence gives you a few
> milliseconds of warning before the card is _actually_ disconnected.

Which is less than the worst case IRQ response time (or indeed on some
PCs the worst case CPU hold off time for the PCI bus)

> After that period of time has elapsed and the card is actually gone, you
> _really_ don't want to be bitbanging its ports.
> 
> > Its quite safe to do so.
> 
> Not on all platforms.

On all that matters it is safe, the others are unfixable anyway


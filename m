Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265641AbRGCJBF>; Tue, 3 Jul 2001 05:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265648AbRGCJAz>; Tue, 3 Jul 2001 05:00:55 -0400
Received: from t2.redhat.com ([199.183.24.243]:13815 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S265641AbRGCJAi>; Tue, 3 Jul 2001 05:00:38 -0400
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: David Howells <dhowells@redhat.com>, Russell King <rmk@arm.linux.org.uk>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        David Woodhouse <dwmw2@infradead.org>, Jes Sorensen <jes@sunsite.dk>,
        linux-kernel@vger.kernel.org, arjanv@redhat.com
Subject: Re: [RFC] I/O Access Abstractions 
In-Reply-To: Your message of "Tue, 03 Jul 2001 04:31:25 EDT."
             <3B4182DD.FCDD8DDE@mandrakesoft.com> 
Date: Tue, 03 Jul 2001 10:00:36 +0100
Message-ID: <4047.994150836@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I also point out that using ioremap for PIO adds flexibility while
> keeping most drivers relatively unchanged.  Everyone uses a base address
> anyway, so whether its obtained directly (address from PCI BAR) or
> indirectly (via ioremap), you already store it and use it.

I see what you're getting at at last:-) I didn't quite pick up on the fact
that you'd still have to go through readb/writeb and their ilk to access the
code.

Of course, however, this still requires cookie decoding to be done in readb
and writeb (even on the i386). So why not use resource struct?

David

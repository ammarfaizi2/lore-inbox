Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130663AbQKINFx>; Thu, 9 Nov 2000 08:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130571AbQKINFn>; Thu, 9 Nov 2000 08:05:43 -0500
Received: from orbita.don.sitek.net ([213.24.25.98]:4612 "EHLO
	orbita.don.sitek.net") by vger.kernel.org with ESMTP
	id <S130751AbQKINF1>; Thu, 9 Nov 2000 08:05:27 -0500
Date: Thu, 9 Nov 2000 16:06:52 +0300
From: Andrey Panin <pazke@orbita.don.sitek.net>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media/radio [check_region() removal... ]
Message-ID: <20001109160652.A1953@debian>
In-Reply-To: <Pine.LNX.4.21.0011090056470.22998-200000@tricky> <3A09EC3A.82324C57@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <3A09EC3A.82324C57@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Wed, Nov 08, 2000 at 07:13:46PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2000 at 07:13:46PM -0500, Jeff Garzik wrote:

Hi all,

> 
> Finally, a word to you, Alan, and others doing request_region work:  it
> is more informative to pass the device name (minor, etc.) into
> request_region.  Ditto for request_irq.  Many (most, except net?)
> drivers use board/chip name instead of registered interface name.  If
> you can use the interface name for request_region or request_irq, use
> it... it allows differentiation between multiple boards of the same
> type.  That's especially when looking at ISA regions in /proc/ioports,
> or interrupt counts in /proc/interrupts.
> 

two question about this:

1) how about drivers requesting 2 (or more) irq for one device ?
AFAIK some PowerMac net drivers do it (bmac.c for example).

2) i found that some net drivers (3c527.c, sk_mca.c) use io region and
don't call request_region() at all. Should they be fixed ?

Best regards,
	    Andrey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

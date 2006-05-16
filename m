Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750926AbWEPBFx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbWEPBFx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 21:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbWEPBFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 21:05:53 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:51869 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750924AbWEPBFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 21:05:52 -0400
Subject: Re: pcmcia oops on 2.6.17-rc[12]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>, florin@iucha.net,
       linux-kernel@vger.kernel.org, linux@dominikbrodowski.net
In-Reply-To: <Pine.LNX.4.64.0605151715290.3866@g5.osdl.org>
References: <20060423192251.GD8896@iucha.net>
	 <20060423150206.546b7483.akpm@osdl.org>
	 <20060508145609.GA3983@rhlx01.fht-esslingen.de>
	 <20060508084301.5025b25d.akpm@osdl.org>
	 <20060508163453.GB19040@flint.arm.linux.org.uk>
	 <1147730828.26686.165.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0605151459140.3866@g5.osdl.org>
	 <1147734026.26686.200.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0605151629350.3866@g5.osdl.org>
	 <Pine.LNX.4.64.0605151644090.3866@g5.osdl.org>
	 <1147738680.26686.231.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0605151715290.3866@g5.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 16 May 2006 02:18:23 +0100
Message-Id: <1147742303.31247.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-05-15 at 17:18 -0700, Linus Torvalds wrote:
> The irq auto-detection should work with shared interrupts, but yes, it 
> won't _detect_ them if they are already in use (but it's ok with them 
> becoming shared later).
> 
> That said, true ISA cards obviously won't ever have a shared irq, in any 
> normal circumstances.

It really isn't that simple. ISAPnP and later ISA cards often allowed
the IRQ to be configured at runtime. Drivers doing this depend upon the
request_irq failing to decide which interrupt line to assign. The
resource management side of exclusive IRQ allocation is for better or
worse deeply embedded in the current interrupt design.

Alan


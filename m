Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932332AbWEOVyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbWEOVyr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 17:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbWEOVyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 17:54:47 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:64902 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932332AbWEOVyq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 17:54:46 -0400
Subject: Re: pcmcia oops on 2.6.17-rc[12]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       florin@iucha.net, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       linux@dominikbrodowski.net
In-Reply-To: <20060508163453.GB19040@flint.arm.linux.org.uk>
References: <20060423192251.GD8896@iucha.net>
	 <20060423150206.546b7483.akpm@osdl.org>
	 <20060508145609.GA3983@rhlx01.fht-esslingen.de>
	 <20060508084301.5025b25d.akpm@osdl.org>
	 <20060508163453.GB19040@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 15 May 2006 23:07:08 +0100
Message-Id: <1147730828.26686.165.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-05-08 at 17:34 +0100, Russell King wrote:
> > So 8250 is requesting an IRQ for non-sharing mode and it's actually
> > failing, because something else is already using that IRQ.  The difference
> > is that the kernel now generates a warning when this happens.
> 
> Maybe someone is clearing the UPF_SHARE_IRQ flag?  Which port is this?

Its a bug in the PCMCIA code. Its the one I hit with the IDE code.
Asking for a private IRQ is not always honoured. 

Just happened to see the message again and notice the pattern.

Alan


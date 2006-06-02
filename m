Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbWFBTJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbWFBTJn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 15:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbWFBTJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 15:09:43 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:22024 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932317AbWFBTJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 15:09:41 -0400
Date: Fri, 2 Jun 2006 20:09:28 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>, florin@iucha.net,
       linux-kernel@vger.kernel.org, linux@dominikbrodowski.net
Subject: Re: pcmcia oops on 2.6.17-rc[12]
Message-ID: <20060602190928.GI3100@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Rogier Wolff <R.E.Wolff@BitWizard.nl>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Andreas Mohr <andi@rhlx01.fht-esslingen.de>, florin@iucha.net,
	linux-kernel@vger.kernel.org, linux@dominikbrodowski.net
References: <20060423192251.GD8896@iucha.net> <20060423150206.546b7483.akpm@osdl.org> <20060508145609.GA3983@rhlx01.fht-esslingen.de> <20060508084301.5025b25d.akpm@osdl.org> <20060508163453.GB19040@flint.arm.linux.org.uk> <1147730828.26686.165.camel@localhost.localdomain> <Pine.LNX.4.64.0605151459140.3866@g5.osdl.org> <1147734026.26686.200.camel@localhost.localdomain> <20060522115046.GA23074@bitwizard.nl> <1148299804.17376.34.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1148299804.17376.34.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2006 at 01:10:04PM +0100, Alan Cox wrote:
> On Llu, 2006-05-22 at 13:50 +0200, Rogier Wolff wrote:
> > The question I'm stuck with is: When is it valid to ask for a non-shared
> > IRQ, and get back a shared one. 
> 
> I don't think it is. The problem is that some PCMCIA drivers currently
> assume they can do so. The rules changed a bit over time on the hardware
> side.

As I've explained twice so far in this thread, this is not the case
with PCMCIA serial ports.  We always request IRQs with SA_SHIRQ, unless
someone from userspace comes along and explicitly clears the "shared
interrupt" flag via setserial.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282843AbRLRKRB>; Tue, 18 Dec 2001 05:17:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285633AbRLRKQw>; Tue, 18 Dec 2001 05:16:52 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:45585 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S282843AbRLRKQj>; Tue, 18 Dec 2001 05:16:39 -0500
Date: Tue, 18 Dec 2001 10:16:30 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Todd Inglett <tinglett@chartermi.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IDE dma reset for sl82c105
Message-ID: <20011218101630.C12774@flint.arm.linux.org.uk>
In-Reply-To: <3C1EB87C.7090103@chartermi.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C1EB87C.7090103@chartermi.net>; from tinglett@chartermi.net on Mon, Dec 17, 2001 at 09:31:08PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2001 at 09:31:08PM -0600, Todd Inglett wrote:
> I have found that the IDE controller on a w83c553f (a sl82c105 function) 
> can get into a hung state if the interrupt line is wired to INTC and a 
> timeout occurs.  The following patch implements a hard reset for the 
> controller as documented in a Windbond engineering notice.

Thanks - I'll give it a whirl here.

Could you also get an lspci -v dump of the ISA bridge and the IDE function
please?

> This patch needs some testing and there appears to be no maintainer for 
> the sl83c105 IDE driver :(.

I'm about the closest person to a maintainer for that; these chips are
used on every NetWinder...

> The conditions to repeat the problem are 
> that the controller must be wired for PCI INTC, DMA must be in use, and 
> a timeout error must occur (try mounting a music CD).

Does the Engineering notice give PCI INTC as a pre-condition?

> The patch should apply to 2.5.13 - 2.5.16 (at least).

I think you mean 2.4.13 - 2.4.16 8)

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


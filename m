Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136765AbRA2CBT>; Sun, 28 Jan 2001 21:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S144841AbRA2CBJ>; Sun, 28 Jan 2001 21:01:09 -0500
Received: from linuxcare.com.au ([203.29.91.49]:47889 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S136765AbRA2CA5>; Sun, 28 Jan 2001 21:00:57 -0500
From: Anton Blanchard <anton@linuxcare.com.au>
Date: Mon, 29 Jan 2001 13:00:18 +1100
To: John Jasen <jjasen@datafoundation.com>,
        Mike Pontillo <mike_p@polaris.wox.org>, linux-kernel@vger.kernel.org
Subject: Re: Support for 802.11 cards?
Message-ID: <20010129130018.B8771@linuxcare.com>
In-Reply-To: <Pine.LNX.4.21.0101281344040.12805-100000@polaris.wox.org> <Pine.LNX.4.30.0101281704050.2343-100000@flash.datafoundation.com> <20010128182358.F23716@alcove.wittsend.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010128182358.F23716@alcove.wittsend.com>; from mhw@wittsend.com on Sun, Jan 28, 2001 at 06:23:58PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
 
> 	Last I knew (straight from the Lucent people), the ISA bridge
> card worked fine and the PCI card did NOT work at all.  I've since
> confirmed that, first hand, myself (I currently have the ISA bridge in
> operation) on the 2.2 kernels.  The ISA bridge also works on the 2.4
> kernels but I have not retested the PCI bridge on 2.4.  The Lucent
> people claim that the Linux pcmcia people are aware of the problem.

I have a PCI -> PCMCIA bridge + lucent wavelan card working fine with the
GPL driver (not the Lucent proprietory one) and 2.4. From memory all I had
to do was stop pcmcia-cs from using the lower io port range (there must
have been conflicts with existing devices).

#include port 0x100-0x4ff, port 0x800-0x8ff, port 0xc00-0xcff
include port 0x800-0x8ff, port 0xc00-0xcff

Anton
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268598AbUH3RX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268598AbUH3RX6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 13:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268582AbUH3RWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 13:22:11 -0400
Received: from chaos.analogic.com ([204.178.40.224]:54150 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S268594AbUH3RUq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 13:20:46 -0400
Date: Mon, 30 Aug 2004 13:20:31 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Andi Kleen <ak@muc.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       mark.langsdorf@amd.com
Subject: Re: Celistica with AMD chip-set
In-Reply-To: <m34qmktzlk.fsf@averell.firstfloor.org>
Message-ID: <Pine.LNX.4.53.0408301318290.22149@chaos>
References: <2yV1c-29L-7@gated-at.bofh.it> <2yVb1-2ft-57@gated-at.bofh.it>
 <m34qmktzlk.fsf@averell.firstfloor.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Aug 2004, Andi Kleen wrote:

> Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
>
> > On Llu, 2004-08-30 at 15:02, Richard B. Johnson wrote:
> >> Hello all,
> >>
> >> The Celistica server with the AMD chip-set has very poor
> >> PCI performance with Linux (and probably W$ too).
> >>
> >> The problem was traced to incorrect bridge configuration
> >> in the HyperTransport(tm) chips that connect up pairs
> >> of slots.
>
> >    while((pdev = pci_find_device(0x1022, 0x7450, pdev)) != NULL)
> >        pci_write_config_dword(pdev,  0x4c, 0x2ec1);
>
>
> > Can you get Celestica to mail me their PCI subvendor
> > id/devid's for the problem configuration or DMI strings
> > and then we can do a PCI quirk properly for this.
>
> Celistica is just the contract manufacturer for the AMD
> reference design, they're really AMD designs. 0122/7450
> is the AMD 8131 PCI-X bridge.
>
> I doubt it is a good idea to blindly change the configuration of the
> bridge like this in the kernel.  It is probably better to wait for an
> BIOS update or if you really need an urgent fix to do it from user
> space. Any fix should probably read/change bit/write the register, not
> blindly overwrite.
>
> -Andi
>
It is NOT "blindly" overwritten. We know what was in that register
(0x2c01).

Also, it is a "fix" for those who are getting crappy performance
from their boxes. Hopefully a new BIOS will be out with more
permanent fixes.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


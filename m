Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbVDDM3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbVDDM3O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 08:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbVDDM3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 08:29:14 -0400
Received: from relay.rost.ru ([80.254.111.11]:17837 "EHLO relay.rost.ru")
	by vger.kernel.org with ESMTP id S261234AbVDDM27 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 08:28:59 -0400
Date: Mon, 4 Apr 2005 16:28:51 +0400
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Don Guy <mostly_harmless@sympatico.ca>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: v2.4.29 won't compile with PCI support disabled
Message-ID: <20050404122851.GD16003@pazke>
Mail-Followup-To: Mikael Pettersson <mikpe@csd.uu.se>,
	Don Guy <mostly_harmless@sympatico.ca>,
	linux-kernel@vger.kernel.org
References: <BAYC1-PASMTP03A4A4DD478BB2FC220CE1E13B0@cez.ice> <002401c53900$9a47b0e0$1d2aa8c0@stormie> <16977.12215.621136.359066@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16977.12215.621136.359066@alkaid.it.uu.se>
X-Uname: Linux 2.6.11-pazke i686
User-Agent: Mutt/1.5.6+20040907i
From: Andrey Panin <pazke@donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 094, 04 04, 2005 at 02:14:47 +0200, Mikael Pettersson wrote:
> Don Guy writes:
>  > PROBLEM:
>  > 
>  > Attempts to compile v2.4.29 with PCI support disabled result in the
>  > following errors:
>  > 
>  > drivers/char/char.o: In function `siig10x_init_fn':
>  > drivers/char/char.o(.text.init+0x12cd): undefined reference to
>  > `pci_siig10x_fn'
>  > drivers/char/char.o: In function `siig20x_init_fn':
>  > drivers/char/char.o(.text.init+0x12ed): undefined reference to
>  > `pci_siig20x_fn'
>  > 
>  > It has been suggested that enabling PCI support in the kernel will make this
>  > go away however a) enabling PCI support on a 486 which only has ISA & VLB is
>  > downright silly, and b) a test run with CONFIG_PCI=y resulted in a plethora
>  > of other errors.
> 
> Presumably this is because of other CONFIG options which are still
> enabled but don't work w/o CONFIG_PCI. So please post your .config.
> 
d> Both 2.4 and 2.6 kernels with CONFIG_PCI=n work Ok(*) on my 486.

Disable CONFIG_PARPORT_SERIAL in your config.

-- 
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

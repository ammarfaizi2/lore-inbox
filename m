Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274101AbRISQiP>; Wed, 19 Sep 2001 12:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274102AbRISQiF>; Wed, 19 Sep 2001 12:38:05 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:57104 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274101AbRISQh5>; Wed, 19 Sep 2001 12:37:57 -0400
Subject: Re: Magic SysRq +# in 2.4.9-ac/2.4.10-pre12
To: rddunlap@osdlab.org (Randy.Dunlap)
Date: Wed, 19 Sep 2001 17:42:54 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan), crutcher+kernel@datastacks.com,
        linux-kernel@vger.kernel.org (lkml), paulus@au.ibm.com
In-Reply-To: <3BA8C01D.79FBD7C3@osdlab.org> from "Randy.Dunlap" at Sep 19, 2001 08:56:13 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15jkR4-0003Fg-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Anyway, in looking at SysRq loglevel handling in
> 2.4.9-ac (and 2.4.10-pre12), I see that it has been modified
> quite a bit.  Looks extensible, which can be good.
> However, looking over it gave me several nagging questions
> and problems.
> 
> 1.  Was this stuff tested?  How ???

Its been in the ac tree for about 6 months and in several distro shippings

> If someone (Crutcher ?) wants to patch it, that's fine.
> If I patched it, I would just add a
>   next_loglevel = -1;
> at the beginning of __handle_sysrq_nolock() and then
> let the loglevel handler(s) set next_loglevel.
> If next_loglevel != -1 at the end of __handle_sysrq_nolock(),
> set console_loglevel to next_loglevel.

Send me a patch and cc Linus/Crutcher

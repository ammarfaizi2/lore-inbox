Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266035AbUGILfw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266035AbUGILfw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 07:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266022AbUGILfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 07:35:52 -0400
Received: from zigzag.lvk.cs.msu.su ([158.250.17.23]:34000 "EHLO
	zigzag.lvk.cs.msu.su") by vger.kernel.org with ESMTP
	id S266035AbUGILfo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 07:35:44 -0400
From: "Nikita V. Youshchenko" <yoush@cs.msu.su>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: Kernel crash in interrupt handler: nested interrupt breaks saved %eip?
Date: Fri, 9 Jul 2004 15:34:31 +0400
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, debian-kernel@lists.debian.org
References: <200407082351.13682@sercond.localdomain> <200407090031.09750.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200407090031.09750.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200407091534.35944@zigzag.lvk.cs.msu.su>
X-Scanner: exiscan *1BiteG-00020F-00*8CCPQrd8wX6*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> > EIP:    0060:[<c02262a2>]    Tainted: P
>                                ^^^^^^^^^^
> What was that? Your lsmod please?

That's caused by vmware bodules; I don't think they affect the situation.

> > So I think that an interrupt happened at that time, and %eip was
> > broken inside the handler.
>
> You can istrument your kernel to check for that on every interrupt
> and printk a KERN_NOTICE message if eip was changed.

What's the correct place for those? do_IRQ()? Or probably some other places 
also (APIC timer interrupt handler? exception handler?)

Unpleasant situation is that the problem is on a production server, which 
should be operational 24/7 ...  However, probably I'll try to install an 
instrumented kernel in the next kernel upgrade.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA7oLLsTbPknTfAB4RAhGvAJ9n9246V7cMntgPnwmKBI/pcR0XGACeMnSY
fuIaVh1yCssaJC0PWdHd7sE=
=/8fI
-----END PGP SIGNATURE-----

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbTJFNZu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 09:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbTJFNZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 09:25:50 -0400
Received: from chaos.analogic.com ([204.178.40.224]:46722 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262062AbTJFNZs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 09:25:48 -0400
Date: Mon, 6 Oct 2003 09:27:39 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Otavio Salvador <otavio@debian.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Normal Flopply should depend of ISA?
In-Reply-To: <87he2n2gzq.fsf@retteb.casa>
Message-ID: <Pine.LNX.4.53.0310060923510.8753@chaos>
References: <87he2n2gzq.fsf@retteb.casa>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Oct 2003, Otavio Salvador wrote:

> Hello folks,
>
> I'm current have problem to use normal floppy disk in 2.6.0-test6-bk7
> and looking at last patchset I found one possible cause.
>
> --- a/drivers/block/Kconfig Thu Sep 25 11:33:27 2003
> +++ b/drivers/block/Kconfig Thu Oct 2 00:12:22 2003
> @@ -6,7 +6,7 @@
> config BLK_DEV_FD
> tristate "Normal floppy disk support"
> - depends on !X86_PC9800 && !ARCH_S390
> + depends on ISA || M68 || SPARC64
> ---help---
> If you want to use the floppy disk drive(s) of your PC under Linux,
> say Y. Information about this driver, especially important for IBM
>
> Is right normal floppy depends of ISA? I'll include this by the moment
> but I doesn't have any ISA hardware in my system.
>
> Thanks in Advance,
> Otavio

Yes. "ISA" has become to mean more than that old 70's era socket
on the motherboard. Basically, it's a catch-all for any I/O that
doesn't use PCI or AGP. It should probably be renamed to GPIO or
OTHER!

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.



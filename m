Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261446AbSKREbm>; Sun, 17 Nov 2002 23:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261448AbSKREbm>; Sun, 17 Nov 2002 23:31:42 -0500
Received: from squeaker.ratbox.org ([207.188.202.227]:7105 "EHLO
	squeaker.ratbox.org") by vger.kernel.org with ESMTP
	id <S261446AbSKREbk> convert rfc822-to-8bit; Sun, 17 Nov 2002 23:31:40 -0500
Date: Sun, 17 Nov 2002 23:38:40 -0500 (EST)
From: Aaron Sethman <androsyn@ratbox.org>
To: Magnus =?iso-8859-1?Q?M=E5nsson?= <ganja@0x63.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RequestIRQ: Resource in use. 2.4.20-rc2
In-Reply-To: <20021117221935.GI4722@h55p111.delphi.afb.lu.se>
Message-ID: <Pine.LNX.4.44.0211172337440.30768-100000@squeaker.ratbox.org>
X-GPG-FINGRPRINT: 1024D/D4DE2553 0E60 59B5 60DA 2FD3 F6F5  27A3 6CD2 21AD D4DE 2553
X-GPG-PUBLIC_KEY: http://squeaker.ratbox.org/androsyn.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try to recompile with CONFIG_ISA support enabled, that should fix the
problem.  If I understand correctly, the 16bit PCMCIA cards are still ISA
devices.

Regards,

Aaron

On Sun, 17 Nov 2002, Magnus [iso-8859-1] Månsson wrote:

> Hello,
>
> I am having a problem with my PCMCIA in my Dell Inspiron 8200.
> In kernel 2.4.19 my pcmcia-cards works perfactly but in 2.4.20-rc1 and
> 2.4.20-rc2 I am getting the same error on both my pcmcia cards (one 802.11b
> wireless card of model D-Link DWL-650 and one 3com card 10/100Mb of some
> kind).
> pcmcia-cs version 3.2.2-1 is used though I am running debian unstable.
>
> I am getting the following in my syslog when I insert one of the cards:
> ---
> Nov 17 21:59:54 freija cardmgr[231]: socket 1: Intersil PRISM2 11 Mbps
> Wireless Adapter
> Nov 17 21:59:55 freija cardmgr[231]: executing: 'modprobe orinoco_cs'
> Nov 17 21:59:55 freija kernel: hermes.c: 5 Apr 2002 David Gibson
> <hermes@gibson.dropbear.id.au>
> Nov 17 21:59:55 freija kernel: orinoco.c 0.11b (David Gibson
> <hermes@gibson.dropbear.id.au> and others)
> Nov 17 21:59:55 freija kernel: orinoco_cs.c 0.11b (David Gibson
> <hermes@gibson.dropbear.id.au> and others)
> Nov 17 21:59:55 freija kernel: orinoco_cs: RequestIRQ: Resource in use
> Nov 17 21:59:56 freija cardmgr[231]: get dev info on socket 1 failed:
> Resource temporarily unavailable
> ---
>
> I have tried various combinations of irq-excludes in my
> /etc/pcmcia/config.opts without any difference at all.
> Another interesting thing is that I am not able to build pcmcia as
> modules, but imbedded in the kernel goes fine.
> I haven't found anything about this problem at the lkml and I hope someone
> has an answer to me.
>
> The following is from my config file belonging to the kernels I have
> compiled, I hope only the PCMCIA/CardBus-part is interesting. (I think I
> have a I82365, but since that didn't work I compiled them both in).
> ---
> # PCMCIA/CardBus support
> #
> CONFIG_PCMCIA=y
> CONFIG_CARDBUS=y
> # CONFIG_TCIC is not set
> CONFIG_I82092=y
> CONFIG_I82365=y
> ---
>
>
> Please cc me though I am not subscribed to the the list.
> Thanks
>
> --
> Magnus Månsson
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


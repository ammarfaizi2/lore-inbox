Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262463AbUKQTLd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262463AbUKQTLd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 14:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262423AbUKQTIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 14:08:46 -0500
Received: from fw.osdl.org ([65.172.181.6]:43690 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262460AbUKQTG4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 14:06:56 -0500
Date: Wed, 17 Nov 2004 11:06:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ralf Gerbig <rge@quengel.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc2-mm1 (8139too interrupt)
Message-Id: <20041117110640.1c7ccccd.akpm@osdl.org>
In-Reply-To: <87lld0rb2i.fsf-news@hsp-law.de>
References: <20041116014213.2128aca9.akpm@osdl.org>
	<87lld0rb2i.fsf-news@hsp-law.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralf Gerbig <rge@quengel.org> wrote:
>
> ...
> [ide_intr+0/496] (ide_intr+0x0/0x1f0)
> [<c0269c80>] (ide_intr+0x0/0x1f0)
> [ide_intr+0/496] (ide_intr+0x0/0x1f0)
> [<c0269c80>] (ide_intr+0x0/0x1f0)
> [pg0+541642080/1068946432] (rtl8139_interrupt+0x0/0x1d0 [8139too])
> [<e091dd60>] (rtl8139_interrupt+0x0/0x1d0 [8139too])
> Disabling IRQ #19
> 
> NETDEV WATCHDOG: eth1: transmit timed out
> eth1: Transmit timeout, status 0c 0005 c07f media 18.
> eth1: Tx queue start entry 63  dirty entry 59.
> eth1:  Tx descriptor 0 is 0008a03c.
> eth1:  Tx descriptor 1 is 0008a06a.
> eth1:  Tx descriptor 2 is 0008a03c.
> eth1:  Tx descriptor 3 is 0008a03c. (queue head)
> eth1: link up, 10Mbps, full-duplex, lpa 0x4061
> 
> and the interface is dead. Rmmod/insmod does not help.

Does this happen immediately, or does it take a bit of load first?

We should be looking for changes in 8139too, changes in IDE or changes in
interrupt setup.  Usually it is the latter.  It would be helpful if you
could gather the boot-time dmesg output from rc1-mm5 and rc2-mm1 and do a
`diff -u', see what changed.

Thanks.

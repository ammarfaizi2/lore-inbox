Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272961AbTHKVBN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 17:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273021AbTHKVBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 17:01:13 -0400
Received: from [132.216.18.133] ([132.216.18.133]:22282 "EHLO
	signal.ckut-fake.ca") by vger.kernel.org with ESMTP id S272961AbTHKVBJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 17:01:09 -0400
Date: Mon, 11 Aug 2003 17:01:06 -0400
From: Marc Heckmann <mh@nadir.org>
To: linux-kernel@vger.kernel.org
Subject: Re: UPDATE: 2.4.22-pre9, 8139too driver: eth0: Too much work at interrupt
Message-ID: <20030811210105.GA28252@nadir.org>
References: <20030805155811.GA17539@nadir.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030805155811.GA17539@nadir.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi.

turns out the problem was my fault. I had been tweaking the
pci latency_timer setting for the sound card using "setpci",
I had set it too high and the sound card was hogging the bus,
so to speak.

Hope this is helpful for others who might be experiencing this.

Anyway, may I just say that 2.4.22-pre9+ is turning out to be one of
the best kernels yet for me.

-m

On Tue, Aug 05, 2003 at 11:58:11AM -0400, Marc Heckmann wrote:
> Hi,
> 
> [I searched lkml archives for this, but nothing really useful came up,
> othewr than it did not happen on much older versions of 2.4.x]
> 
> When I transfer any large files via scp or other means on the local
> 100 Mbps network, I get the following error messages:
> 
> eth0: Too much work at interrupt: IntrStatus=0x0040
> 
> Are they just debug printk's? My NFS connections stall and sometimes
> cause errors in programs writing via NFS. (The machine exhibiting the
> symptoms is the NFS client.)
> 
> This is with 2.4.22-pre9, UP IO-APIC and ACPI enabled. The board is a
> Gigabyte GA7VXP with onboard 8139 ethernet.
> 
> This also happens with 2.4.21. I haven't tried any older kernels since
> the machine is new.
> 
> Does anyone have any ideas? thanks in advance.
> 
> -m
> 
> 

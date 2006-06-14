Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965041AbWFNXjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965041AbWFNXjR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 19:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965040AbWFNXjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 19:39:17 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:22466 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S965041AbWFNXjQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 19:39:16 -0400
Date: Thu, 15 Jun 2006 01:39:03 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Felipe Alfaro Solana <felipe.alfaro@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel-level IP autoconfiguration and nodename
In-Reply-To: <6f6293f10606140957t18545deetf3f75bba09eafa3d@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0606150135020.14257@yvahk01.tjqt.qr>
References: <6f6293f10606140957t18545deetf3f75bba09eafa3d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> However, I'm unable to get the client machine get its hostname from
> the DHCP server. What is really strange is that the kernel itself is
> able to autoconfigure itself using DHCP, and I can see during boot

I think that's obsolete since you can do it from initrd/initramfs for a 
looong time.
BTW, if so, why has not this been removed yet?

> that a hostname is assigned to the client, as shown before:
>
> IP-Config: eth0 complete (from 10.0.0.2):
> address: 10.0.0.10        broadcast: 10.255.255.255   netmask: 255.0.0.0
> gateway: 10.0.0.2         dns0     : 10.0.0.2         dns1   : 0.0.0.0
> host   : client1
> domain : lan
> rootserver: 10.0.0.2 rootpath:
>
> However, both "uname -n" and hostname return "(none)". I have tried

It is only a very simple dhcp client that only requests the lease 
once in a boot lifetime, even if the server will drop the lease when 
it expired.
Well, it does not explain your problem below, but IMO it's not worth 
looking into any further.

> hacking the initram, but I have been unable to guess why, although the
> kernel is receiving a hostname via DHCP, hostname ends up being
> "(none)".
>
> I've been reading net/ipv4/ipconfig.c and seems like
> system_utsname.nodename is being set to the host name received via
> DHCP, but I can't guess why /proc/sys/kernel/hostname keeps returning
> "(none)".
>
> Any ideas?
>
> Thank you very much.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Jan Engelhardt
-- 

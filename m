Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262745AbTJTTGF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 15:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262746AbTJTTGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 15:06:05 -0400
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:3855 "EHLO
	anchor-post-31.mail.demon.net") by vger.kernel.org with ESMTP
	id S262745AbTJTTGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 15:06:02 -0400
Message-ID: <3F943458.1000102@superbug.demon.co.uk>
Date: Mon, 20 Oct 2003 20:15:36 +0100
From: James Courtier-Dutton <James@superbug.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031019 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: IRQ Routing.
References: <3F9396C7.50807@superbug.demon.co.uk> <763050000.1066659824@[10.10.2.4]>
In-Reply-To: <763050000.1066659824@[10.10.2.4]>
X-Enigmail-Version: 0.81.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
>>Are their any linux tools to allow the user to view irq routing details, 
>>and maybe change the routing after boot ?
>>
>>This might be useful in special cases.
> 
> 
> Yeah, "cat /proc/interrupts" and 
> "echo <cpu_bitmask> > /proc/irq/<number>/smp_affinity"
> 
> M.
> 
> 
> 
I really need more info than that.
I want info like: -
PCI card in slot X, Is using [LNKA] which is being routed via IO-APIC to 
  IRQ Y using Edge triggered Interrupt.

And then I need a tool to be able to change those settings, to for 
example: -
PCI card in slot X, Is using [LNKF] which is being routed via simple PIC 
to  IRQ Y using Level triggered Active low Interrupt.

"lspci -vvvvvv" gives me some of the info, and on a working system, 
/proc/interrupts combined with lspci -vvvvv gives me all I need, but I 
need to be able to tinker with the IRQ rounting after boot up, to test 
what the IRQ settings should be, even if the kernel set them up wrong.

Cheers
James


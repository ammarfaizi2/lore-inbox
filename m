Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272390AbTHIO6P (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 10:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272392AbTHIO6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 10:58:15 -0400
Received: from washoe.rutgers.edu ([165.230.95.67]:33486 "EHLO
	washoe.rutgers.edu") by vger.kernel.org with ESMTP id S272390AbTHIO6N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 10:58:13 -0400
Date: Sat, 9 Aug 2003 10:58:12 -0400
From: Yaroslav Halchenko <yoh@onerussian.com>
To: linux-kernel@vger.kernel.org
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Christian Reichert <c.reichert@resolution.de>
Subject: Re: unexpected IRQ trap at vector a0
Message-ID: <20030809145812.GA12036@washoe.rutgers.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Christian Reichert <c.reichert@resolution.de>
References: <20030809022532.GA6345@washoe.rutgers.edu> <Pine.LNX.4.53.0308090309090.32166@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0308090309090.32166@montezuma.mastecende.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you guys for problem-pinning-down answers!

First I've tried
acpi=off

the kernel crashed right at the beginning of boot with smth like

oops: 0000[#1]

EOP is at acpi_pci_register_driver + 0x30/0x5c

Call trace: acpiphp_glue_init+0x1b/0x31
.....

But then,,,,

> > unexpected IRQ trap at vector a0
> 
>   9:     100000          0          XT-PIC  acpi
> 
> Cute, the interrupt storm monitor caught it dead =) Can you verify whether 
> booting with the kernel parameter noirqdebug 'fixes' things? Also boot 
> with the 'debug' kernel parameter as it will print out things like what is 
> at vector a0.

Uau - noirqdebug seems to "fix" the problem - I don't get complains any
more at least - will research other weirdness of system behaviour for
now with -test3 kernel!

Thank you!

> Thanks,
> 	Zwane
Thank you!

                                  .-.
=------------------------------   /v\  ----------------------------=
Keep in touch                    // \\     (yoh@|www.)onerussian.com
Yaroslav Halchenko              /(   )\               ICQ#: 60653192
                   Linux User    ^^-^^    [175555]

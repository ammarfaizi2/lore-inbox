Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261525AbULBAsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261525AbULBAsm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 19:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261526AbULBAsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 19:48:42 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:11686 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261525AbULBAsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 19:48:37 -0500
Subject: Re: keyboard timeout
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-os@analogic.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0412011721090.8835@chaos.analogic.com>
References: <Pine.LNX.4.61.0412011721090.8835@chaos.analogic.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101944709.30770.78.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 01 Dec 2004 23:45:11 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-12-01 at 22:29, linux-os wrote:
> If Linux 2.6.9 is booted on a 40 MHz `486 with the standard
> ISA clock of 14.3 MHz (yes that's the standard), the kernel
> will complain about a keyboard timeout for every key touched!

8.33Mhz. The delays should be correct but given that just about all
hardware under 15 years old doesn't care (I think the last thing to care
was the digital hi-note laptop) it is possible that the new input code
has a tiny missing delay somewhere. Having said that I have specifically
audited the input keyboard driver for such problems in 2.6.5 or so and
found only one (which is fixed)

Nor should the ISA bus speed matter - the uController chugs along at
about 2Mhz and the delays it needs are a bit longer than just ISA
cycles.


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264194AbRFNXgh>; Thu, 14 Jun 2001 19:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264196AbRFNXg1>; Thu, 14 Jun 2001 19:36:27 -0400
Received: from smtp-rt-2.wanadoo.fr ([193.252.19.154]:8354 "EHLO
	apeiba.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S264194AbRFNXgN>; Thu, 14 Jun 2001 19:36:13 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Going beyond 256 PCI buses
Date: Fri, 15 Jun 2001 01:35:53 +0200
Message-Id: <20010614233553.31603@smtp.wanadoo.fr>
In-Reply-To: <15145.16268.239882.904451@pizda.ninka.net>
In-Reply-To: <15145.16268.239882.904451@pizda.ninka.net>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Add whatever else you might be interested that things tend to
>inb/outb.
>
>And if your concern is having multiple of these in your system, the
>only ones that make sense are floppy and serial and those are handled
>just fine by the asm/serial.h mechanism.
>
>This way of doing this allows 16550's, floppies, etc. to be handled on
>any bus whatsoever.
>
>I mean, besides this and VGA what is left and even matters?

Ok, I capitulate ;)

So basically, all is needed is to enforce those drivers to use
ioremap before doing their IOs.

I still think there's a potential difficulty with having the same
ioremap function for both MMIO and PIO as the address space may overlap.

For once, the x86 enters the dance as it has really separate bus spaces for
them. Other archs can work around this by using the physical address
where the PIO is mapped in the IO resources.

Ben.



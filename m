Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261750AbTJWT74 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 15:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbTJWT74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 15:59:56 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:43484 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261750AbTJWT7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 15:59:55 -0400
Date: Thu, 23 Oct 2003 21:59:45 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       dbrownell@users.sourceforge.net
Cc: linux-kernel@vger.kernel.org, greg@kroah.com,
       linux-usb-devel@lists.sourceforge.net
Subject: 2.4.23-pre8: link error with multiple USB Gadget drivers
Message-ID: <20031023195945.GJ11807@fs.tum.de>
References: <Pine.LNX.4.44.0310222116270.1364-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310222116270.1364-100000@logos.cnet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting the following link error when trying to compile multiple 
Gadget drivers statically into the kernel:

<--  snip  -->

...
ld -m elf_i386  -r -o built-in.o net2280.o g_zero.o g_ether.o
g_ether.o(.text+0x1a60): In function `usb_gadget_get_string':
: multiple definition of `usb_gadget_get_string'
g_zero.o(.text+0xe50): first defined here
make[3]: *** [built-in.o] Error 1
make[3]: Leaving directory `/home/bunk/linux/kernel-2.4/linux-2.4.23-pre8-full/drivers/usb/gadget'

<--  snip  -->

IIRC this issue was fixed many months ago in 2.6, and a similar fix 
(disallowing multiple Gatget drivers) is also needed in 2.4 .

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


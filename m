Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279993AbRKDOEn>; Sun, 4 Nov 2001 09:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279997AbRKDOEd>; Sun, 4 Nov 2001 09:04:33 -0500
Received: from mail100.mail.bellsouth.net ([205.152.58.40]:16453 "EHLO
	imf00bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S279993AbRKDOEV>; Sun, 4 Nov 2001 09:04:21 -0500
Message-ID: <3BE54ADC.14A2D24C@mandrakesoft.com>
Date: Sun, 04 Nov 2001 09:04:12 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: Tom Winkler <tiger@tserver.2y.net>, linux-kernel@vger.kernel.org
Subject: Re: Vaio IRQ routing / USB problem
In-Reply-To: <3BE5201F.78A6B811@colorfullife.com>
Content-Type: multipart/mixed;
 boundary="------------CC75434D0060C984873901BD"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------CC75434D0060C984873901BD
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Manfred Spraul wrote:
> --- 2.4/arch/i386/kernel/pci-irq.c      Sat Nov  3 19:51:08 2001
> +++ build-2.4/arch/i386/kernel/pci-irq.c        Sun Nov  4 11:57:00 2001
> @@ -48,6 +48,8 @@
>   *  Search 0xf0000 -- 0xfffff for the PCI IRQ Routing Table.
>   */
> 
> +#undef DBG
> +#define DBG    printk
>  static struct irq_routing_table * __init pirq_find_routing_table(void)
>  {
>         u8 *addr;


This patch is probably preferred, it turns on all PCI and PCI
IRQ-related debugging, including dumping the PCI IRQ table.

Tom, please CC me a copy of the output as well, if you don't mind.

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno
--------------CC75434D0060C984873901BD
Content-Type: text/plain; charset=us-ascii;
 name="pci-irq-debug.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pci-irq-debug.patch"

Index: arch/i386/kernel/pci-i386.h
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/arch/i386/kernel/pci-i386.h,v
retrieving revision 1.3
diff -u -r1.3 pci-i386.h
--- arch/i386/kernel/pci-i386.h	2001/10/13 07:47:29	1.3
+++ arch/i386/kernel/pci-i386.h	2001/11/04 14:02:45
@@ -4,7 +4,7 @@
  *	(c) 1999 Martin Mares <mj@ucw.cz>
  */
 
-#undef DEBUG
+#define DEBUG 1
 
 #ifdef DEBUG
 #define DBG(x...) printk(x)

--------------CC75434D0060C984873901BD--



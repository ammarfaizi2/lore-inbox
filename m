Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288870AbSBDKnh>; Mon, 4 Feb 2002 05:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288867AbSBDKn1>; Mon, 4 Feb 2002 05:43:27 -0500
Received: from dsl-213-023-060-020.arcor-ip.net ([213.23.60.20]:33800 "EHLO
	spot.local") by vger.kernel.org with ESMTP id <S288870AbSBDKnR>;
	Mon, 4 Feb 2002 05:43:17 -0500
Date: Mon, 4 Feb 2002 11:46:44 +0100
From: Oliver Feiler <kiza@gmx.net>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: [Patch] (was: Re: fixup descriptions in pci-pc.c)
Message-ID: <20020204114644.A331@gmx.net>
In-Reply-To: <20020203152913.A533@gmx.net> <Pine.LNX.4.30.0202032342400.1158-100000@rtlab.med.cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.30.0202032342400.1158-100000@rtlab.med.cornell.edu>; from calin@ajvar.org on Sun, Feb 03, 2002 at 11:49:42PM -0500
X-Operating-System: Linux 2.4.16 i686
X-Species: Snow Leopard
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	This just changes the printk in the via_northbridge_bug fixup to some 
more meaningful output as it is already in 2.5.3. Please apply.

Oliver

--- linux-2.4.18-pre7/arch/i386/kernel/pci-pc.c	Sun Feb  3 14:56:48 2002
+++ linux-2.4.18-pre7_testing/arch/i386/kernel/pci-pc.c	Mon Feb  4 11:30:37 2002
@@ -1129,7 +1129,7 @@
 
 	pci_read_config_byte(d, where, &v);
 	if (v & 0xe0) {
-		printk("Trying to stomp on VIA Northbridge bug...\n");
+		printk("Disabling broken memory write queue.\n");
 		v &= 0x1f; /* clear bits 5, 6, 7 */
 		pci_write_config_byte(d, where, v);
 	}


-- 
Oliver Feiler                                               kiza@gmx.net
http://www.lionking.org/~kiza/pgpkey              PGP key ID: 0x561D4FD2
http://www.lionking.org/~kiza/

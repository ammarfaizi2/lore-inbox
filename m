Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288994AbSBDOqh>; Mon, 4 Feb 2002 09:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288995AbSBDOq1>; Mon, 4 Feb 2002 09:46:27 -0500
Received: from dsl-213-023-060-020.arcor-ip.net ([213.23.60.20]:30991 "EHLO
	spot.local") by vger.kernel.org with ESMTP id <S288994AbSBDOqT>;
	Mon, 4 Feb 2002 09:46:19 -0500
Date: Mon, 4 Feb 2002 15:49:46 +0100
From: Oliver Feiler <kiza@gmx.net>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: fixup descriptions in pci-pc.c
Message-ID: <20020204154946.A235@gmx.net>
In-Reply-To: <20020203152913.A533@gmx.net> <200202041311.g14DB2t12901@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200202041311.g14DB2t12901@Port.imtp.ilyichevsk.odessa.ua>; from vda@port.imtp.ilyichevsk.odessa.ua on Mon, Feb 04, 2002 at 03:11:03PM -0200
X-Operating-System: Linux 2.4.16 i686
X-Species: Snow Leopard
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> 
> Probably. + [reg]: old->new or similar

	Ok. Better with this?


--- linux-2.4.18-pre7/arch/i386/kernel/pci-pc.c	Mon Feb  4 15:13:45 2002
+++ linux-2.4.18-pre7_testing/arch/i386/kernel/pci-pc.c	Mon Feb  4 15:15:13 2002
@@ -1129,7 +1129,7 @@
 
 	pci_read_config_byte(d, where, &v);
 	if (v & 0xe0) {
-		printk("Trying to stomp on VIA Northbridge bug...\n");
+		printk("Disabling VIA memory write queue. Clearing bits 5, 6, 7 at 0x%x.\n", where);
 		v &= 0x1f; /* clear bits 5, 6, 7 */
 		pci_write_config_byte(d, where, v);
 	}


-- 
Oliver Feiler                                               kiza@gmx.net
http://www.lionking.org/~kiza/pgpkey              PGP key ID: 0x561D4FD2
http://www.lionking.org/~kiza/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRAEW0A>; Fri, 5 Jan 2001 17:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbRAEWZv>; Fri, 5 Jan 2001 17:25:51 -0500
Received: from elektroni.ee.tut.fi ([130.230.131.11]:32271 "HELO
	elektroni.ee.tut.fi") by vger.kernel.org with SMTP
	id <S129183AbRAEWZj>; Fri, 5 Jan 2001 17:25:39 -0500
Date: Sat, 6 Jan 2001 00:25:34 +0200
From: Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.0-ac2
Message-ID: <20010106002534.A14751@elektroni.ee.tut.fi>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <E14Eale-000873-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14Eale-000873-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Jan 05, 2001 at 05:35:03PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, 2001 at 05:35:03PM +0000, Alan Cox wrote:
> 
> 
> o	E820 handling fixup				(Andrea Arcangeli)

I guess this was supposed to be partly backed out for 2.4 too:


--- linux-2.4.0/arch/i386/kernel/setup.c.orig	Sun Dec 31 20:26:18 2000
+++ linux-2.4.0/arch/i386/kernel/setup.c	Fri Jan  5 23:43:34 2001
@@ -518,7 +518,7 @@
 
 		e820.nr_map = 0;
 		add_memory_region(0, LOWMEMSIZE(), E820_RAM);
-		add_memory_region(HIGH_MEMORY, (mem_size << 10) - HIGH_MEMORY, E820_RAM);
+		add_memory_region(HIGH_MEMORY, (mem_size << 10), E820_RAM);
   	}
 	printk("BIOS-provided physical RAM map:\n");
 	print_memory_map(who);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

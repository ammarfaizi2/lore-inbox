Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131382AbRC3Mt2>; Fri, 30 Mar 2001 07:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131386AbRC3MtS>; Fri, 30 Mar 2001 07:49:18 -0500
Received: from zeus.kernel.org ([209.10.41.242]:34518 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131382AbRC3MtN>;
	Fri, 30 Mar 2001 07:49:13 -0500
Date: Fri, 30 Mar 2001 14:32:24 +0200
From: Frank de Lange <frank@unternet.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.3: still experiencing APIC-related hangs
Message-ID: <20010330143224.A23427@unternet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi'all,

Subject says it all: 2.4.3 (unpatchaed) is still causing the dreaded
APIC-related hangs on SMP BX systems (Abit BP-6, maybe Gigabyte). I still need
to apply one of Maciej's patches to get rid of these hangs. The source comments
in arc/i386/kernel/apic.c ("If focus CPU is disabled then the hang goes away")
are incorrect, as the hang does not go away by simply disabling focus CPU. The
only way for me to get rid of the hangs is to apply patch-2.4.1-io_apic-46
(which does the LEVEL->EDGE->LEVEL triggered trick to 'free' the IO_APIC). I've
been running with this patch for quite some time now, and have not experienced
any problems with it. Maybe it it time to include it in the main kernel,
perhaps as a configurable option ("BROKEN_IO_APIC")?

Maciej, did you submit the patch to Linus? It really seems to solve the
(occurence of the) problems with these boards...

Cheers//Frank
-- 
  WWWWW      _______________________
 ## o o\    /     Frank de Lange     \
 }#   \|   /                          \
  ##---# _/     <Hacker for Hire>      \
   ####   \      +31-320-252965        /
           \    frank@unternet.org    /
            -------------------------
 [ "Omnis enim res, quae dando non deficit, dum habetur
    et non datur, nondum habetur, quomodo habenda est."  ]

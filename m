Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129156AbRBOOP5>; Thu, 15 Feb 2001 09:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129379AbRBOOPi>; Thu, 15 Feb 2001 09:15:38 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:34566 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129375AbRBOOPa>; Thu, 15 Feb 2001 09:15:30 -0500
Subject: Re: MP-Table mappings
To: macro@ds2.pg.gda.pl
Date: Thu, 15 Feb 2001 14:13:59 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        pgpkeys@hislinuxbox.com (David D.W. Downey),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.3.96.1010215122831.2905B-100000@delta.ds2.pg.gda.pl> from "Maciej W. Rozycki" at Feb 15, 2001 12:47:33 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14TPAW-0008Dt-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Just a crap bios
> 
>  That's unrelated -- duplicate reservations are due to the MP table being
> located in memory areas marked as "reserved" (ROM, ususally) in the map. 

Ah. Ok I'd not seen that specific case

> Thus the area is never freed in the first place and when smp_scan_config()
> calls reserve_bootmem() for the pages a warning is issued.  Harmless,
> indeed.

Umm probably worth cleaning up.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135819AbRAWD3P>; Mon, 22 Jan 2001 22:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135922AbRAWD3F>; Mon, 22 Jan 2001 22:29:05 -0500
Received: from isunix.it.ilstu.edu ([138.87.124.103]:60428 "EHLO
	isunix.it.ilstu.edu") by vger.kernel.org with ESMTP
	id <S135819AbRAWD3E>; Mon, 22 Jan 2001 22:29:04 -0500
From: Tim Hockin <thockin@isunix.it.ilstu.edu>
Message-Id: <200101230301.VAA13439@isunix.it.ilstu.edu>
Subject: Re: [PATCH] PCI-Devices and ServerWorks chipset
To: macro@ds2.pg.gda.pl (Maciej W. Rozycki)
Date: Mon, 22 Jan 2001 21:01:36 -0600 (CST)
Cc: mj@suse.cz (Martin Mares), al10@inf.tu-dresden.de (Adam Lackorzynski),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <Pine.GSO.3.96.1010117122300.22695B-100000@delta.ds2.pg.gda.pl> from "Maciej W. Rozycki" at Jan 17, 2001 12:25:39 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > patch is wrong -- it doesn't make any sense to scan a bus _range_. The registers
> > 0x44 and 0x45 are probably ID's of two primary buses and the code should scan
> > both of them, but not the space between them.
> 

0x44 is the primary bus number of the host bridge, and 0x45 is the
subordinate bus number for the bridge.  Just like a PCI-PCI bridge, but
different :)  Since there are two CNB30 functions, each has unique values
for this.  The primary bus of the second bridge must be the subordinate bus
of the first bridge + 1.  PRIMARY(1) = SUBORDINATE(0) + 1;

Tim
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

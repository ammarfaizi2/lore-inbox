Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263823AbTDUL6k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 07:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263824AbTDUL6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 07:58:40 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:33152 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263823AbTDUL6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 07:58:38 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304211213.h3LCDJlq000623@81-2-122-30.bradfords.org.uk>
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
To: vda@port.imtp.ilyichevsk.odessa.ua
Date: Mon, 21 Apr 2003 13:13:19 +0100 (BST)
Cc: john@grabjohn.com (John Bradford),
       skraw@ithnet.com (Stephan von Krawczynski),
       linux-kernel@vger.kernel.org
In-Reply-To: <200304211113.h3LBDuu08057@Port.imtp.ilyichevsk.odessa.ua> from "Denis Vlasenko" at Apr 21, 2003 02:22:01 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Name an IDE or SCSI disk on sale today that doesn't retry on write
> > failiure.  Forget I said 'Generally do'.
> 
> I don't know about drives currently on sale, but I think
> it is possible that some Flash or DRAM-based IDE pseudo-disks
> do not have extensive sector remapping features. They can just
> do ECC thing and error out.

Flash devices generally have wear-leveling, so I assume that they must
be doing some extensive sector remapping all the time.  I could be
wrong on that account, though.

> Also if disk just runs out of spare sectors, it has no other
> option other than just report failure, right? (Oh,
> of course it can decide to execute 'my firmware is buggy'
> option instead ;)

Yeah, but if a device which is intellegent about bad-block remapping
actually runs out of spare sectors, that's a different failiure that
having a single defective sector.  In a server, it would definitely be
time to replace it.

> But.
> 
> The disk, which I hold in my hand *right now*, namely:
> 	WD Caviar 21200
> MDL: WDAC21200-00H
> P/N: 99-004211-000
> CCC: E3 2 APR 97 S
> DCM: AFAAYAW
> WD S/N: WT342 251 1943
> 
> does have some bad sectors and otherwise performs satisfactorily.

OK.

> It's my 'big diskette'.

[snip]

Then why don't we invent a new filesystem, for known potentially
faulty media, which handles this case - why bloat all the existing
filesystems with code to handle it?  That idea isn't that far away
from the extra layer I suggested a few posts ago, and achieves the
same sort of thing.

John.

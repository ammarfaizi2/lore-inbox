Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265966AbUHBOhD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265966AbUHBOhD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 10:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266543AbUHBOhD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 10:37:03 -0400
Received: from email-out2.iomega.com ([147.178.1.83]:34815 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S265966AbUHBOeO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 10:34:14 -0400
In-Reply-To: <20040802121712.GD15884@logos.cnet>
References: <40926261-E3D3-11D8-B01E-00039398BB5E@ieee.org> <1091397374.6458
	 .9.camel@patibmrh9> <20040802121712.GD15884@logos.cnet>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed
Message-Id: <06F0F452-E491-11D8-94F5-00039398BB5E@ieee.org>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: 2.4.27rc2, DVD-RW support broke DVD-RAM writes
Date: Mon, 2 Aug 2004 08:34:14 -0600
To: Mathias Kretschmer <posting@blx4.net>
X-Mailer: Apple Mail (2.618)
X-OriginalArrivalTime: 02 Aug 2004 14:34:13.0217 (UTC) FILETIME=[C7E63D10:01
	C4789D]
X-imss-version: 2.0
X-imss-result: Passed
X-imss-scores: Clean:36.14734 C:49 M:1 S:5 R:5
X-imss-settings: Baseline:1 C:1 M:1 S:1 R:1 (0.0000 0.0000)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > http://marc.theaimsgroup.com/?t=109043580300002

Mathias K:

Hi.  Have you tried only PATAPI DVD-RAM drives?  Only via ide-cd.o, 
rather than via ide-scsi.o?

Me, as yet I have no PATAPI DVD-RAM, so instead I tried a USB DVD-RAM 
drive, specifically the "HL-DT-ST" "DVDRAM" "A100" drive.

Agreed, 2.4.27-rc4 fails to write.  But for me, 2.4.26 also fails to 
write.

For USB DVD-RAM in 2.4, I think the root evil is the dmesg complaint 
"kernel: sr0: scsi-1 drive", which in turn arises from the host 
substituting vendor-specific op x1A for MMC op x5A "MODE SENSE (10)".  
I'm guessing PATAPI DVD-RAM breaks over some other issue, found in the 
drivers/ide/ide-cd.c of ide-cd.o rather than in drivers/scsi/sr.c of 
ide-scsi.o.

Pat LaVarre
http://linux-pel.blog-city.com/read/754579.htm


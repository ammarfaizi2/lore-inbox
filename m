Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbTDLW6R (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 18:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261632AbTDLW6R (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 18:58:17 -0400
Received: from imap.gmx.net ([213.165.65.60]:8205 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261449AbTDLW6Q (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 18:58:16 -0400
From: "Oliver S." <Follow.Me@gmx.net>
To: <linux-kernel@vger.kernel.org>
Subject: AW: Benefits from computing physical IDE disk geometry?
Date: Sun, 13 Apr 2003 01:10:05 +0200
Message-ID: <000001c30148$a7d0add0$0200000a@kimba>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
In-Reply-To: <001301c30145$5ff85fb0$6801a8c0@epimetheus>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Any good SCSI drive knows the physical geometry of the disk and can
> therefore optimally schedule reads and writes.

 If the scheduler inside the OS can rely on the drive to have a linear
mapping it is implemented as a cyclical-scan scheduler, there is only
a little difference in the effectivity of the scheduling.

> Although necessary features, like read queueing, are also available
> in the current SATA spec, I'm not sure most drives will implement it,
> at least not very well.

 AFAIK the Seagate Barracudas implement first-party-dma, which is a
very lightweight implementation of command-queuing; with first-party
-dma, the CPU includes the adresses of where the data for a certain
request is read or written into the request-command so that when the
disk responds to a command, it sends this information back to the
controller. So this chip doesn't have to hold a list of outstanding
requests and their scattered adresses where the data is read from or
written to. Doesn't look very elegant, but that's just in line with
the cheap ATA-concepts.
 And the only controller-chips I'm aware of supporting this features
are the chips fom Silicon Image. But I think that sooner or later,
all SATA-chips will support it.


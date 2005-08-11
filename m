Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932279AbVHKLuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbVHKLuF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 07:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbVHKLuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 07:50:04 -0400
Received: from gate.crashing.org ([63.228.1.57]:49038 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932324AbVHKLuD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 07:50:03 -0400
Subject: Occasional IDE lost interrupts
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel list <linux-kernel@vger.kernel.org>,
       list linux-ide <linux-ide@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Content-Type: text/plain
Date: Thu, 11 Aug 2005 13:49:30 +0200
Message-Id: <1123760971.6802.2.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart !

That seem to be a new problem though I can't tell for sure when it
started. I've had reports from users for some time now of
"occasional" (once in a while, maybe once a day) lost interrupts on the
mac hard disk. I have about 30 days uptime and just saw a similar one in
my log. It happen during a disk access storm (apt-get upgrade :).

The problem when this happen is that I just lost DMA which is fairly
annoying. Users are not supposed to understand the magic of hdparm
-d1 /dev/hda and that shouldn't happen anyways...

Do you have any clue of what can be going on ? The IDE pmac driver has
not changed for a long time and I think that problem is fairly new
(maybe 2.6.12 ? not sure, first time I actually see it unless it's
unrelated and my disk is actually dying).

Shouldn't we have some more retry before giving up on DMA ?

Regards,
Ben.

[432796.162593] ide-pmac lost interrupt, dma status: 8480
[432796.162606] hda: lost interrupt
[432796.162613] hda: dma_intr: status=0xd0 { Busy }
[432796.162619]
[432796.162622] ide: failed opcode was: unknown
[432796.162632] hda: DMA disabled
[432796.262581] ide0: reset: success



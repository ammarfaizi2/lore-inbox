Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129097AbQKTVIO>; Mon, 20 Nov 2000 16:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129319AbQKTVIE>; Mon, 20 Nov 2000 16:08:04 -0500
Received: from tartu.cyber.ee ([193.40.16.128]:43784 "EHLO tartu.cyber.ee")
	by vger.kernel.org with ESMTP id <S129097AbQKTVHz>;
	Mon, 20 Nov 2000 16:07:55 -0500
From: Meelis Roos <mroos@linux.ee>
To: arne@schirmacher.de, linux-kernel@vger.kernel.org
Subject: Re: strange interaction between IDE and ieee1394 driver
In-Reply-To: <01C0532B.427002B0.arne@schirmacher.de>
User-Agent: tin/1.4.1-19991201 ("Polish") (UNIX) (Linux/2.4.0-test10 (i586))
Message-Id: <E13xxfs-0000HO-00@roos.tartu-labor>
Date: Mon, 20 Nov 2000 22:36:24 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AS> When I user the ieee1394 subsystem to transmit data from a camcorder to an 
AS> IDE disk and the IDE driver is not using DMA, then there will be some data 
AS> lost in the ieee1394 driver. If I turn on DMA in the IDE driver (hdparm -d1 
AS> /dev/hda), I do not have any data loss in the ieee1394 driver. Also, on a 

IDE is blocking interrupts for too long in non-DMA mode? Try hdparm -u 1
in non-dma mode - this may help if interrupt latency is the issue.

-- 
Meelis Roos (mroos@linux.ee)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129881AbRAJHbn>; Wed, 10 Jan 2001 02:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131698AbRAJHbY>; Wed, 10 Jan 2001 02:31:24 -0500
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:13831 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S129881AbRAJHbV>; Wed, 10 Jan 2001 02:31:21 -0500
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.kernel.org
Date: Wed, 10 Jan 2001 08:31:22 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: 2.2.18: writing an R/O floppy
Message-ID: <3A5C1DCE.19065.27109F@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I don't know if it's possible to make fd a read-only device if the 
inserted media is write-protected, but I had a strange problem:

I had inserted a write protected floppy and accessed it via autofs as 
vfat in 2.2.18. It worked. Some time later it had expired (and I'm not 
sure whether I had changed floppies in the meantime).

When I tried an "mdel a:*", it did terminate without message, but a 
later "mdir a:" showed all the files there. The kernel had 
unsuccessfully tried to write to the floppy however.

It's a bit hard to reproduce that, but I could guess that the disc-
change ore write-protect status was not updated in some case.

Maybe it rings some bell for one of you; if not, never mind.

Regards,
Ulrich

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275958AbSIVAAx>; Sat, 21 Sep 2002 20:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275973AbSIVAAx>; Sat, 21 Sep 2002 20:00:53 -0400
Received: from sdsl-64-7-1-79.dsl.lax.megapath.net ([64.7.1.79]:13261 "EHLO
	sdsl-64-7-1-79.dsl.lax.megapath.net") by vger.kernel.org with ESMTP
	id <S275958AbSIVAAw>; Sat, 21 Sep 2002 20:00:52 -0400
Date: Sat, 21 Sep 2002 17:06:00 -0700 (PDT)
From: <bpape@trolloc.com>
X-X-Sender: <bpape@sdsl-64-7-1-79.dsl.lax.megapath.net>
To: <linux-kernel@vger.kernel.org>
Subject: ide_scsi problems in 2.4.20-pre7-ac3
Message-ID: <Pine.LNX.4.33.0209211657520.1512-100000@sdsl-64-7-1-79.dsl.lax.megapath.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been having problems with a Plextor CD-R connected to a PDC20268 
(Promise Ultra-100TX) using the UDMA-2 and the ide_scsi driver since the 
driver first appeared.  It's been improving, but as of 2.4.20-pre7-ac3, 
I'm still having problems.  The card is in a 33Mhz slot on a Micronics 
W6LI board.

When I write to the drive (hdg, seen as scsi ID 0) with cdrecord, it will
write successfully for some time (usually 30 MB or more, sometimes even
completing a write), whereas in older kernels it would fail between 1-4
MB.

The only log message I get is
ide_scsi: scatter/gather table too small, padding with zeroes.

and about 10 seconds later the system hangs.

Related to this is that after this happens and I restart the machine, the 
PDC20268 drivers will report timeouts resetting the card, and the only way 
to regain control of the CD-R is to power the machine down.
(I will send this in a seperate message).


Thanks.


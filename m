Return-Path: <linux-kernel-owner+w=401wt.eu-S1751401AbXAFO0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbXAFO0s (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 09:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbXAFO0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 09:26:48 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:49266 "EHLO
	pfepb.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401AbXAFO0r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 09:26:47 -0500
Subject: libata error handling
From: Kasper Sandberg <lkml@metanurb.dk>
To: LKML Mailinglist <linux-kernel@vger.kernel.org>, jgarzik@pobox.com,
       alan@lxorguk.ukuu.org.uk
Content-Type: text/plain
Date: Sat, 06 Jan 2007 15:26:28 +0100
Message-Id: <1168093588.1512.8.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

i have a question in regards to libata's error handling, specifically
with pata drivers.

ill start by explaining something that happens to me using the normal
ide drivers (via ide and pdc202 new)

this is what i get when it has been used for a while:
hde: dma_intr: bad DMA status (dma_stat=75)
hde: dma_intr: status=0x50 { DriveReady SeekComplete }
ide: failed opcode was: unknown
hde: dma_timer_expiry: dma status == 0x60
hde: DMA timeout retry
PDC202XX: Primary channel reset.
hde: timeout waiting for DMA

its ALWAYS hde, and its on the promise controller, i attempted to
replace the promise controller by other controllers, but i got the same
error. i have tried replacing cables too, and swapping around
harddrives, its ALWAYS the last harddrive that gets me this. after this,
my raid (6x300gb drives in raid5) would go nuts, as if the data was
there, but skewed, so i got it all from an offset.

this has been going on since always on this box, from .15 to .17, but
now i updated to .20-rc3-git4, and went over to the pata-on-libata
drivers, where i think this has stopped, or atleast, its not causing
WEIRD errors anymore, i have observed some stalls, but im not sure this
is due to it doing this, or simply syncing. i get no messages like this
from the kernel anymore.

i have heard that libata has much better error handling (this is what
made me try it), and from initial observations, that appears to be very
true, however, im wondering, is there something i can do to get
extremely verbose information from libata? for example if it corrects
errors? cause i'd really like to know if it still happens, and if i
perhaps get corruption as before, even though not severe.


Regards,
Kasper Sandberg


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293721AbSCKM3X>; Mon, 11 Mar 2002 07:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293722AbSCKM3P>; Mon, 11 Mar 2002 07:29:15 -0500
Received: from dire.bris.ac.uk ([137.222.10.60]:27339 "EHLO dire.bris.ac.uk")
	by vger.kernel.org with ESMTP id <S293721AbSCKM3C>;
	Mon, 11 Mar 2002 07:29:02 -0500
Date: Mon, 11 Mar 2002 12:26:51 +0000 (GMT)
From: Josh Howlett <Josh.Howlett@bristol.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: PCMCIA problem: writing to Intel Flash Series 2+
Message-ID: <Pine.SOL.3.95q.1020311121407.9331B-100000@shark.cse.bris.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary:

I can read, but not write to or erase, an Intel Series 2+ flash card.

In the event of a reply, please Cc to my email address, as I am no
subscribed.

Hardware:

Toshiba Tecra 8100 laptop
Intel Series 2+ flash memory card

Software:

Linux 2.4.17
pcmcia-cs-3.1.33

Detail:

When I insert the flash card, the card is correctly recognised and the
appropriate modules load.  If I do a "cat /dev/mem0c0c" I get a load of
gibberish on the console, which I assume indicates that I am reading
from the card.

If I attempt to format the card, I get the following error:

	$ ftl_format /dev/mem0c0c
	Partition size = 8 mb, erase size = 128 kb, 1 transfer units
	Reserved 5%, formatted size = 7755264 bytes
	Erasing all blocks...

	block erase failed: input/output error
	format failed.

Querying the card, I get:

	$ ftl_check /dev/mem0c0c
	Memory region info:
	  Card offset = 0x0, region size = 8 mb, access speed = 150 ns
	  Erase block size = 128 kb, partition multiple = 128 kb

	No valid erase unit headers!

The following gets reported to the log:

	kernel: iflash2+_mtd: erase timed out!
	kernel: CSR = 0x0000, BSR = 0x4040, GSR = 0x0606

Is there any other info that would be useful?

Thanks in advance...

josh.

---------------------------------------
Josh Howlett, Network Support Officer,
Networking & Digital Communications,
Information Systems & Computing,
University of Bristol, U.K.
0117 928 7850 | josh.howlett@bris.ac.uk
---------------------------------------


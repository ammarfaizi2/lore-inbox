Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbTIYPBX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 11:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbTIYPBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 11:01:23 -0400
Received: from alpha.tmit.bme.hu ([152.66.246.10]:28947 "EHLO alpha.ttt.bme.hu")
	by vger.kernel.org with ESMTP id S261267AbTIYPBU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 11:01:20 -0400
Message-Id: <200309251501.h8PF14mc014760@alpha.ttt.bme.hu>
From: "Horvath Gyorgy" <HORVAATH@tmit.bme.hu>
Organization: DTT_BUTE
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Thu, 25 Sep 2003 16:57:23 +0200
Subject: SGA155D DMA Burst length question - Memory to S5933
X-mailer: Pegasus Mail v3.22
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am on the way developing the driver for SGA155D.
The core driver is OK. I simply copy the firmware.bin file
to /dev/sga155d0, and after the firmware identification -
a proper satellite driver is loaded - actually the POS
(Packet Over SONET).
I can then ifconfig my pos0 - and here weeee goooo.

Now I can DMA well from the card to the PC memory -
even for long-bursts. The data is OK.
I see on the oscilloscope a short transfer at the beginning
(8 DWORDS or so) - a little gap, and the rest go smoothly
in one long piece.

I tried then to DMA from the PC memory to the card.
What I see is: 9 DWORDS, some 9+more gap, 9 DWORDS, some 9 more gap,
etc...
I'd like to see a smooooooooooth transfer - not that 50%.

I have S5933 on-board, and I find some issues elsewhere
about advanced PCI commands when spanning across cache-lines,
but I am not sure that is the issue... (MR/MRL/MRM)
Can S5933 do them?

Any tips/suggestions?

Also, what is the suggested burst size under Linux for
such a NET device like mine? (cca. 2x 140 Mbps, MTU is 4470)


Thanks for in advance:
Gyuri


Gyorgy Horvath,        Technical University of Budapest
--------------         Dept. of Telecom. and Telematics

Tel.: +36-1-463-1865,  Fax.: +36-1-463-1865
Mail: horvaath@bme-tel.ttt.bme.hu
FTP:  ttt-pub.ttt.bme.hu  ./income

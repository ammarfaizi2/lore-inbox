Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135945AbREABSO>; Mon, 30 Apr 2001 21:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135946AbREABSF>; Mon, 30 Apr 2001 21:18:05 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:54278 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135945AbREABSA>; Mon, 30 Apr 2001 21:18:00 -0400
Subject: DPT I2O RAID and Linux I2O
To: linux-kernel@vger.kernel.org
Date: Tue, 1 May 2001 02:22:06 +0100 (BST)
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14uOrh-0000sV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A few people have asked about the dpt_i2o driver recently. If you have a DPT
I2O card please try a late 2.4.3-ac kernel. It should now work when you do
'modprobe i2o_scsi'

After a lot of reviewing of the dpt driver I figured out what command was
upsetting the beast and added a workaround for it. I also fixed a pile of
bugs in the drivers that caused failed table queries to corrupt memory
in some cases (the DPT tended to trigger these and so made the box reboot
if you used i2oproc or i2oconfig.

I'd also like to say thanks to DPT (now Adaptec) for supplying me with a card
which meant that in combination with their driver I was eventually able to
figure out the cure.

More feedback from DPT i2o raid card users would be useful

Alan


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262578AbSJBUqg>; Wed, 2 Oct 2002 16:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262579AbSJBUqg>; Wed, 2 Oct 2002 16:46:36 -0400
Received: from 62-190-202-77.pdu.pipex.net ([62.190.202.77]:8708 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S262578AbSJBUqg>; Wed, 2 Oct 2002 16:46:36 -0400
Date: Wed, 2 Oct 2002 21:55:27 +0100
From: jbradford@dial.pipex.com
Message-Id: <200210022055.g92KtRbV000226@darkstar.example.net>
To: linux-kernel@vger.kernel.org
Subject: 2.5.x fixes IDE sleep problems, (hdparm -Y), on PIIX3, (at least).
Cc: alan@lxorguk.ukuu.org.uk, cogwepeter@cogweb.net, davidsen@tmr.com,
       diegocg@teleline.es, mlord@pobox.com, padraig.brady@corvil.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We were discussing some time ago about IDE drives not waking up from a sleep command, (I.E. hdparm -Y as opposed to a standby, hdparm -y), and this is indeed true at least for a Maxtor drive on my PIIX3 chipset, running 2.4.19.

However, with 2.5.40 it _does_, (eventually, after about 20 seconds), reset the disk.  Here is the output of dmesg:

hda: dma_timer_expiry: dma status == 0x21
hda: timeout waiting for DMA
hda: timeout waiting for DMA
hda: (__ide_dma_test_irq) called while not waiting
hda: status timeout: status=0xd0 { Busy }

hda: drive not ready for command
ide0: reset: success

So, this seems to be fixed in the 2.5.X IDE code.

John.

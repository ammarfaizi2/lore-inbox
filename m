Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932521AbWBXV0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521AbWBXV0Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 16:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932523AbWBXV0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 16:26:16 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:7561 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932521AbWBXV0P convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 16:26:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=TKztiz/wdCa4S02G6x3bK0SdYBDg2yqNhpP2Guabs+WF3wH7I4k9QI6TsR0E0yR0C4wERiuSbUzR48sElxGiP+qtwprZDD+gZ10SC2HLmQDmTqy89zMxeg0DVaJNvrb8blE8MxnbqbE2w3zWnc+DsrVQLUAFmx78X4vL/ytGy6o=
Message-ID: <305c16960602241326j35b71447g6540fa7f252b7e0e@mail.gmail.com>
Date: Fri, 24 Feb 2006 18:26:14 -0300
From: "Matheus Izvekov" <mizvekov@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: IT8212 ide controller problem
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

As of kernel 2.6.15.4, i get this during bootup:

IT8212: chipset revision 17
it821x: controller in smart mode.
IT8212: 100% native mode on irq 193
    ide2: BM-DMA at 0xac00-0xac07, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xac08-0xac0f, BIOS settings: hdg:pio, hdh:pio
Probing IDE interface ide2...
Probing IDE interface ide3...
hdg: ST320410A, ATA DISK drive
hdg: Performing identify fixups.
ide3 at 0xa400-0xa407,0xa802 on irq 193
hdg: max request size: 128KiB
hdg: 39102336 sectors (20020 MB) w/2048KiB Cache, CHS=38792/16/63, BUG
hdg: cache flushes not supported
 hdg:hdg: recal_intr: status=0x51 { DriveReady SeekComplete Error }
hdg: recal_intr: error=0x04 { DriveStatusError }
ide: failed opcode was: unknown
 hdg1

This error doesnt happens if the same hd is connected to another ide
controller on the same machine.
Otherwise everything is fine, i have dma working at reasonable speed.

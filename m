Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264878AbUEQCPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264878AbUEQCPd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 22:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264880AbUEQCPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 22:15:33 -0400
Received: from main.gmane.org ([80.91.224.249]:10683 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264878AbUEQCPR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 22:15:17 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Mike <Mike@kordik.net>
Subject: HDIO_SET_DMA failed: with nforce2 board
Date: Sun, 16 May 2004 22:15:02 -0400
Message-ID: <pan.2004.05.17.02.15.01.317598@kordik.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: user-12l2mtd.cable.mindspring.com
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an nforce2 based board and I cannot enable dma.

# hdparm -i /dev/hda
 
/dev/hda:
 
 Model=Maxtor 6Y120L0, FwRev=YAR41BW0, SerialNo=Y411HHFE
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=240119615
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 udma4 udma5 *udma6
 AdvancedPM=yes: disabled (255) WriteCache=enabled
 Drive conforms to: (null):

In my .config:
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_AMD74XX=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y

I am running kernel 2.6.4-rc1-mm1

What am I missing? 

Thx


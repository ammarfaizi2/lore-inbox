Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318366AbSHEKq0>; Mon, 5 Aug 2002 06:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318367AbSHEKq0>; Mon, 5 Aug 2002 06:46:26 -0400
Received: from mailg.telia.com ([194.22.194.26]:728 "EHLO mailg.telia.com")
	by vger.kernel.org with ESMTP id <S318366AbSHEKq0> convert rfc822-to-8bit;
	Mon, 5 Aug 2002 06:46:26 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="us-ascii"
From: Daniel Ahlberg <aliz@telia.com>
To: linux-lvm@sistina.com, linux-kernel@vger.kernel.org
Subject: Moving LVM data off a bad disk
Date: Mon, 5 Aug 2002 12:49:58 +0200
User-Agent: KMail/1.4.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200208051249.58901.aliz@telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Recently one of my harddisks began to develop bad sectors. I decided to add a 
another disk to replace the disk and run pvmove -i to salvgage as much as 
possible to the spare disk. But, the process takes seems to take ages. For 
every bad sector pvmove encounters it takes 5 seconds for the kernel to 
timeout and move on to the next sector. Some calculation would tell me that 
it would take approx 6 years to go through the rest of the disk.

So, is there any way to speed up this? I was thinking in the ways of reducing 
the 5 second timeout or having the disk driver simply skip the bad sectors.

These are the errors I get:

Aug  4 00:01:31 springbird kernel: hdc: dma_intr: status=0x51 { DriveReady 
SeekComplete Error }
Aug  4 00:01:31 springbird kernel: hdc: dma_intr: error=0x40 { 
UncorrectableError }, LBAsect=34880281, sector=34880218
Aug  4 00:01:31 springbird kernel: end_request: I/O error, dev 16:01 (hdc), 
sector 34880218
Aug  4 00:01:36 springbird kernel: hdc: dma_intr: status=0x51 { DriveReady 
SeekComplete Error }
Aug  4 00:01:36 springbird kernel: hdc: dma_intr: error=0x40 { 
UncorrectableError }, LBAsect=34880283, sector=34880220
Aug  4 00:01:36 springbird kernel: end_request: I/O error, dev 16:01 (hdc), 
sector 34880220


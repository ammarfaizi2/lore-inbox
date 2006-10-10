Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965171AbWJKIuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965171AbWJKIuj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 04:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965183AbWJKIuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 04:50:39 -0400
Received: from mail.first.fraunhofer.de ([194.95.169.2]:50149 "EHLO
	mail.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S965171AbWJKIui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 04:50:38 -0400
Subject: hda: DMA timeout error
From: Soeren Sonnenburg <kernel@nn7.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 10 Oct 2006 16:46:38 +0000
Message-Id: <1160498799.24402.99.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear List,

could someone knowledgeable please comment on this ?

I had a working raid-1 setup(tm) with two western digital drives being
connected to a via and a highpoint controller. Now all I did is to
replace ide disks (now hitachi) and suddenly I frequently see disks (on
one of the controllers, sometimes hda sometimes hde) to plop out:

hda: lost interrupt
hda: dma_timer_expiry: dma status == 0x21
hda: DMA timeout error
hda: dma timeout error: status=0x58 { DriveReady SeekComplete
DataRequest }
ide: failed opcode was: unknown
raid1: Disk failure on hda, disabling device. 
        Operation continuing on 1 devices
hda: dma_timer_expiry: dma status == 0x21
hda: DMA timeout error
hda: dma timeout error: status=0x58 { DriveReady SeekComplete
DataRequest }
ide: failed opcode was: unknown
RAID1 conf printout:
 --- wd:1 rd:2
 disk 0, wo:1, o:0, dev:hda
 disk 1, wo:0, o:1, dev:hde
RAID1 conf printout:
 --- wd:1 rd:2
 disk 1, wo:0, o:1, dev:hde

I simply don't understand what's wrong ... when I hot remove the drive
turn on DMA and hot add the drive everything is fine again ... could one
increase timeouts or try some more mature driver which has some more
error recovery ? This is on kernel 2.6.17.13 ... 2.6.18 refuses to boot
(kills the hotplug process repeatedly claiming the machine ran out of
memory).

Any thoughts ?
Soeren
-- 
For the one fact about the future of which we can be certain is that it
will be utterly fantastic. -- Arthur C. Clarke, 1962

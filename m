Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274723AbTHKVcz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 17:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274813AbTHKVcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 17:32:55 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.18]:57879 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S274723AbTHKVcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 17:32:54 -0400
Subject: Re: Apacer SM/CF combo reader driver
From: Harm Verhagen <h.verhagen@chello.nl>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1060637573.18663.10.camel@i141046.upc-i.chello.nl>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 Aug 2003 23:32:54 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    I've got an Apacer SM/CF combo reader too. I found your email :
            
>            I just got myself an Apacer SM/CF combo reader, USB
07c4:a109. 
>            The CF part is supported in the stock kernel (by
datafab.c), 
>            the SM part is not. 


I needed to compile the kernel (RedHat 2.4.20-19.9) with the "Probe all
LUNs on each device" option enabled (CONFIG_SCSI_MULTI_LUN) in order to
access the SM on my apacer combo reader (0x0d7d:0x0240).

Or you can manually add it by something like:
echo scsi add-single-device 1 0 0 1 > /proc/scsi/scsi

With one of the above SM access on my device works fine. I can mount it
using:
mount -t vfat /dev/sdb1 /mnt/usbreader

I got this info from:
http://www.qbik.ch/usb/devices/showdev.php?id=1620
http://www.qbik.ch/usb/devices/showdev.php?id=1634


regards,
Harm Verhagen



-- 
Harm Verhagen <h.verhagen@chello.nl>


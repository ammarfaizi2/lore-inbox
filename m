Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267452AbUHDVnX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267452AbUHDVnX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 17:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267446AbUHDVld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 17:41:33 -0400
Received: from home.geizhals.at ([213.229.14.34]:7300 "EHLO
	morework.geizhals.at") by vger.kernel.org with ESMTP
	id S267443AbUHDVkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 17:40:13 -0400
Message-ID: <4111577A.9010901@geizhals.at>
Date: Wed, 04 Aug 2004 23:39:06 +0200
From: "Marinos J. Yannikos" <mjy@geizhals.at>
User-Agent: Mozilla Thunderbird 0.7.1 (Windows/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.7 SATA (SCSI emulation) sw-raid1 - lockup when 1 drive is removed
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A box with a stock 2.6.7 kernel using the Promise SX4 controller 
(CONFIG_SCSI_SATA_SX4, i.e. libata driver) locks up completely when one 
of the 2 drives in a raid 1 configuration is removed. I believe this is 
not how raid 1 is supposed to work. ;-) swap was initially on the drive 
   I removed only (/dev/sdb2), but I also tested this with swap on a 
raid volume (/dev/md2 = /dev/sdb2 + /dev/sdc2)- the effect is exactly 
the same in both cases.

The last message seen is: "ata1 DMA timeout", then the console stops 
working. dmesg output and config.gz available at: 
http://stuff.geizhals.at/misc/2004-08-04/

Perhaps there is a work-around or this issue can be resolved quickly 
before one of the drives actually dies...

Regards,
  Marinos
-- 
Dipl.-Ing. Marinos Yannikos, CEO
Preisvergleich Internet Services AG
Obere Donaustrasse 63, A-1020 Wien
Tel./Fax: (+431) 5811609-52/-55

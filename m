Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313181AbSIDRxD>; Wed, 4 Sep 2002 13:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313190AbSIDRxD>; Wed, 4 Sep 2002 13:53:03 -0400
Received: from anor.ics.muni.cz ([147.251.4.35]:19844 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id <S313181AbSIDRxC>;
	Wed, 4 Sep 2002 13:53:02 -0400
Date: Wed, 4 Sep 2002 19:57:29 +0200
From: Jan Kasprzak <kas@informatics.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: IDE write speed (Promise versus AMD)
Message-ID: <20020904195729.A3985@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello, all!

	I have a machine with six identical IDE drives (WD1200BB),
three of them connected to the on-board controller (it is AMD 768MPX chipset),
and other three are connected to the Promise controller (PDC 20269).
All drives are UDMA 100, read speed measured by "hdparm -t /dev/hd[abcefg]"
is about 45 MBytes/s for every drive. However, the write speed seems
to differ between AMD and Promise controllers. I've tried to do

time sh -c 'dd if=/dev/zero of=/dev/hdX bs=1024k count=2048; sync'

- it takes about 50 seconds (~40 MByte/s write speed) on hda, hdb and hdc,
but 2 minutes 48 seconds (~12 MByte/s write speed) on hde, hdf and hdg.
I have 1 GB of RAM, server is dual athlon 2000+. Kernel is 2.4.20-pre5-ac1.

	Is there any problem with the Promise IDE driver on Linux?

	Thanks,

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
       Pruning my incoming mailbox after being 10 days off-line,
       sorry for the delayed reply.

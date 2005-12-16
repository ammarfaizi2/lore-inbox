Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932252AbVLPPdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbVLPPdy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 10:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbVLPPdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 10:33:54 -0500
Received: from moutvdom.kundenserver.de ([212.227.126.249]:30701 "EHLO
	moutvdomng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932252AbVLPPdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 10:33:54 -0500
Message-ID: <43A2DE5F.7060108@anagramm.de>
Date: Fri, 16 Dec 2005 16:33:51 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: IDE: PDC20275 turning on/off DMA dangerous?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I am working on an embedded ppc (mpc8540) using a pretty common Promise IDE
PCI controller w/ a PDC20275 on it (it's called Ultra TX2).
I have an otherwise good Maxtor 6B120P0 (160GB) connected to it.

But sometimes (expecially with more than zero disk-i/o-load), when I
turn on DMA by

$hdparm -X69 -d1 /dev/hda
I get 

hda: task_out_intr: status=0x58 { DriveReady SeekComplete DataRequest }
ide: failed opcode was: unknown
hda: CHECK for good STATUS

And when I turn off DMA with 
$hdparm -d0 /dev/hda
I get sometimes a

hda: DMA disabled

which is fine but sometimes I also get:

hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
ide: failed opcode was: unknown
hda: drive not ready for command
hda: CHECK for good STATUS

which is not so nice.
Can you tell me if this is dangerous?

$ uname -a 
Linux ecam.anagramm.de 2.6.13-rc7 #5 Thu Aug 25 15:33:38 CEST 2005 ppc ppc ppc GNU/Linux

I am about to update to the latest 2.6.15-rc5.

Thanks,
-- 
Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19

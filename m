Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265196AbUAJIAw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 03:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265198AbUAJIAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 03:00:52 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:30943 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S265196AbUAJIAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 03:00:50 -0500
Message-ID: <3FFFB1AD.5050307@boergens.de>
Date: Sat, 10 Jan 2004 09:02:53 +0100
From: Kevin Boergens <kevin@boergens.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.5) Gecko/20031007
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: cs5530_set_xfer_mode
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:e39b2c33c20867b2edbd9f79b3c25ad5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Maybe this is a question to stupid for this list,
but I asked for it in de.comp.os.unix.linux.hardware
<bt8tln$4htn0$1@ID-213387.news.uni-berlin.de> and on the Debian user
mailing list, and although many people tried, nobody could help me.

I have a server with a National Semiconductor CS5530 southbridge
(http://www.national.com/pf/CS/CS5530.html) and after booting it only
worked in MDMA2. I tried to force it with hdparm -d1X66 but that caused
only nasty messages on syslog, like:

***********************************************************************
Jan  5 16:46:14 server kernel: hda: timeout waiting for DMA
Jan  5 16:46:14 server kernel: ide_dmaproc: chipset supported
ide_dma_timeout fu
nc only: 14
Jan  5 16:46:14 server kernel: hda: status error: status=0x58 {
DriveReady SeekC
omplete DataRequest }
Jan  5 16:46:14 server kernel: hda: drive not ready for command
**********************************************************************

I tried this with the Debian kernel images 2.4.18-bf2.4 and
2.2.20-idepci and with several disks, all the same.



I would have given up hope already, if I had not found out that the
S.u.S.E. 7.3 kernel 2.4.10-4GB has no problem with this chipset at all.
While booting, the kernel says:

hda WDC[...]
ide0 at 0x[...] on irq14
hda: cs5530_set_xfer_mode(UDMA2)

And everything works as fast as I want.
My questions:

1) What's the differences in the kernels to cause this behavior?
2) How do I get my Debian kernel to behave alike?



Any help GREATLY appreciated,
	Kevin

-- 
http://www.boergens.de



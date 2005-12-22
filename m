Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030186AbVLVOW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030186AbVLVOW1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 09:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030188AbVLVOW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 09:22:27 -0500
Received: from s176.evanzo-server.de ([62.67.235.176]:17766 "EHLO
	mx12.evanzo-server.de") by vger.kernel.org with ESMTP
	id S1030186AbVLVOW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 09:22:26 -0500
Message-ID: <43AAB8A2.7020506@daviddasenbrook.de>
Date: Thu, 22 Dec 2005 15:30:58 +0100
From: David Dasenbrook <david@daviddasenbrook.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel hangs trying to speak to DVD-ROM
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I am sending this to the linux-kernel mailing list because I am almost 
sure that this is a bug in the linux kernel. If it's not, please forgive 
me and just ignore this message.
I have this weird problem, and I would appreciate if someone could give
me a hint on how to solve it:
Whenever I connect a DVD-ROM drive (ANY DVD-Drive, not just a specific
one) to my computer via the onboard IDE-connector, I cannot boot the 
kernel any
more. The last message the kernel prints (actually, I think it's the
ide-cd module) after getting hung up is this:

hdc: packet command error: status=0x51 { DriveReady SeekComplete Error }
hdc: packet command error: error=0x04
hdc: request sense failure: status=0x51 { DriveReady SeekComplete Error }
hdc: request sense failure: error=0x04Aborted Command

I tried using the first and the second IDE channel, using the drive as
master and slave. The strange thing is that CD-drives work perfectly
fine, this happens just with DVD-Drives. Those DVD-Drives work fine in
another computer with the exact same kernel.
My mainboard is an AK70 by DFI, I think the onboard IDE-controller is the
AMD7409 (that's what the kernel says.) I use Linux 2.6.11.
2.4.x kernels don't work either, real old distributions with kernel 2.2
or lower do.
After playing around a bit, I found the DVD works when I type
"hdc=noprobe hdc=cdrom" on the kernel command line. But still, I cannot
do that when trying to run the debian installer or installers of debian
derivatives. When detecting the DVD-ROM drive, the installer just hangs
and I can't do anything any more but reboot. Not to speak of being able 
to use DMA.
I find this really strange, maybe someone has a clue. If not, thanks
anyway for taking the time to read this message.
If you reply to this, please send me a CC.
Thank you,
David Dasenbrook



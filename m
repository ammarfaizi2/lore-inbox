Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264344AbTEaPQu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 11:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264354AbTEaPQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 11:16:50 -0400
Received: from [200.138.105.201] ([200.138.105.201]:32897 "EHLO
	PolesApart.wox.org") by vger.kernel.org with ESMTP id S264344AbTEaPQt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 11:16:49 -0400
Message-ID: <3ED8CA77.9030809@PolesApart.wox.org>
Date: Sat, 31 May 2003 12:29:59 -0300
From: Alexandre Pereira Nunes <alex@PolesApart.wox.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: pt-br, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-rc6 ide-scsi bug?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My system (athlon on an asus mb with via kt133 chipset) is currently 
running 2.4.21-rc6 (but I had similar behaviour with 2.4.21-rc2-ac2), 
and I map my ide cdrom to ide-scsi by passing option ide-cd ignore in 
modules.conf (devfs is enabled, so that the modules load at /dev/cdrom 
request).

Sometimes my cd drive (actually a mdma2 enabled combo dvd reader/cdrw 
writer lg 4120B) seems to 'sleep' after a long time of inactivity and 
waking it up (i.e. by trying to mount the unit) takes a time, so 
eventually the system has to do a "soft" bus reset so that it comes to 
life again (maybe it actually does that because the drive takes too long 
to wake up by itself, but I don't know). If I use ide-cd instead of 
ide-scsi, it happens as described and the system works ok (the kernel 
prints dma disabled but if I enable it back it works fine), but with 
ide-scsi, after the kernel prints that atapi reset and dma disabled 
stuff, the system hangs. nothing else is printed, and my caps lock and 
scroll lock keys starts blinking, so it seems to be a serious kernel 
panic, but nothing about that is printed on the screen even when I'm at 
console.

Older kernels i've tried (2.4.20 and 2.4.21-pre7) seems to behave ok.

I work around by using ide-cd until I need ide-scsi for something (like 
tunning the rpc2 features on the drive to change region settings for dvd 
playing), and replacing the driver by hand after making sure the drive 
is ok, but that actually sucks :-)

Thanks in advance,

Alex





Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263215AbTKEVce (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 16:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263221AbTKEVce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 16:32:34 -0500
Received: from pop.gmx.de ([213.165.64.20]:21439 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263215AbTKEVcc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 16:32:32 -0500
X-Authenticated: #4512188
Message-ID: <3FA96CD9.5020403@gmx.de>
Date: Wed, 05 Nov 2003 22:34:17 +0100
From: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031102
X-Accept-Language: de-de, de, en-us, en
MIME-Version: 1.0
To: Krisztian VASAS <iron@ironiq.hu>, linux-kernel@vger.kernel.org
Subject: Re: Problem in 2.6.0-test9-mm1 with siimage+hdparm
References: <1068060376.757.44.camel@localhost.localdomain>
In-Reply-To: <1068060376.757.44.camel@localhost.localdomain>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krisztian VASAS wrote:
> Hello all...
> 
> I've got an Abit NF7-S v2.0 mainboard with an Athlon XP 2000+ CPU.
> 
> Yesterday I've compiled the 2.6.0-test9 kernel with -mm1 patch. My
> system is on the first sata device (/dev/hde).
> 
> After reboot I've noticed an Oops after setting dma and other settings
> with hdparm. Without -mm1 patch the machine works well. 
> 
> After the oops I've tried to find what the problem was. 
> 
> hdparm -c1 /dev/hde -> nothing was happened, switched off...
> hdparm -d1 /dev/hde -> Oops...
> 
> I've got this messages:
> 
> hde: DMA timeout retry status error: status=0x58 { DriveReady
> SeekComplete DataRequest }
> 
> ide2: reset phy, status=0x00000113 siimage_reset

Strange enough I have an Abit NF7-s Rev2.0 as well, but for me the 
driver works - somehow. I havbe latest bios 1.9 (modified with latest 
silicon image bios). Since siimage 1.06 drvier. I have DMA without using 
hdparm, but it is not as fast as in windows. With kernel 2.6 tranfer 
dropped very much to about 20mb/s (playing with read-aheed didn't help). 
But I am getting this error messages in dmesg and at boot up (that's why 
I commented it out in siimage.c):

hde: sata_error = 0x00000000, watchdog = 0, siimage_mmio_ide_dma_test_irq

Other than that it runs fine - forgetting that performance it bad right 
now. Tried various shedulers, but didn't help. With kernel 2.4.22-ac4 I 
had about 37mb/sec, now only 20mb/sec...

Prakash





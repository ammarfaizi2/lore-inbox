Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263241AbTKEWQJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 17:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263244AbTKEWQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 17:16:09 -0500
Received: from gprs29.vodafone.hu ([80.244.97.79]:59168 "EHLO kian.localdomain")
	by vger.kernel.org with ESMTP id S263241AbTKEWQH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 17:16:07 -0500
Subject: Re: Problem in 2.6.0-test9-mm1 with siimage+hdparm
From: Krisztian VASAS <iron@ironiq.hu>
To: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3FA96CD9.5020403@gmx.de>
References: <1068060376.757.44.camel@localhost.localdomain>
	 <3FA96CD9.5020403@gmx.de>
Content-Type: text/plain
Organization: 
Message-Id: <1068070602.753.56.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 05 Nov 2003 23:16:42 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003-11-05 Prakash K. Cheemplavam wrote:
> Strange enough I have an Abit NF7-s Rev2.0 as well, but for me the 
> driver works - somehow. I havbe latest bios 1.9 (modified with latest 
> silicon image bios). Since siimage 1.06 drvier. I have DMA without using 
> hdparm, but it is not as fast as in windows. With kernel 2.6 tranfer 
> dropped very much to about 20mb/s (playing with read-aheed didn't help). 
> But I am getting this error messages in dmesg and at boot up (that's why 
> I commented it out in siimage.c):
> 
> hde: sata_error = 0x00000000, watchdog = 0, siimage_mmio_ide_dma_test_irq
> 
> Other than that it runs fine - forgetting that performance it bad right 
> now. Tried various shedulers, but didn't help. With kernel 2.4.22-ac4 I 
> had about 37mb/sec, now only 20mb/sec...

I haven't problem with the speed. I'd like to set up DMA to the disk and
the -d switch (using_dma) causes the panic. With vanilla 2.6.0-test9
everything works fine, no speed problem. But if I boot up with -mm1, I
have to work without DMA on hde. And another interesting thing: hdparm
-d1 /dev/hdd works fine, so the problem is somewhere in the siimage
driver. I don't know exactly what changed, but something has been
corrupted around the driver. 


IroNiQ
-- 
Krisztian VASAS <iron@ironiq.hu>


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285866AbRLHHoK>; Sat, 8 Dec 2001 02:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285867AbRLHHoB>; Sat, 8 Dec 2001 02:44:01 -0500
Received: from nlaknet.slt.lk ([203.115.0.2]:45558 "EHLO laknet.slt.lk")
	by vger.kernel.org with ESMTP id <S285866AbRLHHnu>;
	Sat, 8 Dec 2001 02:43:50 -0500
Message-ID: <3C126E47.1DEB8D39@sltnet.lk>
Date: Sat, 08 Dec 2001 13:47:19 -0600
From: Ishan Oshadi Jayawardena <ioshadi@sltnet.lk>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14-lightening i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Hahn <hahn@physics.mcmaster.ca>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: IDE-DMA woes
In-Reply-To: <Pine.LNX.4.33.0112071247050.6985-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hahn wrote:

> > _sometimes_ I get the following message from the kernel
> > after resuming from APM standby mode:
> 
> right, no big surprise there - the bios fails to properly
> restore the ide controller's state.

	Hmmm... I had had some trouble with the BIOS previously;
Specifically, the machine would hang whenever I wanted it to
power-off _or_ reboot (kernel 2.2.16 - 2.2.14 probably had a workaround
which later got dropped). But a BIOS upgrade from IBM fixed that and
some other irrelevent problems; The documentation with the flash didn't
mention anything about DMA (specifically - it may have been hidden in
some fixes said to be necessary for WinNT 5 beta).

> > ide_dmaproc: chipset supported ide_dma_timeout func only: 14
> 
> are you sure this happens near in time to the following?

Yes. and this too:
hda: timeout waiting for DMA
	Just before the message from ide_dmaproc()

> > hda: drive not ready for command
> 
> that's not good.

What does this mean?
 
> > IBM machine detected. Enabling interrupts during APM calls.
> 
> have you tried without this feature?
Not exactly; Some docs I found at the IBM site recommended the user
to configure the kernel to:
(1) Enable APM
(2) Enable PM at boot-time
(3) Enable interrupts during APM BIOS calls.
	It seems that 2.4 kernels detects this and enables interrupts
automatically... I've yet to see what would break if I enable
apm_idled...

Thanks.
		-ioj

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271208AbTGPXAW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 19:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271209AbTGPXAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 19:00:22 -0400
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:19845 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S271208AbTGPW7v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 18:59:51 -0400
Date: Wed, 16 Jul 2003 18:43:17 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, perex@suse.cz
Subject: Re: 2.5.73: ALSA ISA pnp_init_resource_table compile errors
Message-ID: <20030716184317.GC31942@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Adrian Bunk <bunk@fs.tum.de>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>, perex@suse.cz
References: <Pine.LNX.4.44.0306221150440.17823-100000@old-penguin.transmeta.com> <20030622234447.GB3710@fs.tum.de> <20030623000808.GA14945@neo.rr.com> <20030703025343.GC282@fs.tum.de> <20030703190304.GA17707@neo.rr.com> <20030704121124.GB12633@fs.tum.de> <20030715224732.GA31942@neo.rr.com> <20030716182251.GW10191@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716182251.GW10191@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 08:22:52PM +0200, Adrian Bunk wrote:
> On Tue, Jul 15, 2003 at 10:47:32PM +0000, Adam Belay wrote:
> > Could I see the output for 01:01.00/options and 01:01.00/resources also,
> > perhaps it will provide some insight.  I'm guessing the resources may be
> > incorrect in that node.
>
> It's below, this using with 2.6.0-test1 (same dmesg output):
> 
> <--  snip  -->
> 
> # cat /sys/bus/pnp/devices/01\:01.01/resources
> state = active
> io 0x330-0x331
> irq 9
> # cat /sys/bus/pnp/devices/01\:01.01/options
> Dependent: 01 - Priority preferred
>    port 0x330-0x330, align 0xf, size 0x2, 16-bit address decoding
>    irq 2/9 High-Edge
> Dependent: 02 - Priority acceptable
>    port 0x300-0x330, align 0xf, size 0x2, 16-bit address decoding
>    irq 2/9 High-Edge
> Dependent: 03 - Priority functional
>    port 0x300-0x330, align 0xf, size 0x2, 16-bit address decoding
>    irq 2/9,10,11,15 High-Edge
> # cat /sys/bus/pnp/devices/01\:01.00/resources
> state = active
> io 0x220-0x22f
> io 0x388-0x38b
> io 0x500-0x50f
> irq 5
> dma 1
> dma disabled
> # cat /sys/bus/pnp/devices/01\:01.00/options
> Dependent: 01 - Priority preferred
>    port 0x220-0x220, align 0x1f, size 0x10, 16-bit address decoding
>    port 0x388-0x388, align 0x7, size 0x4, 16-bit address decoding
>    port 0x530-0x530, align 0x7, size 0x10, 16-bit address decoding
>    irq 5 High-Edge
>    dma 1 8-bit byte-count type-A
>    dma 3 8-bit byte-count type-A
> Dependent: 02 - Priority acceptable
>    port 0x220-0x240, align 0x1f, size 0x10, 16-bit address decoding
>    port 0x388-0x388, align 0x7, size 0x4, 16-bit address decoding
>    port 0x530-0x530, align 0xf, size 0x10, 16-bit address decoding
>    irq 5,7 High-Edge
>    dma 0,1,3 8-bit byte-count type-A
>    dma 0,1,3 8-bit byte-count type-A
> Dependent: 03 - Priority functional
>    port 0x220-0x280, align 0x1f, size 0x10, 16-bit address decoding
>    port 0x388-0x3b8, align 0x7, size 0x4, 16-bit address decoding
>    port 0x500-0x560, align 0xf, size 0x10, 16-bit address decoding
>    irq 5,7,10 High-Edge
>    dma 0,1,3 8-bit byte-count type-A
>    dma 0,1,3 8-bit byte-count type-A
> Dependent: 04 - Priority functional
>    port 0x220-0x280, align 0x1f, size 0x10, 16-bit address decoding
>    port 0x388-0x3b8, align 0x7, size 0x4, 16-bit address decoding
>    port 0x500-0x620, align 0xf, size 0x10, 16-bit address decoding
>    irq 5,7,10,11 High-Edge
>    dma 0,1,3 8-bit byte-count type-A
>    dma <none> 8-bit byte-count type-A
> Dependent: 05 - Priority functional
>    port 0x220-0x280, align 0x1f, size 0x10, 16-bit address decoding
>    port 0x388-0x3b8, align 0x7, size 0x4, 16-bit address decoding
>    port 0x500-0x620, align 0xf, size 0x10, 16-bit address decoding
>    irq 5,7,2/9,10,11,15 High-Edge
>    dma 0,1,3 8-bit byte-count type-A
>    dma <none> 8-bit byte-count type-A
> # 
> 
> <--  snip  -->
> 
> > Thanks,
> > Adam
> 
> cu
> Adrian
>

Hi Adrian,

Thanks for the information, I think I have a good idea of whats going here.
Notice the disabled dma in node 01:01.00.  The alsa code appears to not be
able to handle a disabled dma for this device.  The offending code is
probably here:

sound/isa/ad1816a/ad1816a_lib.c - line 609 - function snd_ad1816a_create

	if (request_dma(dma2, "AD1816A - 2")) {
		snd_ad1816a_free(chip);
		return -EBUSY;
	}
	chip->dma2 = dma2;

The value of disabled dma2 is -1.  Therefore the request_dma fails because
of this code:

int request_dma(unsigned int dmanr, const char * device_id)
{
	if (dmanr >= MAX_DMA_CHANNELS)
		return -EINVAL;

	if (xchg(&dma_chan_busy[dmanr].lock, 1) != 0)
		return -EBUSY;

	dma_chan_busy[dmanr].device_id = device_id;

	/* old flag was 0, now contains 1 to indicate busy */
	return 0;
} /* request_dma */

Because it is unsigned long it requests dma 0xffff which is greater than
MAX_DMA_CHANNELS and therefore the function returns -EINVAL.

So I'd imagine we could fix the driver to support this... Jaroslav, any
comments?  Perhaps we could use pnp_dma_valid?  Also it would be nice to
add a printk that will display if snd_ad1816a_create fails.

There is one question unanswered however, why is pnp picking the resource
option 4 or possibly 5 (assigning a blank dma).  Its almost as if dma 3 is
in use?

Could I see the following?

1.) the output of /proc/dma
2.) the output of
# cd /sys/bus/pnp/devices
# find */resources | xargs cat | grep dma
3.) the output of
# cd /sys/bus/pnp/devices
# find */resources | xargs cat | grep io

Also there is a kernel parameter to allow dma 0.  It is 'allowdma0' and
I predict the extra dma will get the sound card working.

Thanks,
Adam

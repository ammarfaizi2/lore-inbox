Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131326AbRAMS27>; Sat, 13 Jan 2001 13:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131029AbRAMS2v>; Sat, 13 Jan 2001 13:28:51 -0500
Received: from zeus.kernel.org ([209.10.41.242]:59872 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131332AbRAMSZ6>;
	Sat, 13 Jan 2001 13:25:58 -0500
Date: Sat, 13 Jan 2001 15:22:38 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Thomas Molina <tmolina@home.com>
Cc: linux-kernel@vger.kernel.org
Subject: VIA IDE corruption - anyone experiencing it with 2.4.0?
Message-ID: <20010113152238.G1155@suse.cz>
In-Reply-To: <20010112212427.A2829@suse.cz> <Pine.LNX.4.30.0101130559060.19743-100000@wr5z.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0101130559060.19743-100000@wr5z.localdomain>; from tmolina@home.com on Sat, Jan 13, 2001 at 06:03:11AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 13, 2001 at 06:03:11AM -0600, Thomas Molina wrote:

> Are you looking for specific chipsets or configurations?  Following is
> my VP3/MVP3 chipset lspci output if you are gathering a group of
> testers.  I've enabled autoDMA at various points in the testing cycle
> (not consistently) but haven't noticed any fs corruption.

Ok. So what I'm exactly looking for:

Cases of harddrive corruption (that is, trashing your fs,
reading/writing bad data) on VIA chipsets. UDMA-caused CRC errors don't
fall into this category, they're harmless to the data.

Preferably with the driver from the 2.4.0 kernel. If possible, try also
the VIA 3.11 driver posted to the list earlier. If you don't have it, I
can e-mail it to you.

Don't use any hdparm command in your init scripts (this is important)
with the VIA driver and 2.4.0, setting the speed or dma usage with
hdparm would interfere with the driver autotuning.

If you fear to test, you can mount your fs readonly (no corruption can
happen) and use your swap partition for read-write test. You can even
mke2fs the swap for a while.

Anyone who experienced this kind of problems with 2.4 and the VIA
driver, please speak up, so I can fix it.

I'm not currently looking for success reports, I've already got success
reports for every type VIA IDE chip out there. 

I'll need the motherboard type and revision, lspci -vvxxx, dmesg,
hdparm -i and /proc/ide/via listings ...

Thanks.

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

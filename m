Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129058AbRBFPwz>; Tue, 6 Feb 2001 10:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129201AbRBFPwp>; Tue, 6 Feb 2001 10:52:45 -0500
Received: from cpe-24-221-106-102.az.sprintbbd.net ([24.221.106.102]:37136
	"HELO farnsworth.org") by vger.kernel.org with SMTP
	id <S129058AbRBFPwe>; Tue, 6 Feb 2001 10:52:34 -0500
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Tue, 6 Feb 2001 08:52:23 -0700
To: linux-kernel@vger.kernel.org
Subject: Re: VIA silent disk corruption - patch
Message-ID: <20010206085223.A28894@zenos.local.farnsworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In article <20010205190527.A314@colonel-panic.com>,
Peter Horton <pdh@colonel-panic.com> wrote:
> +      *  VIA VT8363 host bridge has broken feature 'PCI Master Read
> +      *  Caching'. It caches more than is good for it, sometimes
> +      *  serving the bus master with stale data. Some BIOSes enable
> +      *  it by default, so we disable it.

Another data point:

I have an ASUS A7V motherboard with via vt82c686a and Promise pdc20265
IDE controllers.  I noticed disk data corruption when I enabled DMA.     
The corrupted data was 4K bytes long on 4K byte boundaries and occurred
about once for every couple of gigabytes copied via cpio.
I saw this corruption when the disks were connected to the pdc20265
as well as to the 686a.    

I also noticed that turning off read caching eliminated the corruption.

However, if I enable the BIOS parameter "I/O Recovery Time", I can still
enable read caching without seeing any data corruption.
The lastest BIOS revision (1005C) enables "I/O Recovery Time" by default
where the previous revision I had (1004D) did not.

-Dale

-- 

Dale Farnsworth         dale@farnsworth.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

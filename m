Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130487AbRECSWc>; Thu, 3 May 2001 14:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130820AbRECSWW>; Thu, 3 May 2001 14:22:22 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:47822 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S129346AbRECSWN>;
	Thu, 3 May 2001 14:22:13 -0400
Message-ID: <3AF1A1CB.527747F1@mandrakesoft.com>
Date: Thu, 03 May 2001 14:22:03 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Edward Spidre <beamz_owl@yahoo.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Possible PCI subsystem bug in 2.4
In-Reply-To: <Pine.LNX.4.21.0105031106030.30573-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> The question is mainly _which_ power of two.
> 
> I don't think we can round up infinitely, as that might just end up
> causing us to not have any PCI space at all. Or we could end up deciding
> that real PCI space is memory, and then getting a clash when a real device
> tries to register its bios-allocated area that clashes with our extreme
> rounding.
> 
> I suspect it would be safe to round up to the next megabyte, possibly up
> to 64MB or so. But much more would make me nervous.
> 
> Any suggestions?

Is there any chance you could simply test the bottom of PCI address
space?  If you could set up the x86 to trap non-DRAM read/writes
temporarily, you could tell where useable DRAM area stops.

-- 
Jeff Garzik      | Game called on account of naked chick
Building 1024    |
MandrakeSoft     |

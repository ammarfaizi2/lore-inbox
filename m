Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129849AbRBIVoa>; Fri, 9 Feb 2001 16:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130037AbRBIVoU>; Fri, 9 Feb 2001 16:44:20 -0500
Received: from kerberos.suse.cz ([195.47.106.10]:8710 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S129849AbRBIVoD>;
	Fri, 9 Feb 2001 16:44:03 -0500
Date: Fri, 9 Feb 2001 22:44:00 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Henryk Paluch <paluch@KMLinux.fjfi.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RESOLVED]: kernel hangs on CD-R HP8100i if compiled w/ VIA IDE
Message-ID: <20010209224400.B3621@suse.cz>
In-Reply-To: <Pine.LNX.4.10.10101211333300.17469-100000@KMLinux.fjfi.cvut.cz> <Pine.LNX.4.10.10102092200350.11205-100000@KMLinux.fjfi.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10102092200350.11205-100000@KMLinux.fjfi.cvut.cz>; from paluch@KMLinux.fjfi.cvut.cz on Fri, Feb 09, 2001 at 10:18:05PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 09, 2001 at 10:18:05PM +0100, Henryk Paluch wrote:

> Shortly: kernel (2.2.x, 2.4.x) hangs on CD-R HP8100i, VIA KT133 chipset
> (w/ ATA100 support) if kernel is compiled with VIA IDE chipset support.
> Please, see my previous post from 21 Jan 2001 for full description.
> 
>  After little tweaking via82cxxx.c driver I found, that the cause is
> 'Prefetch Buffer: ' (/proc/ide/via) - if disabled for appropriate IDE
> channel, everything works well. It also explains, why the kernel works
> properly if VIA IDE support is not compiled in - BIOS leaves Prefetch
> disabled (I hacked that driver a bit more to show chipset configuration
> either before and after modification).
> 
> So I have a little question: What could be a clean way, to make a kernel
> option to disable prefetch for VIA (use something like 'ide1=noprefetch'?)
> Any idea?

Since version 2.30 of the VIA driver (2.4.2-pre2), the driver leaves
prefetch as is set by BIOS. It seems that ATAPI devices need this set to
off at least on some of the VIA chips.

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

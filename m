Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268301AbUJWDsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268301AbUJWDsO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 23:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268274AbUJWDp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 23:45:27 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:47321 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S266319AbUJVTce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 15:32:34 -0400
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Timothy Miller <miller@techsource.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jon Smirl <jonsmirl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Message-Flag: Warning: May contain useful information
References: <4176E08B.2050706@techsource.com>
	<4177DF15.8010007@techsource.com> <4177E50F.9030702@sover.net>
	<200410220238.13071.jk-lkml@sci.fi> <41793C94.3050909@techsource.com>
	<417955D3.5020206@pobox.com>
From: Roland Dreier <roland@topspin.com>
Date: Fri, 22 Oct 2004 12:32:31 -0700
In-Reply-To: <417955D3.5020206@pobox.com> (Jeff Garzik's message of "Fri, 22
 Oct 2004 14:47:47 -0400")
Message-ID: <52r7nqft0w.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 22 Oct 2004 19:32:31.0646 (UTC) FILETIME=[DFA783E0:01C4B86D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Jeff> 4) I am a bit dubious that FPGA will perform at a useful
    Jeff> clock speed.

    Jeff> 7) two-chip solution

    Jeff> One thing I have pondered, with regards to #6: what about
    Jeff> implementing a multi-core solution?  One core to handle the
    Jeff> graphics operations and control the video, and one core a
    Jeff> much more generic microcontroller that runs ucLinux, and
    Jeff> handles the GL "slow path" stuff.  The advantage of this
    Jeff> approach is

It's might be a bit expensive, but one could use a Xilinx Virtex 4
FPGA.  For example a XC4VFX60 has 16 SERDES (which could be used to
implement a 16X PCI Express link) and two embedded PowerPC 405 cores
(which can be used to run Linux -- there is already existing support
in the kernel for this).  The Virtex 4 can be clocked quite high (300
MHz wouldn't be out of the question), and interfaces like a wide DDR2
controller would be possible as well.

In fact the Virtex 4 has so many cool features it might be hard to
convert the code to an ASIC later....

 - R.


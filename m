Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbVLaK7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbVLaK7h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 05:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbVLaK7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 05:59:37 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:11788 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932134AbVLaK7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 05:59:36 -0500
Date: Sat, 31 Dec 2005 11:56:59 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Chris Stromsoe <cbs@cts.ucla.edu>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: bad pmd filemap.c, oops; 2.4.30 and 2.4.32
Message-ID: <20051231105659.GB5152@w.ods.org>
References: <Pine.LNX.4.64.0512270844080.14284@potato.cts.ucla.edu> <20051228001047.GA3607@dmt.cnet> <Pine.LNX.4.64.0512281806450.10419@potato.cts.ucla.edu> <Pine.LNX.4.64.0512301610320.13624@potato.cts.ucla.edu> <Pine.LNX.4.64.0512301732170.21145@potato.cts.ucla.edu> <20051231071215.GX15993@alpha.home.local> <Pine.LNX.4.64.0512302326360.23044@potato.cts.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512302326360.23044@potato.cts.ucla.edu>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 31, 2005 at 02:39:43AM -0800, Chris Stromsoe wrote:
> On Sat, 31 Dec 2005, Willy Tarreau wrote:
> >On Fri, Dec 30, 2005 at 05:48:15PM -0800, Chris Stromsoe wrote:
> >
> >>I'm starting to suspect bad hardware.  Booting is now hanging (with 
> >>2.4.27, 2.4.30 and 2.4.32) after scsi drivers load:
> >
> >And nothing changed since previous boot, except UP ?
> 
> All I changed was adding nosmp to the kernel boot line.

OK maybe interrupts don't get distributed to the remaining CPU, which
would explain your timeouts.

> >It's not necessarily bad hardware. I also had trouble on one version of 
> >the 29160 bios where it hanged during device scan if there were too many 
> >terminations. Oh, BTW, please check that you have disabled "automatic" 
> >termination in the BIOS. Manually set it either to ON or OFF (low/high 
> >depending on your setup).
> 
> I'll have to check it tomorrow or on Monday.
> 
> >>How likely is it that a failing scsi controller contribute to the other 
> >>problems I was seeing?
> >
> >Not much. Perhaps at worst, a failing controller could corrupt memory by 
> >writing garbage at wrong locations, but you would not always get the 
> >same messages. It seems to be a different problem here. To be honnest, 
> >it's where I think you should try the new driver.
> 
> The machine has been running 2.6.14.4 for the last 6 hours.  It came up 
> fine.  I did not try booting it with nosmp.  If I have time, I will 
> revert back to 2.4 with the newer driver to test.

Thanks.

> -Chris

Willy


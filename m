Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbVLaKjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbVLaKjp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 05:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbVLaKjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 05:39:45 -0500
Received: from smtp-6.smtp.ucla.edu ([169.232.48.138]:30686 "EHLO
	smtp-6.smtp.ucla.edu") by vger.kernel.org with ESMTP
	id S932128AbVLaKjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 05:39:45 -0500
Date: Sat, 31 Dec 2005 02:39:43 -0800 (PST)
From: Chris Stromsoe <cbs@cts.ucla.edu>
To: Willy Tarreau <willy@w.ods.org>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: bad pmd filemap.c, oops; 2.4.30 and 2.4.32
In-Reply-To: <20051231071215.GX15993@alpha.home.local>
Message-ID: <Pine.LNX.4.64.0512302326360.23044@potato.cts.ucla.edu>
References: <Pine.LNX.4.64.0512270844080.14284@potato.cts.ucla.edu>
 <20051228001047.GA3607@dmt.cnet> <Pine.LNX.4.64.0512281806450.10419@potato.cts.ucla.edu>
 <Pine.LNX.4.64.0512301610320.13624@potato.cts.ucla.edu>
 <Pine.LNX.4.64.0512301732170.21145@potato.cts.ucla.edu>
 <20051231071215.GX15993@alpha.home.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Probable-Spam: no
X-Spam-Report: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Dec 2005, Willy Tarreau wrote:
> On Fri, Dec 30, 2005 at 05:48:15PM -0800, Chris Stromsoe wrote:
>
>> I'm starting to suspect bad hardware.  Booting is now hanging (with 
>> 2.4.27, 2.4.30 and 2.4.32) after scsi drivers load:
>
> And nothing changed since previous boot, except UP ?

All I changed was adding nosmp to the kernel boot line.

> It's not necessarily bad hardware. I also had trouble on one version of 
> the 29160 bios where it hanged during device scan if there were too many 
> terminations. Oh, BTW, please check that you have disabled "automatic" 
> termination in the BIOS. Manually set it either to ON or OFF (low/high 
> depending on your setup).

I'll have to check it tomorrow or on Monday.

>> How likely is it that a failing scsi controller contribute to the other 
>> problems I was seeing?
>
> Not much. Perhaps at worst, a failing controller could corrupt memory by 
> writing garbage at wrong locations, but you would not always get the 
> same messages. It seems to be a different problem here. To be honnest, 
> it's where I think you should try the new driver.

The machine has been running 2.6.14.4 for the last 6 hours.  It came up 
fine.  I did not try booting it with nosmp.  If I have time, I will revert 
back to 2.4 with the newer driver to test.


-Chris

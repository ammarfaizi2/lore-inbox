Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263402AbUJ2Pwm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263402AbUJ2Pwm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 11:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263368AbUJ2Pof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 11:44:35 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:51474 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S263369AbUJ2Pc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 11:32:26 -0400
Message-ID: <418265C6.9020308@techsource.com>
Date: Fri, 29 Oct 2004 11:46:14 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Daniel Phillips <phillips@istop.com>
CC: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Some discussion points open source friendly graphics [was: HARDWARE:
 Open-Source-Friendly Graphics Cards -- Viable?]
References: <417D21C8.30709@techsource.com> <417D6365.3020609@pobox.com> <417D8218.9080700@techsource.com> <200410271423.33380.phillips@istop.com>
In-Reply-To: <200410271423.33380.phillips@istop.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Daniel Phillips wrote:
> On Monday 25 October 2004 18:45, Timothy Miller wrote:
> 
>>My intention is to include a bit of logic in the FPGA which can be used
>>to reprogram the prom.  You would then cycle power to get the FPGA to
>>load the new code.
> 
> 
> Power cycle the whole machine, or software-reset the card?

I think you'll have to power-cycle the whole machine.

1) You have to get the FPGA's loader logic to reload the bitstream. 
While there are external signals to get the FPGA to reload, there may be 
a chicken&egg problem with getting soft logic in the FPGA to tell the 
FPGA to reload.

2) When you have reloaded the FPGA, registers are in an unknown state. 
One important thing that is lost if the PCI config space info.  That 
would have to be restored by software.


Is it impossible to soft-reset it?  Maybe not.  But so much is lost and 
broken in the process that it may be highly impractical.

Nevertheless, if there's a way to do it, and the community wants to 
develop it, I'm all in favor.


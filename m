Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266651AbUAOIhJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 03:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266653AbUAOIhI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 03:37:08 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:20983 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S266651AbUAOIhF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 03:37:05 -0500
Message-ID: <4006512A.7080002@mvista.com>
Date: Thu, 15 Jan 2004 00:36:58 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: kgdb for x86_64 2.6 kernels
References: <1cd9t-4Su-65@gated-at.bofh.it> <1coR2-42n-19@gated-at.bofh.it>	<1d3r0-1tw-3@gated-at.bofh.it> <1dbI9-89t-7@gated-at.bofh.it>	<1dEqx-F0-1@gated-at.bofh.it> <1dMRc-6DQ-3@gated-at.bofh.it>	<1e2Mk-6YA-17@gated-at.bofh.it> <1e2Mo-6YA-31@gated-at.bofh.it>	<1e3fi-4nG-5@gated-at.bofh.it> <m3ptdlwsf5.fsf@averell.firstfloor.org>
In-Reply-To: <m3ptdlwsf5.fsf@averell.firstfloor.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> George Anzinger <george@mvista.com> writes:
> 
> 
>>>Raw USB?  Or some kind of USB to serial device?
>>>Remember, USB needs interrupts to work, see the kdb patches for the
>>>mess
>>>that people have tried to go through to send usb data without interrupts
>>>(doesn't really work...)
>>
>>I gave up on USB when I asked the following questions:
> 
> 
> There is a special "USB debugport" specification available that allows
> to drive USB very simply using PIO without too much set up. It should
> be implemented in most chipsets by now because that other operating
> system is using it.
> 
> See e.g. http://www.usb.org/developers/presentations/pres0602/john_keys.pdf
> 
> It works with a simple "debug dongle", that is identical to the 
> USB networking cables that are often sold cheaply.
> 
> If you want to port kgdb to use USB I would use that. USB console
> would also be very useful for debugging laptops and some systems
> with no USB.

Now that is interesting.  As I read it, the debug port is programed the same way 
in all the USB chips (given it exists at all).  AND it is much easier to use. 
Anyone care to put together a polling driver that makes it look like RS232 on 
the host end given that we use a controller to controller cable?


-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml


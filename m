Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262877AbUB0N7I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 08:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262878AbUB0N7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 08:59:08 -0500
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:56075 "EHLO
	anchor-post-30.mail.demon.net") by vger.kernel.org with ESMTP
	id S262877AbUB0N7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 08:59:01 -0500
Message-ID: <403F4D24.6040802@dcrdev.demon.co.uk>
Date: Fri, 27 Feb 2004 13:59:00 +0000
From: Dan Creswell <dan@dcrdev.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: Hard locks under high interrupt load?
References: <403F2237.6080505@dcrdev.demon.co.uk> <Pine.LNX.4.58.0402270744240.17504@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.58.0402270744240.17504@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This box is running Fedora Core 1 and so, yes, it's running a userspace 
balance daemon (Redhat's).

I'll try out the noirqbalance option and get back to the list on that one.

Zwane Mwaikambo wrote:

>On Fri, 27 Feb 2004, Dan Creswell wrote:
>
>  
>
>>I'm having zero success in getting 2.6.3 stable under interrupt load.  I
>>can kill my machine in a variety of fashions all of which appear, to my
>>naive eye, related to interrupt load:
>>
>>(1)   LAN traffic via E1000 card (X is not running)
>>(2)   Running X for more than a few minutes - starting up a couple of
>>applications whilst performing some disk-based activity (such as a
>>compile) usually seems to do the trick.
>>
>>(2) is worth a little more examination.  I have an NVIDIA card (I can
>>hear you all groan) *but* I get the same results with the XFree driver
>>*or* the proprietary NVIDIA driver.
>>
>>Disabling IO-APIC usage seems to resolve the problem.
>>    
>>
>
>Does the 'noirqbalance' kernel parameter also serve as a workaround? Are
>you using any userspace irq balancers?
>
>  
>
>>Machine is a dual Xeon, Tyan S2665 (E7505 chipset) with an MPT-Fusion
>>SCSI controller.
>>
>>2.4.26-pre1 and various other 2.4 kernels give me no problems at all.  I
>>really want to switch my machines over to 2.6 but I can't whilst this
>>problem persists.
>>    
>>
>
>  
>


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbTIXBGU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 21:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbTIXBGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 21:06:20 -0400
Received: from main.gmane.org ([80.91.224.249]:34479 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261235AbTIXBGS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 21:06:18 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Shash Chatterjee <sasvata@badfw.org>
Subject: Re: RH-9 boot hangs from floppy bootdisk
Date: Tue, 23 Sep 2003 20:06:10 -0500
Message-ID: <3F70EE02.1010900@badfw.org>
References: <bkkvb0$so3$1@sea.gmane.org> <1064230425.8593.10.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20030916
X-Accept-Language: en-us, en
In-Reply-To: <1064230425.8593.10.camel@dhcp23.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

Thanks for the suggestion, certainly works far better than before. 
Disabling DMA on IDE does allow me to boot right up.  I was able to use 
up2date and install the 2.4.20-20.9 kernel.  I then made a new bootdisk 
using mkbootdisk.  Booting using the new kernel from floppy got a bit 
further, it actually loaded the kernel fro /dev/hdb2.  But hung after it 
got to "Enabling Swap ..".   Any more ideas?

I am now about to copy the boot sector using dd and using Win-XP's 
loader to load it to see if it helps.

Should I be using an even newer kernel?  Which one is known to work with 
RH-9 (I haven't kept up with building kernels and libc compatibilities 
in a long time, not since Slackware '97 days :-)?

Shash

Alan Cox wrote:
> On Sul, 2003-09-21 at 20:48, Shash Chatterjee wrote:
> 
>>When booting from floppy, it loads the kernel/ramdisk from floppy, then 
>>recognizes the HW and then hangs with the following message (at the 
>>bottom).  Hitting any key causes a single "keyboard: unknown keysequence 
>>0e .." and then I have to hard-reset to recover.
> 
> 
> Firstly try booting with the additional option "ide=nodma". That will
> hopefully get you installed but slowly and able to update to a newer
> kernel.
> 



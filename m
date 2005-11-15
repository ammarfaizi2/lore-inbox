Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932379AbVKOEha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbVKOEha (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 23:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbVKOEha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 23:37:30 -0500
Received: from c-67-177-35-222.hsd1.ut.comcast.net ([67.177.35.222]:25984 "EHLO
	vger.utah-nac.org") by vger.kernel.org with ESMTP id S932379AbVKOEh3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 23:37:29 -0500
Message-ID: <43795FE2.1020607@wolfmountaingroup.com>
Date: Mon, 14 Nov 2005 21:11:14 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] i386: always use 4k stacks
References: <58XuN-29u-17@gated-at.bofh.it> <58XuN-29u-19@gated-at.bofh.it> <58XuN-29u-21@gated-at.bofh.it> <58XuN-29u-23@gated-at.bofh.it> <58XuN-29u-25@gated-at.bofh.it> <58XuN-29u-15@gated-at.bofh.it> <58YAt-3Fs-5@gated-at.bofh.it> <58ZGo-5ba-13@gated-at.bofh.it> <5909m-5JB-5@gated-at.bofh.it> <43795F35.3050904@shaw.ca> <43795C55.9080305@wolfmountaingroup.com> <43796489.8090500@shaw.ca>
In-Reply-To: <43796489.8090500@shaw.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:

> Jeff V. Merkey wrote:
>
>> What?  There's more kernel apps than just ndis network drivers that 
>> get ported.  ndiswrapper is busted (which is used for a lot of laptops)
>> without 4K stacks.
>
>
> Which is why ndiswrapper needs to get fixed to work with 4K stacks. 
> ndiswrapper is the thing that's doing the wierd stuff, it needs to 
> adapt to the kernel, not the other way around. The reasons to use 4K 
> stacks are strong enough that they are not made up for by the fact 
> that ndiswrapper currently would like to have more stack space.

The NDIS drivers require the 8K stack, not ndiswrapper.

>
> Windows apparently has 12K of kernel stack for drivers.. in that case 
> even 8K of stack in Linux would not necessarily be enough. If 
> ndiswrapper wants to run Windows code in the kernel with any amount of 
> reliability it should be providing its own stack which is the size 
> that the code expects.
>
>> My laptop is a Compaq and there isn't a Linux driver for the 
>> wireless.  I also discovered Fedora Core 4 won't install
>> on a Compaq Presario with SATA (stacks crashes).
>
>
> How do you know this is related to the stack? Did you report this as a 
> bug?


Because I use MDB, a kernel debugger I wrote that inserts beneath Linux 
via DRLX or inside of it, and I watched it crash in the Linux SCSI 
code.  There's code in Linux proper that also walks off the end of the 
stack.  No I did not report it.  But now I have.

Jeff


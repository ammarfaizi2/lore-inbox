Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbVKOEbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbVKOEbN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 23:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbVKOEbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 23:31:13 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:62648 "EHLO
	pd2mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932376AbVKOEbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 23:31:12 -0500
Date: Mon, 14 Nov 2005 22:31:05 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [2.6 patch] i386: always use 4k stacks
In-reply-to: <43795C55.9080305@wolfmountaingroup.com>
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <43796489.8090500@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <58XuN-29u-17@gated-at.bofh.it> <58XuN-29u-19@gated-at.bofh.it>
 <58XuN-29u-21@gated-at.bofh.it> <58XuN-29u-23@gated-at.bofh.it>
 <58XuN-29u-25@gated-at.bofh.it> <58XuN-29u-15@gated-at.bofh.it>
 <58YAt-3Fs-5@gated-at.bofh.it> <58ZGo-5ba-13@gated-at.bofh.it>
 <5909m-5JB-5@gated-at.bofh.it> <43795F35.3050904@shaw.ca>
 <43795C55.9080305@wolfmountaingroup.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff V. Merkey wrote:
> What?  There's more kernel apps than just ndis network drivers that get 
> ported.  ndiswrapper is busted (which is used for a lot of laptops)
> without 4K stacks.

Which is why ndiswrapper needs to get fixed to work with 4K stacks. 
ndiswrapper is the thing that's doing the wierd stuff, it needs to adapt 
to the kernel, not the other way around. The reasons to use 4K stacks 
are strong enough that they are not made up for by the fact that 
ndiswrapper currently would like to have more stack space.

Windows apparently has 12K of kernel stack for drivers.. in that case 
even 8K of stack in Linux would not necessarily be enough. If 
ndiswrapper wants to run Windows code in the kernel with any amount of 
reliability it should be providing its own stack which is the size that 
the code expects.

> My laptop is a Compaq and there isn't a Linux driver 
> for the wireless.  I also discovered Fedora Core 4 won't install
> on a Compaq Presario with SATA (stacks crashes).

How do you know this is related to the stack? Did you report this as a bug?

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


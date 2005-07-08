Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262649AbVGHNNn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262649AbVGHNNn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 09:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262651AbVGHNMC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 09:12:02 -0400
Received: from bay21-f22.bay21.hotmail.com ([65.54.233.111]:52008 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262649AbVGHNLG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 09:11:06 -0400
Message-ID: <BAY21-F22FF37C190E0E78107300DA0DB0@phx.gbl>
X-Originating-IP: [4.21.76.141]
X-Originating-Email: [tbcrowley@hotmail.com]
From: "Thomas Crowley" <tbcrowley@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: hidden bus addresses above 4 Gigs
Date: Fri, 08 Jul 2005 09:11:05 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 08 Jul 2005 13:11:06.0049 (UTC) FILETIME=[7FC3CB10:01C583BE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running 2.6.12.2 with the memmap patch on a intel 64 bit machine with 
16 Gigs of RAM.  I am using the memmap command to limit the OS to 4 Gigs of 
RAM and reserve the upper 12 Gigs of RAM.
"memmap=4G memmap=12G$4G"  I have written a driver that mmaps the memory 
into user space where I can then us it in my application.  If I access the 
7th-8th Gig of Physical RAM the machine locks up.  It acts just like there 
is a device with that bus address on the machine.  I have found a couple of 
Physical RAM address ranges that seam to cause trouble.  My /proc/iomem has 
100000000-42fffffff marked as "System Ram" (even though I reserved the area) 
and lspci -vv does not show any devices above the 4Gig mark.  There looks to 
be an unreported by linux device using that address space.  Is this possible 
and if so any ideas how I can figure out what device might be there?

Thanks,
Tom



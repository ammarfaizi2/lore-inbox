Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946006AbWBOQWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946006AbWBOQWA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 11:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946007AbWBOQWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 11:22:00 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:5540 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1946006AbWBOQWA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 11:22:00 -0500
Message-ID: <43F354E9.2020900@cfl.rr.com>
Date: Wed, 15 Feb 2006 11:20:57 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Seewer Philippe <philippe.seewer@bfh.ch>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: disk geometry via sysfs
References: <43EC8FBA.1080307@bfh.ch> <43F0B484.3060603@cfl.rr.com>  <43F0D7AD.8050909@bfh.ch> <43F0DF32.8060709@cfl.rr.com>  <43F206E7.70601@bfh.ch> <43F21F21.1010509@cfl.rr.com>  <43F2E8BA.90001@bfh.ch>  <58cb370e0602150051w2f276banb7662394bef2c369@mail.gmail.com> <1140019615.14831.22.camel@localhost.localdomain>
In-Reply-To: <1140019615.14831.22.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Feb 2006 16:23:33.0078 (UTC) FILETIME=[2A091760:01C6324C]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14269.000
X-TM-AS-Result: No--6.400000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> We have at least three
> 
> Disk reported C/H/S
> BIOS reported C/H/S (hda/hdb only)
> Actual C/H/S (if it exists)
> Partition table C/H/S
> 
> A partitioning tool needs to know
> 	Disk reported C/H/S
> 	Partition table C/H/S
> 	Preferably BIOS reported C/H/S if there is one
> 

Why do you say the partitioning tool needs to know the disk reported 
C/H/S?  The value stored in the MBR must match the bios reported values, 
not the disk reported ones, so why does the partitioner care about what 
the disk reports?

> The partition table C/H/S is on disk so trivial
> The disk reported ones are in the identify block so could be pulled via
> 	/proc and sysfs
> The BIOS one is PC specific low memory poking around
> 
> I agree entirely that HD_GETGEO itself shouldn't matter.
> 


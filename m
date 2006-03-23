Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932290AbWCWPre@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbWCWPre (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 10:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932446AbWCWPre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 10:47:34 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:59657 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S932290AbWCWPrd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 10:47:33 -0500
Message-ID: <4422C316.5070305@cfl.rr.com>
Date: Thu, 23 Mar 2006 10:47:34 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Yogesh Pahilwan <pahilwan.yogesh@spsoftindia.com>
CC: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: raw I/O support for Fedora Core 4
References: <WM57DB3DF98115400697C908A54A80DEE9@spsoftindia.com>
In-Reply-To: <WM57DB3DF98115400697C908A54A80DEE9@spsoftindia.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Mar 2006 15:47:34.0516 (UTC) FILETIME=[1A4DAB40:01C64E91]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14341.000
X-TM-AS-Result: No--12.400000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The raw device driver is obsolete because it has been superseded by the 
O_DIRECT open flag.  If you want to have dd perform unbuffered IO then 
pass the iflag=direct option for input, or oflag=direct option for 
output, and it will use O_DIRECT to bypass the buffer cache.

This of course assumes that you mean "bypass the buffer cache" when you 
say "raw io".

Yogesh Pahilwan wrote:
> Hi All,
> 
> I want to do raw I/O on MD RAID and LVM for fedora core 4(kernel 2.6.15.6).
> 
> After doing googling I came to know that "raw" command does the raw
> operation by linking 
> MD device and LVM volume to the raw device as 
> 
> # raw /dev/raw/raw1 /dev/md0.
> 
> But when I search on this I came to know that there is no raw (/dev/rawctl)
> device support available with 2.6 kernel.
> I have also tried recompile the kernel sources with raw device support it is
> not getting compiled as it is obsolete in 2.6. 
> If I want to include raw device support in my kernel what should I will have
> to do, so that I 
> Will be able to do raw I/O on MD device and LVM volumes.
> 
> Thanks and Regards,
> Yogesh
> 


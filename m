Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261455AbVATWnX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbVATWnX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 17:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbVATWnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 17:43:22 -0500
Received: from [63.81.117.10] ([63.81.117.10]:13762 "EHLO mail00hq.adic.com")
	by vger.kernel.org with ESMTP id S261455AbVATWmj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 17:42:39 -0500
Message-ID: <41F033DD.6090406@xfs.org>
Date: Thu, 20 Jan 2005 16:42:37 -0600
From: Steve Lord <lord@xfs.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041020)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Trever L. Adams" <tadams-lists@myrealbox.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: LVM2
References: <1106250687.3413.6.camel@localhost.localdomain>	 <200501202240.02951.Norbert@edusupport.nl> <1106259457.3413.19.camel@localhost.localdomain>
In-Reply-To: <1106259457.3413.19.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Jan 2005 22:42:39.0008 (UTC) FILETIME=[58265200:01C4FF41]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trever L. Adams wrote:
> It is for a group. For the most part it is data access/retention. Writes
> and such would be more similar to a desktop. I would use SATA if they
> were (nearly) equally priced and there were awesome 1394 to SATA bridge
> chips that worked well with Linux. So, right now, I am looking at ATA to
> 1394.
> 
> So, to get 2TB of RAID5 you have 6 500 GB disks right? So, will this
> work within on LV? Or is it 2TB of diskspace total? So, are volume
> groups pretty fault tolerant if you have a bunch of RAID5 LVs below
> them? This is my one worry about this.
> 
> Second, you mentioned file systems. We were talking about ext3. I have
> never used any others in Linux (barring ext2, minixfs, and fat). I had
> heard XFS from IBM was pretty good. I would rather not use reiserfs.
> 
> Any recommendations.
> 
> Trever
> 

They all forgot to mention one more limitation, the maximum filesystem
size supported by the address_space structure in linux. If you are running
on ia32, then you get stuck with 2^32 filesystem blocks, or 16 Tbytes in
one filesystem because of the way an address space structure is used to
cache the metadata. If you use an Athlon 64 that limitation goes away.

Steve

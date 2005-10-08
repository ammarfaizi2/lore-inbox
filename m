Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbVJHTZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbVJHTZI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 15:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbVJHTZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 15:25:08 -0400
Received: from scipost.dolphinics.no ([193.71.152.3]:17874 "EHLO
	scipost.dolphinics.no") by vger.kernel.org with ESMTP
	id S1751101AbVJHTZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 15:25:06 -0400
Message-ID: <43481D0F.9020407@dolphinics.no>
Date: Sat, 08 Oct 2005 21:25:03 +0200
From: Simen Thoresen <simentt@dolphinics.no>
Organization: Dolphin ICS
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: devesh sharma <devesh28@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Issues in Booting kernel 2.6.13
References: <309a667c0510052216n784e229ei69b3a3a2a9e93f4b@mail.gmail.com> <20051006190806.388289ff.rdunlap@xenotime.net>
In-Reply-To: <20051006190806.388289ff.rdunlap@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

Randy.Dunlap wrote:
> On Thu, 6 Oct 2005 10:46:37 +0530 devesh sharma wrote:
> 
> 
>>Hi all,
>>I have compiled 2.6.13 kernel on a opteron machine with 1 GB physical
>>memory, Whole compilation gose well but at the last step
>>make install I am getting a warning
>>WARNING: No module mptbase found for kernel 2.6.13, continuing anyway
>>WARNING: No module mptscsih found for kernel 2.6.13, continuing anyway
> 
> 
> If you need mpt drivers, there were some changes in the
> FUSION MPT driver options that may be causing them not to be
> built for you as you were expecting.

I ran into this (2.6.13.3) on Friday as well, but I have not yet examined it 
in detail.

Do you have any pointers to the relevant postings or information?

I've used the 'mkinitrd' tool to generate a 'proper' initrd, and I see both 
mptbase and mptscsih loading, but mptscsih never picks up any actual 
controllers or disks. Thus the same problem on my system.

To me, this signifies that RHs mkinitrd is broken for this kernel, but I 
don't know the details of why yet.

Yours,
-S


>>now when I boot my kernel, panic is received
>>Booting the kernel.
>>Red Hat nash version 4.1.18 starting
>>mkrootdev: lable / not found
>>mount: error 2 mounting ext3
>>mount: error 2 mounting none
>>switchroot: mount failed : 22
>>umount : /initrd/dev failed : 22
>>kernel panic - not syncing : Attempted to kill init
>>
>>What could be the problem?
>>I have RHEL 4 base release already installed on which I have compiled
>>this image.
> 
> 
> 
> ---
> ~Randy
> You can't do anything without having to do something else first.
> -- Belefant's Law
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Simen Thoresen, Wulfkit Support, Dolphin ICS
http://www.tysland.com/~simentt/cluster

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261839AbULGPyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261839AbULGPyT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 10:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbULGPyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 10:54:19 -0500
Received: from fire.osdl.org ([65.172.181.4]:40098 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261839AbULGPyQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 10:54:16 -0500
Message-ID: <41B5C96A.5060909@osdl.org>
Date: Tue, 07 Dec 2004 07:16:58 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Andy <genanr@emsphone.com>, linux-kernel@vger.kernel.org
Subject: Re: Rereading disk geometry without reboot
References: <20041206202356.GA5866@thumper2> <Pine.LNX.4.53.0412071240300.18630@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.53.0412071240300.18630@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>>I am using linux kernel 2.6.9 on a san.  I have file systems on
> 
> 
> (What's a SAN?)
> 
> 
>>non-partitioned disks.  I can resize the disk on the SAN, reboot and grow
>>the XFS file system those disks.  What I would like to avoid rebooting or
>>even unmounting the filesystem if possible.
>>
>>Is there any way to get the kernel to re-read the disk geometry and change
>>the information it holds without rebooting or reloading the module (which is
>>as bad as a reboot in my case)?
> 
> 
> The `fdisk` tool will spit out an ioctl() to make the kernel reread the
> partition table (on normal computers, don't know about or what SAN). No need to
> reboot there at least.

There's 'blockdev --rereadpt' also, but neither of these work
on a mounted filesystem afaik.

-- 
~Randy

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268293AbUIAE31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268293AbUIAE31 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 00:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268163AbUIAE31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 00:29:27 -0400
Received: from [203.200.212.145] ([203.200.212.145]:31957 "EHLO
	atcmail.atc.tcs.co.in") by vger.kernel.org with ESMTP
	id S268293AbUIAE3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 00:29:10 -0400
Message-ID: <41355005.6030204@atc.tcs.co.in>
Date: Wed, 01 Sep 2004 09:58:53 +0530
From: Prasad <prasad@atc.tcs.co.in>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Wise, Jeremey" <jeremey.wise@agilysys.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel or Grub bug.
References: <1094008341.4704.32.camel@wizej.agilysys.com>
In-Reply-To: <1094008341.4704.32.camel@wizej.agilysys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>"Kernel panic: VFS: Unable to mount root fs on unknown-block(0,0)" 
>
>  
>

This indicates that the kernel is not able to find the root partition.
and that the kernel has already booted - most likely not a problem with 
GRUB.

>title Linux
>    kernel (hd0,0)/vmlinuz root=/dev/hda3 showopts
>    initrd (hd0,0)/initrd
>
>title 2.6.8.1-Palm
>    kernel (hd0,0)/vmlinuz-2.6.8.1-Palm showopts
>    initrd (hd0,0)/initrd-2.6.8.1-Palm
>
>  
>

Your partition table suggests that there are two different partitions 
for '/boot'
and '/'.  The GRUB loads the kernel from '/boot' which is (hd0,0) but the
kernel is unable to find the '/' partition.   You may pass it using the 
parameter
root=/dev/hda3.

That should work.

Prasad


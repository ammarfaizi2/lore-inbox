Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261887AbVCSW1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbVCSW1J (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 17:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261894AbVCSW1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 17:27:09 -0500
Received: from alpha.polcom.net ([217.79.151.115]:4030 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S261887AbVCSW1E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 17:27:04 -0500
Date: Sat, 19 Mar 2005 23:28:41 +0100 (CET)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Werner Almesberger <wa@almesberger.net>
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>, torvalds@osdl.org, akpm@osdl.org,
       bon@elektron.ikp.physik.tu-darmstadt.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] partitions/msdos.c
In-Reply-To: <20050319185458.B17469@almesberger.net>
Message-ID: <Pine.LNX.4.62.0503192319350.19144@alpha.polcom.net>
References: <20050226213459.GA21137@apps.cwi.nl> <20050319185458.B17469@almesberger.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Mar 2005, Werner Almesberger wrote:
> Andries Brouwer wrote:
>> The two variants are: (i) partition tells the kernel
>> to do the partition table reading, and (ii) partition uses partx
>> to read the partition table and tells the kernel one-by-one
>> about the partitions found this way.
>
> I guess, once you've reached the point where the kernel is
> unable to find partitions without user-space help, you may
> as well do everything in user space.

I agree. This is userspace job. This can be done very easily using 
device-mapper. I think EVMS does something similar.

I even asked on LKML some time ago about option for disabling kernel 
partition driver (maybe for some devices) from kernel command line to 
allow other tools do the job (because now I have unusable /dev/sda1 and 
usable /dev/evms/sda1 and this leads to stupid mistakes). But there were 
no replies.


Grzegorz Kulewski

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263475AbREYBHW>; Thu, 24 May 2001 21:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263477AbREYBHN>; Thu, 24 May 2001 21:07:13 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:34568 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263475AbREYBHD>; Thu, 24 May 2001 21:07:03 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Ramdisk Initialization Problem
Date: 24 May 2001 18:06:48 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9ekb78$u2a$1@cesium.transmeta.com>
In-Reply-To: <l03130306b7332a134958@[209.239.217.188]>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <l03130306b7332a134958@[209.239.217.188]>
By author:    "Jaswinder Singh" <jaswinder.singh@3disystems.com>
In newsgroup: linux.dev.kernel
>
>     I am using kernel 2.4.1 with compressed Ramdisk on  Hitachi SH board ,
> with no battery.   When i run kernel first time , it works fine , it
> uncompress Ramdisk and i get my shell prompt .    But when i restart it
> second time (with out  removing power cable ) kernel dies when
> uncompressing Ramdisk.   But , if i remove my power supply for more than 5
> minutes , and then i start again , it works again.   It seems that in 2.4.1
> and/or later versions has  Ramdisk Initailization or uninitialised memory
> problem. But i faced no problem  with 2.2.12 kernel.   Thank you,  
> 
> Best Regards,   Jaswinder (and his wonder machine).
> 

First of all, try the latest kernel if you are going to report a bug.

For the kernel people, this is classic evidence of relying on
uninitialized memory; the "few minutes" is roughly how long it takes
modern SDRAM to *reliably* discharge.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt

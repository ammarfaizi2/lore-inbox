Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262779AbUKXRRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262779AbUKXRRN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 12:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262739AbUKXRPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 12:15:16 -0500
Received: from lucidpixels.com ([66.45.37.187]:56211 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S262722AbUKXRFa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 12:05:30 -0500
Date: Wed, 24 Nov 2004 12:05:27 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: Adrian Bunk <bunk@stusta.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.9 SCSI driver compile error w/gcc-3.4.2.
In-Reply-To: <20041124170327.GB19873@stusta.de>
Message-ID: <Pine.LNX.4.61.0411241205240.19627@p500>
References: <Pine.LNX.4.61.0411240812220.19627@p500> <20041124170327.GB19873@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ahh, ok thanks!

On Wed, 24 Nov 2004, Adrian Bunk wrote:

> On Wed, Nov 24, 2004 at 08:13:06AM -0500, Justin Piszcz wrote:
>> Under slackware-current, gcc-3.4.2.
>>
>> root@p500b:/usr/src/linux# make modules
>>   CHK     include/linux/version.h
>> make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
>>   CC [M]  drivers/scsi/cpqfcTScontrol.o
>> drivers/scsi/cpqfcTScontrol.c:609:2: #error This is too much stack
>> drivers/scsi/cpqfcTScontrol.c:721:2: #error This is too much stack
>> make[2]: *** [drivers/scsi/cpqfcTScontrol.o] Error 1
>> ...
>
> This compile error (as well as the other two compile errors you
> reported) comes from the fact, that you disabled the option
>
>  Code maturity level options
>    Prompt for development and/or incomplete code/drivers
>      Select only drivers expected to compile cleanly
>
>
> It's known that some drivers do not compile and marked in the Kconfig
> files. But if you choose to try to compile them anyway, they don't
> compile.
>
>
> cu
> Adrian
>
> -- 
>
>       "Is there not promise of rain?" Ling Tan asked suddenly out
>        of the darkness. There had been need of rain for many days.
>       "Only a promise," Lao Er said.
>                                       Pearl S. Buck - Dragon Seed
>

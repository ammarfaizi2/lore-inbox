Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262668AbUKXRZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262668AbUKXRZq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 12:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262789AbUKXRZC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 12:25:02 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:11271 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262668AbUKXRDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 12:03:32 -0500
Date: Wed, 24 Nov 2004 18:03:27 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.9 SCSI driver compile error w/gcc-3.4.2.
Message-ID: <20041124170327.GB19873@stusta.de>
References: <Pine.LNX.4.61.0411240812220.19627@p500>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0411240812220.19627@p500>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2004 at 08:13:06AM -0500, Justin Piszcz wrote:
> Under slackware-current, gcc-3.4.2.
> 
> root@p500b:/usr/src/linux# make modules
>   CHK     include/linux/version.h
> make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
>   CC [M]  drivers/scsi/cpqfcTScontrol.o
> drivers/scsi/cpqfcTScontrol.c:609:2: #error This is too much stack
> drivers/scsi/cpqfcTScontrol.c:721:2: #error This is too much stack
> make[2]: *** [drivers/scsi/cpqfcTScontrol.o] Error 1
>...

This compile error (as well as the other two compile errors you 
reported) comes from the fact, that you disabled the option

  Code maturity level options
    Prompt for development and/or incomplete code/drivers
      Select only drivers expected to compile cleanly


It's known that some drivers do not compile and marked in the Kconfig 
files. But if you choose to try to compile them anyway, they don't 
compile.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261933AbVDFASP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261933AbVDFASP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 20:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbVDFASP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 20:18:15 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:63240 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261933AbVDFASI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 20:18:08 -0400
Date: Wed, 6 Apr 2005 02:18:07 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Ben Castricum <benc@bencastricum.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2 compile error in drivers/usb/class/cdc-acm.c
Message-ID: <20050406001807.GB7226@stusta.de>
References: <Pine.LNX.4.58.0504051026330.30674@gateway.bencastricum.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504051026330.30674@gateway.bencastricum.nl>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2005 at 10:54:09AM +0200, Ben Castricum wrote:
> 
> 2.6.12-rc1 compiles and runs perfectly.
> 
> gcc version 2.95.3 20010315 (release)
> 
>   CC [M]  drivers/usb/class/cdc-acm.o
> In file included from drivers/usb/class/cdc-acm.c:63:
> include/linux/usb_cdc.h:117: field `bDetailData' has incomplete type
> make[3]: *** [drivers/usb/class/cdc-acm.o] Error 1
> make[2]: *** [drivers/usb/class] Error 2
> make[1]: *** [drivers/usb] Error 2
> make: *** [drivers] Error 2


That's a known problem already fixed in -mm.


> I also get several warnings while compiling the kernel:
> 
> 
>   CC      fs/quota_v2.o
> fs/quota_v2.c: In function `v2_write_dquot':
> fs/quota_v2.c:399: warning: unknown conversion type character `z' in
> format
> fs/quota_v2.c:399: warning: too many arguments for format
> 
>   CC [M]  drivers/acpi/processor_idle.o
> drivers/acpi/processor_idle.c: In function
> `acpi_processor_power_seq_show':
> drivers/acpi/processor_idle.c:868: warning: unknown conversion type
> character `z' in format
> drivers/acpi/processor_idle.c:868: warning: too many arguments for format
> drivers/acpi/processor_idle.c:899: warning: unknown conversion type
> character `z' in format
> drivers/acpi/processor_idle.c:899: warning: too many arguments for format
> drivers/acpi/processor_idle.c:906: warning: unknown conversion type
> character `z' in format
> drivers/acpi/processor_idle.c:906: warning: too many arguments for format
>...


These are warnings that only occur with gcc 2.95 and that can safely be
ignored.


> Hope this helps,
> Ben


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750823AbWBQAF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbWBQAF1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 19:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030625AbWBQAF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 19:05:27 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:22287 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750823AbWBQAF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 19:05:26 -0500
Date: Fri, 17 Feb 2006 01:05:25 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Martin MOKREJ? <mmokrejs@ribosome.natur.cuni.cz>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.16-rc3-git5: drivers/acpi/osl.c:57:38: empty filename in #include
Message-ID: <20060217000525.GD4422@stusta.de>
References: <43F3B553.2010506@ribosome.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F3B553.2010506@ribosome.natur.cuni.cz>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2006 at 12:12:19AM +0100, Martin MOKREJ? wrote:

> Hi,

Hi Martin,

>   I have the following problem when compiling linux kernel on Intel 
> Pentium4M machine:
> 
> drivers/acpi/osl.c:57:38: empty filename in #include
> drivers/acpi/osl.c: In function `acpi_os_table_override':
> drivers/acpi/osl.c:258: error: `AmlCode' undeclared (first use in 
> this function)
> drivers/acpi/osl.c:258: error: (Each undeclared identifier is 
> reported only once
> drivers/acpi/osl.c:258: error: for each function it appears in.)
> make[2]: *** [drivers/acpi/osl.o] Error 1
> 
>   It turned out I have enabled the custom DSDT option but the field 
> for the custom file have left empty. That's the cause for the error.
> Something should probably take care of this case. I use "menuconfig"
> to manipulate the .config file.

this is a class of errors Kconfig can't handle.

And if it was handled, the next problems were to check first whether the 
file exists, and next whether it's actually a valid DSDT table file...

Kconfig helps you to avoid many errors, but there are classes of errors 
it simply can't prevent.

> M.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


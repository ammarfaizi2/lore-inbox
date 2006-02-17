Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932356AbWBQJM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbWBQJM5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 04:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932594AbWBQJM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 04:12:57 -0500
Received: from r3az252.chello.upc.cz ([213.220.243.252]:22917 "EHLO
	vrapenec.doma") by vger.kernel.org with ESMTP id S932356AbWBQJM4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 04:12:56 -0500
Message-ID: <43F59384.5090503@ribosome.natur.cuni.cz>
Date: Fri, 17 Feb 2006 10:12:36 +0100
From: =?windows-1252?Q?Martin_MOKREJ=8A?= 
	<mmokrejs@ribosome.natur.cuni.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051002
X-Accept-Language: cs
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.16-rc3-git5: drivers/acpi/osl.c:57:38: empty filename in
 #include
References: <43F3B553.2010506@ribosome.natur.cuni.cz> <20060217000525.GD4422@stusta.de>
In-Reply-To: <20060217000525.GD4422@stusta.de>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,
   thanks for answer, pitty that Kconfig cannot prevent empty values.
But I don't mind that much.
M.

Adrian Bunk wrote:
> On Thu, Feb 16, 2006 at 12:12:19AM +0100, Martin MOKREJ? wrote:
>>  I have the following problem when compiling linux kernel on Intel 
>>Pentium4M machine:
>>
>>drivers/acpi/osl.c:57:38: empty filename in #include
>>drivers/acpi/osl.c: In function `acpi_os_table_override':
>>drivers/acpi/osl.c:258: error: `AmlCode' undeclared (first use in 
>>this function)
>>drivers/acpi/osl.c:258: error: (Each undeclared identifier is 
>>reported only once
>>drivers/acpi/osl.c:258: error: for each function it appears in.)
>>make[2]: *** [drivers/acpi/osl.o] Error 1
>>
>>  It turned out I have enabled the custom DSDT option but the field 
>>for the custom file have left empty. That's the cause for the error.
>>Something should probably take care of this case. I use "menuconfig"
>>to manipulate the .config file.
> 
> 
> this is a class of errors Kconfig can't handle.
> 
> And if it was handled, the next problems were to check first whether the 
> file exists, and next whether it's actually a valid DSDT table file...
> 
> Kconfig helps you to avoid many errors, but there are classes of errors 
> it simply can't prevent.

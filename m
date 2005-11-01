Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbVKASFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbVKASFX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 13:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbVKASFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 13:05:23 -0500
Received: from [67.137.28.189] ([67.137.28.189]:51586 "EHLO vger.utah-nac.org")
	by vger.kernel.org with ESMTP id S1751079AbVKASFW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 13:05:22 -0500
Message-ID: <43679B22.8070905@utah-nac.org>
Date: Tue, 01 Nov 2005 09:43:14 -0700
From: "Jeff V. Merkey" <jmerkey@utah-nac.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: alex@alexfisher.me.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: Would I be violating the GPL?
References: <5449aac20511010949x5d96c7e0meee4d76a67a06c01@mail.gmail.com>
In-Reply-To: <5449aac20511010949x5d96c7e0meee4d76a67a06c01@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alan Cox and others have publicly stated that drivers, if complied stand 
alone with NO DEPENDENCIES ON KERNEL HEADERS (i.e. they do not 
incorporate in any way any kernel headers or source code tagged GPL) do 
not violate the GPL when provided with Linux. DSFS, NVidia, and several 
folks build kernel modules which are stand alone and are not objected to 
by the majority of folks.

If these drivers include kernel headers as part of the build, then the 
drivers violate the GPL. Period. Check the code. If the vendor is 
including **ANY** GPL kernel headers, then they are required to open 
source the drivers. There are some zealots and GPL bigots that disagree 
with this, but Linux folks seem to be reasonable on this point.

Jeff

Alexander Fisher wrote:

>Hello.
>
>A supplier of a PCI mezzanine digital IO card has provided a linux 2.4
>driver as source code.  They have provided this code source with a
>license stating I won't redistribute it in anyway.
>My concern is that if I build this code into a module, I won't be able
>to distribute it to customers without violating either the GPL (by not
>distributing the source code), or the proprietary source code license
>as currently imposed by the supplier.
>>From what I have read, this concern is only valid if the binary module
>is considered to be a 'derived work' of the kernel.  The module source
>directly includes the following kernel headers :
>
>#include <linux/kernel.h>
>#include <linux/types.h>
>#include <linux/fs.h>
>#include <linux/errno.h>
>#include <linux/wrapper.h>
>#include <linux/module.h>
>#include <linux/iobuf.h>
>#include <linux/highmem.h>
>#include <asm/uaccess.h>
>#include <linux/mm.h>
>#include <asm/unistd.h>
>
>Does this make the compiled module a derived work?  Are the 'static
>inlines' from the headers substantial enough?
>
>I really want to have a clear understanding of the issues before
>contacting the supplier.  Any advice would be very much appreciated.
>Kind regards,
>Alex
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>


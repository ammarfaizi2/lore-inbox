Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279035AbRJ2GYb>; Mon, 29 Oct 2001 01:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279036AbRJ2GYW>; Mon, 29 Oct 2001 01:24:22 -0500
Received: from zok.SGI.COM ([204.94.215.101]:35283 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S279035AbRJ2GYF>;
	Mon, 29 Oct 2001 01:24:05 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [patch] 2.4.13 remove unused warnings on module tables 
In-Reply-To: Your message of "Mon, 29 Oct 2001 01:17:15 CDT."
             <3BDCF46B.53D04CE3@mandrakesoft.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 29 Oct 2001 17:24:32 +1100
Message-ID: <4680.1004336672@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Oct 2001 01:17:15 -0500, 
Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
>Keith Owens wrote:
>> @@ -11,6 +11,7 @@
>>  #include <linux/spinlock.h>
>>  #include <linux/list.h>
>> 
>> +#ifndef CONFIG_KBUILD_2_5
>>  #ifdef __GENKSYMS__
>>  #  define _set_ver(sym) sym
>>  #  undef  MODVERSIONS
>> @@ -21,6 +22,7 @@
>>  #   include <linux/modversions.h>
>>  # endif
>>  #endif /* __GENKSYMS__ */
>> +#endif /* CONFIG_KBUILD_2_5 */
>> 
>>  #include <asm/atomic.h>
>> 
>> @@ -257,8 +259,6 @@ static const unsigned long __module_##gt
>
>I don't think we need this part of the patch.

It is a small change to module.h that is required for kbuild 2.5 and
has no effect on 2.4.  Saves me having to send another patch later.


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129040AbQKOAF4>; Tue, 14 Nov 2000 19:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129045AbQKOAFq>; Tue, 14 Nov 2000 19:05:46 -0500
Received: from jump-isi.interactivesi.com ([207.8.4.2]:35068 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S129040AbQKOAFl>; Tue, 14 Nov 2000 19:05:41 -0500
Date: Tue, 14 Nov 2000 17:35:37 -0600
From: Timur Tabi <ttabi@interactivesi.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: Linux Kernel Mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <11946.974244682@ocs3.ocs-net>
In-Reply-To: Your message of "Tue, 14 Nov 2000 15:58:38 MDT."<20001114222843Z131509-521+212@vger.kernel.org>
Subject: Re: "couldn't find the kernel version the module was compiled for" - help!
X-Mailer: The Polarbar Mailer (pbm 1.17b)
Message-Id: <20001115000545Z129040-521+229@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

** Reply to message from Keith Owens <kaos@ocs.com.au> on Wed, 15 Nov 2000
10:31:22 +1100


> "#define __NO_VERSION__" must be in all but one of the sources that
> also include module.h.  It suppresses the module_version string in
> module.h so it only make sense if the code includes module.h.  But
> exactly one of the objects in a module must have a module_version
> string.

Ok, I made this change:

#ifndef __ENTRY_C__
#define __NO_VERSION__
#endif
#include <linux/version.h>

and in entry.c:

#define __ENTRY_C__
#include "include.h"

Unfortunately, it still doesn't work.

I tried "insmod -f tdmcddk.sys", but that didn't help either.



-- 
Timur Tabi - ttabi@interactivesi.com
Interactive Silicon - http://www.interactivesi.com

When replying to a mailing-list message, please direct the reply to the mailing list only.  Don't send another copy to me.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

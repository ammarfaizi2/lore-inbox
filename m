Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131509AbQKNW3B>; Tue, 14 Nov 2000 17:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131532AbQKNW2v>; Tue, 14 Nov 2000 17:28:51 -0500
Received: from jump-isi.interactivesi.com ([207.8.4.2]:61175 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S131509AbQKNW2l>; Tue, 14 Nov 2000 17:28:41 -0500
Date: Tue, 14 Nov 2000 15:58:38 -0600
From: Timur Tabi <ttabi@interactivesi.com>
To: Linux Kernel Mailing list <linux-kernel@vger.kernel.org>
Subject: "couldn't find the kernel version the module was compiled for" - help!
X-Mailer: The Polarbar Mailer (pbm 1.17b)
Message-Id: <20001114222843Z131509-521+212@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm at a loss to explain why I can't get this working.

I have a driver written for 2.4 that I'm porting back to 2.2.  Every time I
think I got it working, something surprises me.  

First, I had a bunch of link errors on the redifintion of
__module_kernel_version.  To fix that, someone told me to do this:

#define __NO_VERSION__
#include <linux/version.h>

And sure enough, no more errors.

However, now I get this error from insmod when I try to load my driver:

[root@two ttabi]# insmod tdmcddk.sys 
tdmcddk.sys: couldn't find the kernel version the module was compiled for

I've tried all sorts of things - recompiling the kernels, changing the order of
#include files (version.h, module.h, modversions.h, whatever).  Either the
driver won't link, or it won't load.

I had our other Linux programmer (who works only with 2.2) look at the problem,
but he couldn't figure it out, either.

I'd be very appreciative of any assistance.



-- 
Timur Tabi - ttabi@interactivesi.com
Interactive Silicon - http://www.interactivesi.com

When replying to a mailing-list message, please direct the reply to the mailing list only.  Don't send another copy to me.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131580AbQKNXQE>; Tue, 14 Nov 2000 18:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131594AbQKNXPy>; Tue, 14 Nov 2000 18:15:54 -0500
Received: from pm3-6-39.apex.net ([209.250.41.102]:10502 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S131430AbQKNXPv>; Tue, 14 Nov 2000 18:15:51 -0500
Date: Tue, 14 Nov 2000 16:31:54 -0600
From: Steven Walter <srwalter@hapablap.dyn.dhs.org>
To: Timur Tabi <ttabi@interactivesi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: "couldn't find the kernel version the module was compiled for" - help!
Message-ID: <20001114163154.A3328@hapablap.dyn.dhs.org>
In-Reply-To: <20001114222843Z131509-521+212@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <20001114222843Z131509-521+212@vger.kernel.org>; from ttabi@interactivesi.com on Tue, Nov 14, 2000 at 03:58:38PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If my understanding is correct, you need to include version.h without
"#define __NO_VERSION__" in one and only one of your module's .c files.
More than one, and you get redefinition errors; less than one, and its
undefined.

On Tue, Nov 14, 2000 at 03:58:38PM -0600, Timur Tabi wrote:
> I'm at a loss to explain why I can't get this working.
> 
> I have a driver written for 2.4 that I'm porting back to 2.2.  Every time I
> think I got it working, something surprises me.  
> 
> First, I had a bunch of link errors on the redifintion of
> __module_kernel_version.  To fix that, someone told me to do this:
> 
> #define __NO_VERSION__
> #include <linux/version.h>
> 
> And sure enough, no more errors.
> 
> However, now I get this error from insmod when I try to load my driver:
> 
> [root@two ttabi]# insmod tdmcddk.sys 
> tdmcddk.sys: couldn't find the kernel version the module was compiled for
> 
> I've tried all sorts of things - recompiling the kernels, changing the order of
> #include files (version.h, module.h, modversions.h, whatever).  Either the
> driver won't link, or it won't load.
> 
> I had our other Linux programmer (who works only with 2.2) look at the problem,
> but he couldn't figure it out, either.
> 
> I'd be very appreciative of any assistance.
> 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

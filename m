Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S157023AbPLXBiw>; Thu, 23 Dec 1999 20:38:52 -0500
Received: by vger.rutgers.edu id <S156968AbPLXBi3>; Thu, 23 Dec 1999 20:38:29 -0500
Received: from vpws62.vpplus.com ([207.49.240.62]:22587 "EHLO quark.vpplus.com") by vger.rutgers.edu with ESMTP id <S157054AbPLXBiL>; Thu, 23 Dec 1999 20:38:11 -0500
Message-ID: <3862D177.F1EC9124@quark.vpplus.com>
Date: Thu, 23 Dec 1999 20:50:47 -0500
From: Brian Gerst <bgerst@quark.vpplus.com>
X-Mailer: Mozilla 4.61 [en] (X11; U; Linux 2.2.12-20 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux kernel mailing list <linux-kernel@vger.rutgers.edu>
Subject: Re: Linux Kernel Floating Point Emulation and CORDIC
References: <99122316092902.01246@cel2>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

Arthur Jerijian wrote:
> 
> For the mathematics and theoretical computer science enthusiasts here on this
> list:
> 
> I have taken a look at the source code of the Linux Kernel floating point
> emulation engine for i386 (as of 2.2.12, don't know if it changed in 2.3.x). I
> noticed that it uses Taylor/Maclaurin polynomials to approximate the sine,
> cosine, tangent, and inverse tangent functions. Wouldn't CORDIC be a better
> algorithm for computing trigonometric and exponential functions instead? CORDIC
> is a method for calculating mathematical functions using only addition,
> shifting, and looking up entries in a table. More details can be found at
> http://www.ezcomm.com/%7Ecyliax/Articles/RobNav/sidebar.html

I don't think it's worth the effort to rewrite and retest the FP
emulation code.  It is only needed on some 386 and 486 machines, as all
pentiums and later always have built in FPUs.  Nobody should be doing
any serious number crunching on those old processors.  Just my 2 cents
though.

-- 

						Brian Gerst

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/

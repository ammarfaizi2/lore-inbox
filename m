Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269049AbRHPXZj>; Thu, 16 Aug 2001 19:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269021AbRHPXZ3>; Thu, 16 Aug 2001 19:25:29 -0400
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:30657 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S269002AbRHPXZT>; Thu, 16 Aug 2001 19:25:19 -0400
Message-Id: <5.1.0.14.2.20010816234350.00add710@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 17 Aug 2001 00:22:43 +0100
To: "David S. Miller" <davem@redhat.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: 2.4.9 does not compile [PATCH]
Cc: tpepper@vato.org, f5ibh@db0bm.ampr.org, linux-kernel@vger.kernel.org
In-Reply-To: <20010816.153151.74749641.davem@redhat.com>
In-Reply-To: <20010816144109.A5094@cb.vato.org>
 <200108162111.XAA07177@db0bm.ampr.org>
 <20010816144109.A5094@cb.vato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 23:31 16/08/2001, David S. Miller wrote:
>    From: tpepper@vato.org
>    Date: Thu, 16 Aug 2001 14:41:09 -0700
>
>    Confirmed here.  Looks like a pretty obvious goof to me.  Does the 
> following
>    fix it for you?
>
>The args and semantics of min/max changed to take
>a type first argument, the problem with this ntfs file is that it
>fails to include linux/kernel.h

It has indeed. I do fail to see why that was necessary though...

IMHO, it would have been more elegant to use the typeof construct provided 
by gcc in the new macro instead of introducing a type parameter like this...

#define min(x,y) \
         ({ typeof(x) __x = (x); typeof(y) __y = (y); __x < __y ? __x: __y; })

Best regards,

         Anton


-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/


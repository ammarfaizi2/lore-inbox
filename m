Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269436AbRHQB4q>; Thu, 16 Aug 2001 21:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269413AbRHQB4h>; Thu, 16 Aug 2001 21:56:37 -0400
Received: from pizda.ninka.net ([216.101.162.242]:60288 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S269421AbRHQB4Y>;
	Thu, 16 Aug 2001 21:56:24 -0400
Date: Thu, 16 Aug 2001 18:53:19 -0700 (PDT)
Message-Id: <20010816.185319.88475216.davem@redhat.com>
To: akpm@zip.com.au
Cc: aia21@cam.ac.uk, jdike@karaya.com, alan@lxorguk.ukuu.org.uk,
        phillips@bonn-fries.net, tpepper@vato.org, f5ibh@db0bm.ampr.org,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.9 does not compile [PATCH]
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3B7C7846.FD9DEE68@zip.com.au>
In-Reply-To: <Your message of "Fri, 17 Aug 2001 00:35:02 +0100."
 <5.1.0.14.2.20010817002825.00b1e4e0@pop.cus.cam.ac.uk>
	<5.1.0.14.2.20010817015007.045689b0@pop.cus.cam.ac.uk>
	<3B7C7846.FD9DEE68@zip.com.au>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Morton <akpm@zip.com.au>
   Date: Thu, 16 Aug 2001 18:49:58 -0700

   int test(int __x, int __y)
   {
           return min(__x, __y);		/* sic */
   }

People are expected not to use underscore prefixed
variables in normal C code, this is why macros
in the kernel make liberal use of them for locals.

I mean, with your rule half of the macro defines in the kernel using
local variables are broken :-)

Later,
David S. Miller
davem@redhat.com

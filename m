Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293161AbSCaC2c>; Sat, 30 Mar 2002 21:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311317AbSCaC2W>; Sat, 30 Mar 2002 21:28:22 -0500
Received: from pizda.ninka.net ([216.101.162.242]:52169 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S293161AbSCaC2K>;
	Sat, 30 Mar 2002 21:28:10 -0500
Date: Sat, 30 Mar 2002 18:22:43 -0800 (PST)
Message-Id: <20020330.182243.88963096.davem@redhat.com>
To: viro@math.psu.edu
Cc: tim@birdsnest.maths.tcd.ie, linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.7
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.GSO.4.21.0203301838090.2590-100000@weyl.math.psu.edu>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alexander Viro <viro@math.psu.edu>
   Date: Sat, 30 Mar 2002 18:41:46 -0500 (EST)
   
   	Dave, you've mentioned doing the equivalent of
   __attribute__((weak,alias("foo")) by hand.  Could you give an example?
   

#define make_weak(foo,bar)	__asm__(".weak foo, bar")

Or however the assembler syntax works.  GLIBC has some header file it
at least used to use which had macros doing something similar.

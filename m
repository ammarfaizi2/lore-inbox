Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265333AbSLPGTI>; Mon, 16 Dec 2002 01:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265368AbSLPGTI>; Mon, 16 Dec 2002 01:19:08 -0500
Received: from [212.209.10.215] ([212.209.10.215]:44255 "EHLO miranda.axis.se")
	by vger.kernel.org with ESMTP id <S265333AbSLPGTH>;
	Mon, 16 Dec 2002 01:19:07 -0500
Message-ID: <3C6BEE8B5E1BAC42905A93F13004E8AB017DE52E@mailse01.axis.se>
From: Mikael Starvik <mikael.starvik@axis.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Compiling iproute2(w/HTB patch) for 2.5.51
Date: Mon, 16 Dec 2002 07:26:55 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have the exact same problem with sysklogd and I found 
that linux/module.h has a lot of new includes in 2.5 
that indirectly brings in a lot of .h files that 
shouldn't be included from userspace. 

Because of this you get both the compilers definition 
of FD_SET etc and the kernels version. I have not yet 
had the time to find out how to solve this but the 
solution is either to remove some includes or to add 
more #ifdef __KERNEL__. 

Question 1: Should it at all be possible to compile 
applications with 2.5.x headers? 

Question 2: Is there any chance that we can remove 
or #ifdef some includes in module.h (e.g. sched.h)? 

/Mikael

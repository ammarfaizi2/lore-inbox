Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266989AbRGTOf1>; Fri, 20 Jul 2001 10:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266977AbRGTOfI>; Fri, 20 Jul 2001 10:35:08 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:11275 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S266969AbRGTOe6>; Fri, 20 Jul 2001 10:34:58 -0400
Message-Id: <200107201434.f6KEYsU34527@aslan.scsiguy.com>
To: =?ISO-8859-1?Q?Janne_P=E4nk=E4l=E4?= <epankala@cc.hut.fi>
cc: linux-kernel@vger.kernel.org
Subject: Re: realiable crashing with AIC7xxxx driver and vanilla 2.4.6 kernel on KT133(A) 
In-Reply-To: Your message of "Fri, 20 Jul 2001 17:25:40 +0300."
             <Pine.OSF.4.10.10107201649210.22298-100000@kosh.hut.fi> 
Date: Fri, 20 Jul 2001 08:34:54 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

>** Summary ** 
>aic7xxx driver reliably crashes to(/in?) ahc_handle_seqint() function.

If you are using the stock driver in 2.4.6, you might try upgrading
to version 6.2.0 of the aic7xxx driver from here:

http://people.FreeBSD.org/~gibbs/linux

In the mean time, it would be interesting to know what code is at
0x2c9 in your compiled version of aic7xxx.c.  Just turn on the
EXTRA_FLAGS=-g bit in the aic7xxx Makefile, rebuild your kernel or
module, and do:

gdb aic7xxx.o
(gdb) l *(ahc_handle_seqint+0x2c9)

--
Justin

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135532AbRDZPgg>; Thu, 26 Apr 2001 11:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135624AbRDZPg0>; Thu, 26 Apr 2001 11:36:26 -0400
Received: from c4.h061013036.is.net.tw ([61.13.36.4]:29707 "EHLO
	exchsmtp.via.com.tw") by vger.kernel.org with ESMTP
	id <S135532AbRDZPgR>; Thu, 26 Apr 2001 11:36:17 -0400
Message-ID: <611C3E2A972ED41196EF0050DA92E0760265D56B@EXCHANGE2>
From: Yiping Chen <YipingChen@via.com.tw>
To: "'Vivek Dasmohapatra'" <vivek@etla.org>,
        Yiping Chen <YipingChen@via.com.tw>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: About rebuild 2.4.x kernel to support SMP.
Date: Thu, 26 Apr 2001 23:36:23 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="big5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So, I have two question now, 
1. how to determine whether your kernel support SMP?
    Somebody taugh me that you can type  "uname -r", but it seems not
correct.
2. I remember in 2.2.x, when I rebuild the kernel which support SMP, the
compile
    argument will include -D__SMP__ , but this time, when I rebuild kernel
2.4.2-2 , it didn't  appear.
    Why? 

Anyway, thanks for  Vivek's answer.
-----Original Message-----
From: Vivek Dasmohapatra [mailto:vivek@etla.org]
Sent: Thursday, April 26, 2001 11:20 PM
To: Yiping Chen
Cc: 'linux-kernel@vger.kernel.org'
Subject: Re: About rebuild 2.4.x kernel to support SMP.


On Thu, 26 Apr 2001, Yiping Chen wrote:

> My question is why the result of 'uname -r' is not "2.4.2-2smp" , but
> "2.4.2-2"

This is just the label as defined by the entries in the top-level
Makefile, eg:

VERSION = 2
PATCHLEVEL = 4
SUBLEVEL = 3
EXTRAVERSION = -ac5

> Whether I forgot to do something?

You can edit the extraversion value if you want to label your smp kernels
differently, but you don't have to.

You'll probably find you _have_ compiled an SMP kernel - see what
/proc/cpuinfo says, for example.

-- 
I am worthless. I struggle with the simple things. It seems so easy for 
everyone else. One armed blind people climb mountains and teenagers get
Ph.D's. I have trouble getting out of bed.
                                          -TMCM

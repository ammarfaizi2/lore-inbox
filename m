Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269646AbRHIKXB>; Thu, 9 Aug 2001 06:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269674AbRHIKWv>; Thu, 9 Aug 2001 06:22:51 -0400
Received: from web13606.mail.yahoo.com ([216.136.175.117]:3589 "HELO
	web13606.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S269646AbRHIKWc>; Thu, 9 Aug 2001 06:22:32 -0400
Message-ID: <20010809102243.95913.qmail@web13606.mail.yahoo.com>
Date: Thu, 9 Aug 2001 03:22:43 -0700 (PDT)
From: Ivan Kalvatchev <iive@yahoo.com>
Subject: DoS with tmpfs #dynamic
To: kernelbug <linux-kernel@vger.kernel.org>
In-Reply-To: <3B722DE4.96DA5711@idb.hist.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Helge Hafting <helgehaf@idb.hist.no> wrote:
> The problem with this is that tmpfs may be mounted
> before
> swap is initialized, so a little less than
> swap+ram will become "a little less than just RAM"
> anyway.
> 
> Or do you propose a dynamic limit, changing as swap
> is added/removed?  This has problems if some swap is
> removed, and suddenly tmpfs usage exceeds its quota.
> 
> Helge Hafting

Yes I mean it. If tmpfs is fixed in any way the
problem will raise. If it is dynamic we have 2
possible ways:
1. First we fill most of tmpfs. Then we start some
program that needs a tones of ram. The program exit
with error and System is stable.
2. We use a lot of memory. The tmpfs decreases it's
size dynamicly and then when trying to fill it up it
return No space on device.

About swap removing. What gonna happen if ram and swap
are full and someone tries to remove the swap. Data
loss? 
P.S.
  Pleace don't forget that ramfs is vulnarable in the
same way. It is rarely used but is DANGEROUS.
Ivan Kalvachev

__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/

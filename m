Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265446AbRFVPRl>; Fri, 22 Jun 2001 11:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265447AbRFVPRV>; Fri, 22 Jun 2001 11:17:21 -0400
Received: from [207.213.212.4] ([207.213.212.4]:45198 "EHLO geos.coastside.net")
	by vger.kernel.org with ESMTP id <S265446AbRFVPRM>;
	Fri, 22 Jun 2001 11:17:12 -0400
Mime-Version: 1.0
Message-Id: <p05100301b759107790aa@[207.213.214.37]>
In-Reply-To: <20010622134357.D641@arthur.ubicom.tudelft.nl>
In-Reply-To: <200106220230.WAA11443@smarty.smart.net>
 <20010622134357.D641@arthur.ubicom.tudelft.nl>
Date: Fri, 22 Jun 2001 08:16:19 -0700
To: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>,
        Rick Hohensee <humbubba@smarty.smart.net>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: mktime in include/linux
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 1:43 PM +0200 2001-06-22, Erik Mouw wrote:
>On Thu, Jun 21, 2001 at 10:30:40PM -0400, Rick Hohensee wrote:
>>  Why does Linux have a mktime routine fully coded in linux/time.h that
>>  conflicts directly with the ANSI C standard library routine of the same
>>  name? It breaks a couple things against libc5, including gcc 3.0. OK, you
>>  don't care about libc5. It's still pretty weird. Wierd? Weird.
>
>This has been brought up many times on this list: you are not supposed
>to include kernel headers in userland.

That's not the problem, I think. Most of time.h, including the 
definition of mktime, is #ifdef __KERNEL__, so it shouldn't be 
breaking anything in userland even if you do include it. And you 
might, in order to obtain the interface definition of struct 
timespec. What's weird is: why is __KERNEL__ getting #defined in 
Rick's userland?

There can't, of course, be any blanket prohibition against using 
kernel headers in userland. Think about ioctl.h, for example.
-- 
/Jonathan Lundell.

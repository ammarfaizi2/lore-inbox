Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261978AbSLYOFx>; Wed, 25 Dec 2002 09:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262038AbSLYOFx>; Wed, 25 Dec 2002 09:05:53 -0500
Received: from mail.untergrund.net ([213.133.101.44]:35502 "EHLO
	mail.untergrund.net") by vger.kernel.org with ESMTP
	id <S261978AbSLYOFw>; Wed, 25 Dec 2002 09:05:52 -0500
Date: Wed, 25 Dec 2002 15:12:08 +0100 (CET)
From: Michael Krause <mk@soundtracker.org>
To: <linux-kernel@vger.kernel.org>
Subject: Context of strategy routine in block device drivers
Message-ID: <Pine.LNX.4.33.0212251459400.2765-100000@raw.home.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-RBL-Warning: (dialups.relays.osirusoft.com) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi list,

I have a question concerning the strategy routine of a block device
driver. Any hints or pointers would be appreciated; a search of the
list archives did not reveal anything.

Alessandro Rubini & Jonathan Corbet write on p. 331 of their book
"Linux Device Drivers", 2nd ed:

 "The request function has one very important constraint: it must be
 atomic. request is not usually called in direct response to user
 requests, and it is not running in the context of any particular
 process. It can be called at interrupt time, from tasklets, or from
 any number of other places. Thus, it must not sleep while carrying out
 its tasks."

Why, then, is sleep_on() used happily all over
linux/drivers/block/amiflop.c? According to the above statement, this
should not work. I also use sleep_on(), together with a kernel timer,
in order to implement a simple delay in my own device driver, and it
has always worked fine. Why? Am I just having good luck?

Yours confused,
-- 
michael krause -- .oO[ http://www.soundtracker.org/raw/ ]Oo.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319668AbSIMPbP>; Fri, 13 Sep 2002 11:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319673AbSIMPbP>; Fri, 13 Sep 2002 11:31:15 -0400
Received: from dsl-213-023-022-092.arcor-ip.net ([213.23.22.92]:30095 "EHLO
	starship") by vger.kernel.org with ESMTP id <S319668AbSIMPbP>;
	Fri, 13 Sep 2002 11:31:15 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Thunder from the hill <thunder@lightweight.ods.org>
Subject: Re: [RFC] Raceless module interface
Date: Fri, 13 Sep 2002 17:37:19 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       Roman Zippel <zippel@linux-m68k.org>,
       Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Alexander Viro <viro@math.psu.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0209130919480.10048-100000@hawkeye.luckynet.adm>
In-Reply-To: <Pine.LNX.4.44.0209130919480.10048-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17psVT-0008Ae-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 September 2002 17:27, Thunder from the hill wrote:
> > This applies equally to the two-prong interface.  Do you see the pattern
> > yet?
> 
> Yes, but you don't seem to. (No, I don't want to insult you here.)
> 
> Just to draw that:
> 
> 2p:
> 
> thread1						thread2
> struct x *y = malloc(sizeof(struct x));
> check y;
> blah();						cleanup(y et al);
> touch y->blah; /* bang */

This can't happen because a semaphore serializes the load and unload.
(Currently, module.c uses lock_kernel, which is obviously inadequate.)

-- 
Daniel

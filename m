Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269081AbRHaTbK>; Fri, 31 Aug 2001 15:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269099AbRHaTa7>; Fri, 31 Aug 2001 15:30:59 -0400
Received: from albireo.ucw.cz ([62.168.0.14]:27398 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id <S269081AbRHaTar>;
	Fri, 31 Aug 2001 15:30:47 -0400
Date: Fri, 31 Aug 2001 21:30:50 +0200
From: Martin Mares <mj@ucw.cz>
To: Nico Schottelius <nicos@pcsystems.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]: problem: pc_keyb.h
Message-ID: <20010831213050.A3217@albireo.ucw.cz>
In-Reply-To: <3B8FE42B.23804609@pcsystems.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B8FE42B.23804609@pcsystems.de>; from nicos@pcsystems.de on Fri, Aug 31, 2001 at 09:23:23PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Why can't I include pc_keyb.h directtly into a C program ?
> I need that for a part of GPM.

pc_keyb.h is a kernel include, thus it uses the kernel set of types
which unfortunately collides badly with the types used in user space.

The best solution is to create your own include and copy the
relevant parts of pc_keyb.h there.

BTW what exactly do you plan to do? Sending keyboard controller
or mouse controller commands from user space is probably very
dangerous as it's going to collide with the commands sent by the
kernel.
 
				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
If a train station is where the train stops, what is a work station?

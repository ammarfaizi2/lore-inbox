Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316757AbSGQU6w>; Wed, 17 Jul 2002 16:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316770AbSGQU6w>; Wed, 17 Jul 2002 16:58:52 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:37894 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316757AbSGQU6v>; Wed, 17 Jul 2002 16:58:51 -0400
Date: Wed, 17 Jul 2002 14:02:39 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Daniel Phillips <phillips@arcor.de>, <linux-kernel@vger.kernel.org>
Subject: Re: HZ, preferably as small as possible
In-Reply-To: <Pine.LNX.3.95.1020717162206.12592A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.44.0207171359000.6820-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 17 Jul 2002, Richard B. Johnson wrote:
>
> It is hardly novel and I can't imagine how Bresenham or whomever
> could make such a claim to the obvious. Even the DOS writer(s) used
> this technique to get one-second time intervals from the 18.206
> ticks/per second.

Ehh.. Look at _existing_ linux code to do exactly the same.

See update_wall_time_one_tick() and second_overflow() (which does a lot
more besides, but it does largely boil down to this "average fractions
using basic integer math" thing.

		Linus


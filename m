Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267675AbTAHDZH>; Tue, 7 Jan 2003 22:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267681AbTAHDZH>; Tue, 7 Jan 2003 22:25:07 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:64777 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267675AbTAHDZG>; Tue, 7 Jan 2003 22:25:06 -0500
Date: Tue, 7 Jan 2003 19:29:00 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] linux-2.5.54_delay-cleanup_A0
In-Reply-To: <1041993975.1052.71.camel@w-jstultz2.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.44.0301071927190.1892-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 7 Jan 2003, john stultz wrote:
> 
> 	if (timer)
> 		timer->delay(loops);

Why the "if (timer)"?

Wouldn't it be saner to initialize the timer to something that can at 
least do estimated loops, and then just unconditionally do

	timer->delay(..);

instead?

		Linus


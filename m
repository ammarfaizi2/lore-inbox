Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319276AbSIKSwl>; Wed, 11 Sep 2002 14:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319281AbSIKSwl>; Wed, 11 Sep 2002 14:52:41 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:7873 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S319276AbSIKSwk> convert rfc822-to-8bit; Wed, 11 Sep 2002 14:52:40 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: Daniel Phillips <phillips@arcor.de>, Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [RFC] Raceless module interface
Date: Wed, 11 Sep 2002 20:53:52 +0200
User-Agent: KMail/1.4.1
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Alexander Viro <viro@math.psu.edu>,
       Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0209101201280.8911-100000@serv> <E17pCKQ-0007Sz-00@starship>
In-Reply-To: <E17pCKQ-0007Sz-00@starship>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209112053.52426.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Now there's the question "if this is such a great approach, why not make
> all modules work this way, not just filesystems?".  Easy: the magic
> scheduling approach impacts the scheduler, however lightly, and worse,
> we cannot put an upper bound on the time needed for

You are in principle describing RCU. These guys seem to have solved the
problem.

> magic_wait_for_quiescence to complete.  So the try_count approach is
> preferable, where it works.

But the try_count approach hurts every user of the defined interfaces,
even if modules are not used. Is the impact on the scheduler limited
to the time magic_wait_for_quiescence is running.
If so, the approach looks superior.

	Regards
		Oliver


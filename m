Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130615AbRADJeA>; Thu, 4 Jan 2001 04:34:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131785AbRADJdu>; Thu, 4 Jan 2001 04:33:50 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:37904 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130615AbRADJdo>; Thu, 4 Jan 2001 04:33:44 -0500
Date: Thu, 4 Jan 2001 01:31:54 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Tom Leete <tleete@mountain.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] testing/prerelease of 01/03 on startup
In-Reply-To: <3A543D8E.9489F715@mountain.net>
Message-ID: <Pine.LNX.4.10.10101040117370.15040-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Jan 2001, Tom Leete wrote:
> 
> kernel is 2.4.0-prerelease with testing/prerelease patch of Jan. 3, i486.
> Oops is repeatable.

Looks like your mm->mmlist list is corrupted from the very start.

Can you humor me and make sure you do a "make clean" and re-check your
prerelease patch? Is the initialization of mmlist there in linux/sched.h,
for example?

		Linus


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

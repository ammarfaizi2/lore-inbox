Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267503AbTACMmE>; Fri, 3 Jan 2003 07:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267510AbTACMmE>; Fri, 3 Jan 2003 07:42:04 -0500
Received: from services.cam.org ([198.73.180.252]:12114 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S267503AbTACMmD> convert rfc822-to-8bit;
	Fri, 3 Jan 2003 07:42:03 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH,RFC] fix o(1) handling of threads
Date: Fri, 3 Jan 2003 07:50:26 -0500
User-Agent: KMail/1.4.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Robert Love <rml@tech9.net>
References: <Pine.LNX.4.44.0301030120410.2226-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0301030120410.2226-100000@localhost.localdomain>
MIME-Version: 1.0
Message-Id: <200301030750.27040.tomlins@cam.org>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 2, 2003 07:22 pm, Ingo Molnar wrote:
> On Wed, 1 Jan 2003, Ed Tomlinson wrote:
> > Here is the scheduler-tunables patch updated to include USER_PENALTY and
> > THREAD_PENANTY.  This on top of ptg_B0.
>
> there's no way we'll make the scheduler internal constants tunable in such
> a wide range. Such a patch has been submitted a couple of months ago
> already. I do use something like that to test tunings, but it's definitely
> not something we want to make tunable directly in the stock kernel.

Nor would I advocate doing so.  I added two 'constants' I wanted to
be able to test them so I updated Robert's patch...  Two questions
for you.

1. Do you have any comments/suggestsion on the ptg_B0 patch?

2. I have been playing with using user and thread penalties together.
- they often interact badly.  Using just one works very well.  This
can be fixed - but gets messy.  Alternately, I am thinking about 
implementing per user policies.  ie.

	a. govern thread groups
	b. govern all threads, ignoring groups, for a user
	c. govern processes for a user

This can be done cleanly.  Would something along the lines of sys_nice
be the way to implement the kernel side of the user interface to this?

TIA,
Ed Tomlinson

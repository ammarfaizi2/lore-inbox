Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265570AbSKKGA1>; Mon, 11 Nov 2002 01:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265571AbSKKGA1>; Mon, 11 Nov 2002 01:00:27 -0500
Received: from adedition.com ([216.209.85.42]:12296 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S265570AbSKKGA0>;
	Mon, 11 Nov 2002 01:00:26 -0500
Date: Mon, 11 Nov 2002 01:12:17 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: linux-kernel@vger.kernel.org
Subject: PROT_SEM + FUTEX
Message-ID: <20021111061217.GA28158@mark.mielke.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is PROT_SEM necessary anymore? 2.5.46 does not seem to include any
references to it that adjust behaviour for pages. Would it be
reasonable to remove it, or #define PROT_SEM to (0) to avoid
confusion?

I am beginning to play with the FUTEX system call. I am hoping that
PROT_SEM is not required, as I intend to scatter the words throughout
memory, and it would be a real pain to mprotect(PROT_SEM) each page
that contains a FUTEX word.

For systems that do not support the FUTEX system call (2.4.x?),
is sched_yield() the best alternative?

Thanks,
mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/


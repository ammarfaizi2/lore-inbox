Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267955AbTAHXDE>; Wed, 8 Jan 2003 18:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267957AbTAHXDE>; Wed, 8 Jan 2003 18:03:04 -0500
Received: from pizda.ninka.net ([216.101.162.242]:26857 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267955AbTAHXDD>;
	Wed, 8 Jan 2003 18:03:03 -0500
Date: Wed, 08 Jan 2003 15:03:03 -0800 (PST)
Message-Id: <20030108.150303.130044451.davem@redhat.com>
To: torvalds@transmeta.com
Cc: levon@movementarian.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] /proc/sys/kernel/pointer_size
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0301081502270.7688-100000@penguin.transmeta.com>
References: <20030108.143441.31155028.davem@redhat.com>
	<Pine.LNX.4.44.0301081502270.7688-100000@penguin.transmeta.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linus Torvalds <torvalds@transmeta.com>
   Date: Wed, 8 Jan 2003 15:04:05 -0800 (PST)

   System binaries match the kernel. It's as easy as that. So what if 90% of 
   the user binaries use 32-bit mode because it's smaller and faster? We're 
   talking about a system binary that is _very_ intimate with the kernel.
   
oprofile can perfectly legitimately be used to monitor 32-bit binaries
running on under a 64-bit kernel environment.  In fact I expect such
exercises to be very instructive.  Anton Blanchard has done this
already on ppc64.

And being that 64-bit sparc systems run several orders of magnitude
faster than 32-bit ones, I think I'd prefer to oprofile 32-bit
programs on sparc64 boxes :-)

Hey, if this is so distasteful we could just add a
sys_kernel_pointer_size() to sparc64 and ppc64 and be done with it.
The other choice, as mentioned, is to make every platform use u64's
in the tables.

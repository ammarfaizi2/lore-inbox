Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289925AbSAKMHP>; Fri, 11 Jan 2002 07:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289924AbSAKMHA>; Fri, 11 Jan 2002 07:07:00 -0500
Received: from pizda.ninka.net ([216.101.162.242]:34433 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S289925AbSAKMGu>;
	Fri, 11 Jan 2002 07:06:50 -0500
Date: Fri, 11 Jan 2002 04:05:37 -0800 (PST)
Message-Id: <20020111.040537.115909086.davem@redhat.com>
To: rmk@arm.linux.org.uk
Cc: mingo@elte.hu, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] O(1) scheduler, -H5
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020111113131.C30756@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.33.0201110130290.11478-100000@localhost.localdomain>
	<20020111113131.C30756@flint.arm.linux.org.uk>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Russell King <rmk@arm.linux.org.uk>
   Date: Fri, 11 Jan 2002 11:31:31 +0000
   
   The serial driver (old or new) open/close functions are one of the worst
   offenders of the global-cli-and-hold-kernel-lock-and-schedule problem.
   I'm currently working on fixing this in the new serial driver.

The tty layer is really the only layer that hasn't had any
"SMP love and care" given to it.

Last time I looked at trying to do something it appeared you could fix
the whole thing up with a semaphore for the user bits and a spinlock
with which to interlock with the drivers.

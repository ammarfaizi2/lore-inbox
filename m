Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311081AbSCHU0D>; Fri, 8 Mar 2002 15:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311078AbSCHUZn>; Fri, 8 Mar 2002 15:25:43 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:21776 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311079AbSCHUZl>; Fri, 8 Mar 2002 15:25:41 -0500
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
To: torvalds@transmeta.com (Linus Torvalds)
Date: Fri, 8 Mar 2002 20:40:46 +0000 (GMT)
Cc: frankeh@watson.ibm.com (Hubertus Franke),
        rusty@rustcorp.com.au (Rusty Russell), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0203081109390.2749-100000@penguin.transmeta.com> from "Linus Torvalds" at Mar 08, 2002 11:22:20 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16jRAU-0007QU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So I would suggest making the size (and thus alignment check) of locks at
> least 8 bytes (and preferably 16). That makes it slightly harder to put
> locks on the stack, but gcc does support stack alignment, even if the code
> sucks right now.

Can we go to cache line alignment - for an array of locks thats clearly
advantageous


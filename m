Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135723AbRDSVip>; Thu, 19 Apr 2001 17:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135722AbRDSVii>; Thu, 19 Apr 2001 17:38:38 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:17680 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135723AbRDSViH>; Thu, 19 Apr 2001 17:38:07 -0400
Subject: Re: light weight user level semaphores
To: ingo.oeser@informatik.tu-chemnitz.de (Ingo Oeser)
Date: Thu, 19 Apr 2001 22:38:42 +0100 (BST)
Cc: drepper@cygnus.com (Ulrich Drepper),
        torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <20010419222228.J682@nightmaster.csn.tu-chemnitz.de> from "Ingo Oeser" at Apr 19, 2001 10:22:28 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14qM8S-00089B-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Are you sure, you can implement SMP-safe, atomic operations (which you need
> for all up()/down() in user space) WITHOUT using privileged
> instructions on ALL archs Linux supports?

You don't need to. For some architectures the semaphore code would always call
into the kernel. For those that allow fast locks in userspace it won't. The
API is the thing, and the public exposure would I assume be pthreads 



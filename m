Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315483AbSIDVXm>; Wed, 4 Sep 2002 17:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315485AbSIDVXm>; Wed, 4 Sep 2002 17:23:42 -0400
Received: from 166.Red-80-36-134.pooles.rima-tde.net ([80.36.134.166]:28202
	"EHLO apocalipsis") by vger.kernel.org with ESMTP
	id <S315483AbSIDVXl>; Wed, 4 Sep 2002 17:23:41 -0400
Date: Wed, 4 Sep 2002 23:29:31 +0200
From: "Juan M. de la Torre" <jmtorre@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Questions on semaphores
Message-ID: <20020904212931.GA2014@apocalipsis>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hi people, I have two question regarding the i386 semaphore implementation
 in kernel 2.4.19. 
 
 Please dont blame me if they are too obvius; i'm a newbie in kernel hacking
 :)

 The functions __down, __down_interruptible and __down_trylock (defined
 in arch/i386/kernel/semaphore.c) use the global spinlock
 'semaphore_lock' to access some fields of the semaphore they are
 working on:
 
 1) Is there any reason to do this?
 2) Wouldn't it be more scalable to use a per-semaphore lock instead a
    global spinlock?

 The function __down_trylock try to get the spinlock using
 spin_lock_irqsave, instead of using spin_lock_irq:

 1) why? :)

 Thanks in advance,
 Juanma

-- 
/jm


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291809AbSCDGds>; Mon, 4 Mar 2002 01:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291863AbSCDGdh>; Mon, 4 Mar 2002 01:33:37 -0500
Received: from barkley.vpha.health.ufl.edu ([159.178.78.160]:58570 "EHLO
	barkley.vpha.health.ufl.edu") by vger.kernel.org with ESMTP
	id <S291809AbSCDGdZ>; Mon, 4 Mar 2002 01:33:25 -0500
Message-ID: <1015223610.3c83153a33024@webmail.health.ufl.edu>
Date: Mon,  4 Mar 2002 01:33:30 -0500
From: sridharv@ufl.edu
To: linux-kernel@vger.kernel.org
Subject: Re: interrupt - spin lock question
In-Reply-To: <1015219129.3c8303b9e87a7@webmail.health.ufl.edu> <1015219669.868.35.camel@phantasy>
In-Reply-To: <1015219669.868.35.camel@phantasy>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.0
X-Originating-IP: 66.157.144.214
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Right, that is why you would use a spin_lock ! :)
> 
> Further, you would want to use a spin_lock_irq and related friends.  The
> irq disable prevents the race wrt interrupts and the spin_lock prevents
> racing wrt SMP.
> 

ok things are clear now. so the spin_lock_irq friends are actually for 2 
purposes - preventing racing from interrupts and from SMP. so if SMP is not 
chosen only the local_irq_disable() part works right??

do { local_irq_disable();         spin_lock(lock); } while (0)


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291664AbSBHX4S>; Fri, 8 Feb 2002 18:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291887AbSBHX4I>; Fri, 8 Feb 2002 18:56:08 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:14854 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291823AbSBHX4F>; Fri, 8 Feb 2002 18:56:05 -0500
Subject: Re: [RFC] New locking primitive for 2.5
To: mfedyk@matchmail.com (Mike Fedyk)
Date: Sat, 9 Feb 2002 00:09:04 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <20020208211628.GC343@mis-mike-wstn> from "Mike Fedyk" at Feb 08, 2002 01:16:28 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16ZL4i-0005Ri-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> SMP 486s would need that (if there is such a beast).  What point does x86
> get the 64 bit instructions?  If after 586, then it would definately need a
> spinlock or somesuch in those functions.

There are SMP 486 class x86 machines that are MP 1.1 compliant. They are
sufficiently rare that I think its quite acceptable to "implement" a
cmpxchg8b macro on 486 as spin_lock_irqsave/blah/spin_unlock_irqrestore. It
would be wrong to cripple the other 99.99% of SMP users

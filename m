Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270229AbRHWT5i>; Thu, 23 Aug 2001 15:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270195AbRHWT5S>; Thu, 23 Aug 2001 15:57:18 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:26122 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270252AbRHWT5Q>; Thu, 23 Aug 2001 15:57:16 -0400
Subject: Re: gcc bug causing problem in kernel builds
To: Paul.Clements@SteelEye.com (Paul Clements)
Date: Thu, 23 Aug 2001 21:00:34 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B855C19.7A4233BF@SteelEye.com> from "Paul Clements" at Aug 23, 2001 03:40:09 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15a0eY-0004U3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Now, the problem is that RedHat also apparently compiles (at least its
> newer) kernels with the 2.96 gcc. Unfortunately, there appears to be a
> structure misalignment problem in gcc 2.96. 

The kernel is compiled with some objects differently according to the
compiler features. In paticular we have to pad out structures with 0 length
elements in the older compilers to fix a compiler bug. You must
compile with the same precise compiler and options as the kernel itself.

> Does anyone know if the structure misalignment problem in gcc 2.96 is a
> known issue? (could this bug be induced by a RedHat-applied gcc patch,
> if there are any)

gcc 2.96-54 had plenty of bugs, 2.96-75+ should be perfectly fine for
all uses. If you have a 2.96 RH problem please report it in Red Hat
bugzilla - the gcc core folks won't be too interested as they are focused
on 2.95.4 and 3.0.1 bug fixing.

Alan

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282174AbRK1X2X>; Wed, 28 Nov 2001 18:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282168AbRK1X2O>; Wed, 28 Nov 2001 18:28:14 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:48145 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S282167AbRK1X2C>; Wed, 28 Nov 2001 18:28:02 -0500
Subject: Re: [PATCH] remove BKL from drivers' release functions
To: haveblue@us.ibm.com (David C. Hansen)
Date: Wed, 28 Nov 2001 23:36:18 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200111282305.fASN5ap02626@localhost.localdomain> from "David C. Hansen" at Nov 28, 2001 03:05:36 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E169EFX-0006TA-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> drivers' release functions.  The release functions are already 
> serialized in the VFS code by an atomic_t which guarantees that each 

The release function was only partially serialized - what stops a release
and an open racing each other ? That in several cases was why the lock
was there. 

I'm not saying your patch isnt a good thing. General rule of thumb, any user
of lock_kernel has a race 8)



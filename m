Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289588AbSAKLmu>; Fri, 11 Jan 2002 06:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289685AbSAKLma>; Fri, 11 Jan 2002 06:42:30 -0500
Received: from ns.suse.de ([213.95.15.193]:44297 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S289588AbSAKLmV>;
	Fri, 11 Jan 2002 06:42:21 -0500
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] O(1) scheduler, -H5
In-Reply-To: <Pine.LNX.4.33.0201110130290.11478-100000@localhost.localdomain.suse.lists.linux.kernel> <20020111113131.C30756@flint.arm.linux.org.uk.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 11 Jan 2002 12:42:14 +0100
In-Reply-To: Russell King's message of "11 Jan 2002 12:37:44 +0100"
Message-ID: <p73zo3lnmg9.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk@arm.linux.org.uk> writes:
> 
> The serial driver (old or new) open/close functions are one of the worst
> offenders of the global-cli-and-hold-kernel-lock-and-schedule problem.
> I'm currently working on fixing this in the new serial driver.

When they hold the kernel lock in addition to the global cli() before
schedule() it should be ok. Only the behaviour of code not holding
kernel lock but global cli and calling schedule() has changed.

-Andi

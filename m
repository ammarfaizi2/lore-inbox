Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289940AbSAKM54>; Fri, 11 Jan 2002 07:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289941AbSAKM5q>; Fri, 11 Jan 2002 07:57:46 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:26372 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289940AbSAKM5g>; Fri, 11 Jan 2002 07:57:36 -0500
Subject: Re: [patch] O(1) scheduler, -H5
To: rmk@arm.linux.org.uk (Russell King)
Date: Fri, 11 Jan 2002 13:09:03 +0000 (GMT)
Cc: mingo@elte.hu (Ingo Molnar), torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org
In-Reply-To: <20020111113131.C30756@flint.arm.linux.org.uk> from "Russell King" at Jan 11, 2002 11:31:31 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16P1Qd-0007aL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The serial driver (old or new) open/close functions are one of the worst
> offenders of the global-cli-and-hold-kernel-lock-and-schedule problem.
> I'm currently working on fixing this in the new serial driver.

Someone fixed serial.c to use spinlocks a long while ago. Its just not
merged

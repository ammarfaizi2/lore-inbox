Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268952AbTCDBZQ>; Mon, 3 Mar 2003 20:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268953AbTCDBZQ>; Mon, 3 Mar 2003 20:25:16 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:4351 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id <S268952AbTCDBZQ>;
	Mon, 3 Mar 2003 20:25:16 -0500
Date: Tue, 4 Mar 2003 02:35:30 +0100 (MET)
From: Mikael Pettersson <mikpe@user.it.uu.se>
Message-Id: <200303040135.h241ZUkf019356@harpo.it.uu.se>
To: pavel@ucw.cz
Subject: Re: Switch APIC to driver model
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Mar 2003 23:48:01 +0100, Pavel Machek wrote:
>This switches to driver model, making suspend-to-ram possible. Please
>apply,
>								Pavel
>
>--- clean/arch/i386/kernel/apic.c	2003-02-28 15:10:01.000000000 +0100
>+++ linux/arch/i386/kernel/apic.c	2003-02-28 15:33:45.000000000 +0100

This version works a lot better than the previous one(s). My P4,
which suspends/resumes via apm just fine with UP_APIC, survived
two suspend/resume cycles with this patch: one synchronous
(apm --suspend), and one asynchronous (short press on power button).
Not having IDE oops in a BUG_ON() is a definite improvement.

I had to add an #include <linux/device.h> to apm.c, a patch hunk
failed in oprofile, and there are some cosmetic things I don't like.
I'll merge this with my previous version tomorrow.

/Mikael

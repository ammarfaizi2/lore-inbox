Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293203AbSGUJ0B>; Sun, 21 Jul 2002 05:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310190AbSGUJ0B>; Sun, 21 Jul 2002 05:26:01 -0400
Received: from ns.suse.de ([213.95.15.193]:37897 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S293203AbSGUJ0B>;
	Sun, 21 Jul 2002 05:26:01 -0400
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH -ac] Panicking in morse code v3
References: <20020719011300.548d72d5.arodland@noln.com.suse.lists.linux.kernel> <20020720173222.3286fcbb.arodland@noln.com.suse.lists.linux.kernel> <200207211849.56076.bhards@bigpond.net.au.suse.lists.linux.kernel> <20020721100818.A22176@flint.arm.linux.org.uk.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 21 Jul 2002 11:29:06 +0200
In-Reply-To: Russell King's message of "21 Jul 2002 11:10:18 +0200"
Message-ID: <p73u1mttonx.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk@arm.linux.org.uk> writes:

> Hmm.  I thought the original idea for the "flash LEDs on panic" was
> so you knew something had gone wrong early in the boot, at the kind
> of places where you don't have a console initialised.  If you don't
> have the console initialised, you sure as hell don't have the input
> layer or keyboard drivers initialised.

[having written the original code...]
The idea was to distingush panic from lockup when you are in X and cannot
see the console and X is dead so you cannot switch to the console.

Handling early panic is probably better done by an "early console", like
x86-64 supports one.

-Andi

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265894AbTBPG0d>; Sun, 16 Feb 2003 01:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265895AbTBPG0d>; Sun, 16 Feb 2003 01:26:33 -0500
Received: from ns.suse.de ([213.95.15.193]:51460 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265894AbTBPG0d>;
	Sun, 16 Feb 2003 01:26:33 -0500
To: Anton Blanchard <anton@samba.org>
Cc: linux-kernel@vger.kernel.org, tim@physik3.uni-rostock.de
Subject: Re: [PATCH] make jiffies wrap 5 min after boot
References: <Pine.LNX.4.33L2.0302040935230.6174-100000@dragon.pdx.osdl.net.suse.lists.linux.kernel> <Pine.LNX.4.33.0302160232120.7975-100000@gans.physik3.uni-rostock.de.suse.lists.linux.kernel> <20030216020808.GF9833@krispykreme.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 16 Feb 2003 07:36:26 +0100
In-Reply-To: Anton Blanchard's message of "16 Feb 2003 03:11:30 +0100"
Message-ID: <p73znowybo5.fsf@amdsimf.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard <anton@samba.org> writes:

> Hi,
> 
> > +#define INITIAL_JIFFIES (0xffffffffUL & (unsigned long)(-300*HZ))
> 
> In order to make 64bit arches wrap too, you might want to use -1UL here.
> Not that jiffies should wrap on a 64bit machine...

Seems somewhat pointless.

(2^64-1) / (1000 * 3600 * 24 * 365)
        ~584942417.35507203243911719939

I doubt any system ever will have an uptime of > 584 million years
(assuming HZ=1000) and if jiffies wrap will be the least of their
problems.

-Andi


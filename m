Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265863AbTBPIAp>; Sun, 16 Feb 2003 03:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265865AbTBPIAp>; Sun, 16 Feb 2003 03:00:45 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:56554 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S265863AbTBPIAp>; Sun, 16 Feb 2003 03:00:45 -0500
Date: Sun, 16 Feb 2003 09:10:31 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Anton Blanchard <anton@samba.org>
cc: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@digeo.com>,
       Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make jiffies wrap 5 min after boot
In-Reply-To: <20030215225618.538f4c70.akpm@digeo.com>
Message-ID: <Pine.LNX.4.33.0302160900100.8770-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard <anton@samba.org> writes:
> Hi,
>
> > +#define INITIAL_JIFFIES (0xffffffffUL & (unsigned long)(-300*HZ))
>
> In order to make 64bit arches wrap too, you might want to use -1UL here.
> Not that jiffies should wrap on a 64bit machine...

The whole point of the "0xffffffffUL &" is not to test 64 bit arches,
because I know Andi doesn't take jiffies wrap patches. And-ing with -1UL
is a no-op, as it is with ~0UL.

Tim




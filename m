Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266387AbSKOQKo>; Fri, 15 Nov 2002 11:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266390AbSKOQKo>; Fri, 15 Nov 2002 11:10:44 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:27317 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S266387AbSKOQKm>; Fri, 15 Nov 2002 11:10:42 -0500
Date: Fri, 15 Nov 2002 17:17:37 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: "Mario 'BitKoenig' Holbe" <Mario.Holbe@RZ.TU-Ilmenau.DE>
cc: <linux-kernel@vger.kernel.org>, <Elrond@Wunder-Nett.org>
Subject: Re: /proc/stat interface and 32bit jiffies / kernel_stat
In-Reply-To: <20021115142244.GG5957@darkside.ddts.net>
Message-ID: <Pine.LNX.4.33.0211151709260.29719-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Nov 2002, Mario 'BitKoenig' Holbe wrote:

[system idle time will overflow after about 497/NR_CPUS days]
> 
> Since it should not be a big problem to fix this, to
> at least reduce the problem back to the 500 days
> jiffies-overflow problem, I'd suggest to do so.
> 
> No need to mention, that 64bit jiffies and statistics on
> all platforms at all would be great :)

2.5 has 64 bit jiffies (but not (yet?) 64 bit statistics).

A patch for 2.4 that fixes the overflow in proc_stat as well as 
introducing 63 bit jiffies is at
  http://www.physik3.uni-rostock.de/tim/kernel/2.4/jiffies64-20.patch.gz

> 
> Btw... Could anybody please explain me the problems to
> expect while a jiffies overflow? Would a kernel possibly
> survive this at all and if, what's the chance to? :)

"ps" will report processes started before the jiffies wrap as being 
started in the future, but this won't do any harm.

Tim


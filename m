Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263886AbTCUV7W>; Fri, 21 Mar 2003 16:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263861AbTCUV7I>; Fri, 21 Mar 2003 16:59:08 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:28606 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S263863AbTCUV5I>; Fri, 21 Mar 2003 16:57:08 -0500
Date: Fri, 21 Mar 2003 23:08:04 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>, <torvalds@transmeta.com>
Subject: Re: PATCH: time is ulong
In-Reply-To: <200303212002.h2LK2QtZ026205@hraefn.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0303212303230.19450-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -#define INITIAL_JIFFIES ((unsigned int) (-300*HZ))
> +#define INITIAL_JIFFIES ((unsigned long) (-300*HZ))

No. This was deliberate since testing 32 bit jiffies wrap seems more
beneficial than testing 64 bit jiffies.
Just the formulation might be misleading, which is why I initially wrote
  #define INITIAL_JIFFIES (0xffffffffUL & (unsigned long)(-300*HZ))

Tim


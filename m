Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262079AbVBTW5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbVBTW5m (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 17:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262082AbVBTW5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 17:57:42 -0500
Received: from [139.30.44.16] ([139.30.44.16]:1984 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S262079AbVBTW5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 17:57:40 -0500
Date: Sun, 20 Feb 2005 23:57:26 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Kari Laine <kari.laine@karilaine.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: ASUS P2B-DS
In-Reply-To: <1108937794.14361.14.camel@tech.linuxware.fi>
Message-ID: <Pine.LNX.4.53.0502202348340.8425@gockel.physik3.uni-rostock.de>
References: <1108937794.14361.14.camel@tech.linuxware.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Vise People,
> <GH1N2J3JKL - this helps, me to find answers - please keep line>
> 
> ASUS P2B-DS board seems NOT work very well with default kernel in FED
> Core 3.  smp-kernel hangs booting at various stages. I am goig to try
> 2.6.10 today. non-smp-kernel boots fine. This is my first time I try to
> test with smp-kernels so I don't know what I could try. Could someone
> give me some directions what to test?
> 
> If someone already know this is doomed motherboard might say so I
> wouldn't waste time with it. Thanks.

P2B-DS is a great, robust mainboard. This mail is written on one, and we 
have some more in production. Never had any problems with them.

Try deleting the OSS sound drivers under /lib/modules/*/kernel/sound/oss/ .

While I don't run fedora, I had similar problems with SuSE 9.1 and 9.2.
These boiled down to a problem with the el cheapo fm801 soundcard I 
plugged into the board.
The default installation installed an OSS driver that is not SMP-safe. 
After removing the driver, the correct ALSA driver got selected and 
everything was fine.

Hope this helps
Tim

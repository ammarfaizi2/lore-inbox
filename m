Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292045AbSB0Eeo>; Tue, 26 Feb 2002 23:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292057AbSB0Eee>; Tue, 26 Feb 2002 23:34:34 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:265 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S292045AbSB0EeP>; Tue, 26 Feb 2002 23:34:15 -0500
Date: Wed, 27 Feb 2002 05:34:11 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Andreas Dilger <adilger@turbolabs.com>
cc: george anzinger <george@mvista.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch][rfc] enable uptime display > 497 days on 32 bit
In-Reply-To: <20020226163323.G12832@lynx.adilger.int>
Message-ID: <Pine.LNX.4.33.0202270530370.19675-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Feb 2002, Andreas Dilger wrote:
> I'm
> not quite sure why we need to use the irq spinlock, since we already
> make a local copy of jiffies so another timer IRQ changing the jiffies
> value shouldn't affect the return value of get_jiffies64().  Then again,
> that isn't exactly stuff I'm familiar with, so I could be totally
> off-base here.

Indeed, the outcome of get_jiffies64() cannot be affected. The lock is 
just to prevent the tiny chance of jiffies_hi getting incremented twice.

Tim 


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271117AbTHQWkk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 18:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271119AbTHQWkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 18:40:39 -0400
Received: from [66.212.224.118] ([66.212.224.118]:59654 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S271117AbTHQWki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 18:40:38 -0400
Date: Sun, 17 Aug 2003 18:28:46 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
Cc: Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: NMI appears to be stuck! (2.4.22-rc2 on dual Athlon)
In-Reply-To: <20030817222843.GB10967@www.13thfloor.at>
Message-ID: <Pine.LNX.4.53.0308171822391.9067@montezuma.mastecende.com>
References: <20030817212824.GA9025@www.13thfloor.at> <20030817221114.GA734@alpha.home.local>
 <20030817222843.GB10967@www.13thfloor.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Aug 2003, Herbert Pötzl wrote:

> > mine works fine only with nmi_watchdog=2. Don't know why. 
> > It's an ASUS A7M266D.
> 
> hmm, nmi_watchdog=2 on the kernel boot line gives no
> difference to booting without, at least according to
> the boot messages ...

nmi_watchdog=2 will work on the majority of i686+ (performance 
counters with NMI delivery mode) boxes and you can check whether it's 
enabled by doing cat /proc/interrupts and watching if the NMI line ticks 
at a decent rate. nmi_watchdog=1 tends to be harder for hardware 
manufacturers to get right (for some reason or other).

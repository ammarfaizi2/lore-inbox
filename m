Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271112AbTHQWts (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 18:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271116AbTHQWts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 18:49:48 -0400
Received: from www.13thfloor.at ([212.16.59.250]:50137 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S271112AbTHQWtr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 18:49:47 -0400
Date: Mon, 18 Aug 2003 00:49:31 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: NMI appears to be stuck! (2.4.22-rc2 on dual Athlon)
Message-ID: <20030817224931.GA12641@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Zwane Mwaikambo <zwane@linuxpower.ca>,
	Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <20030817212824.GA9025@www.13thfloor.at> <20030817221114.GA734@alpha.home.local> <20030817222843.GB10967@www.13thfloor.at> <Pine.LNX.4.53.0308171822391.9067@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.53.0308171822391.9067@montezuma.mastecende.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 17, 2003 at 06:28:46PM -0400, Zwane Mwaikambo wrote:
> On Mon, 18 Aug 2003, Herbert Pötzl wrote:
> 
> > > mine works fine only with nmi_watchdog=2. Don't know why. 
> > > It's an ASUS A7M266D.
> > 
> > hmm, nmi_watchdog=2 on the kernel boot line gives no
> > difference to booting without, at least according to
> > the boot messages ...
> 
> nmi_watchdog=2 will work on the majority of i686+ (performance 
> counters with NMI delivery mode) boxes and you can check whether it's 
> enabled by doing cat /proc/interrupts and watching if the NMI line ticks 

okay, but this would mean that the nmi_watchdog is
enabled if I do not specify nmi_watchdog at the kernel
boot/command line ... or how should I interpret the
steadily increasing NMI counts in this case?

don't get me wrong, I'm happy if nmi_watchdog is
enabled by default, but I would like to know/verify
that ... 

> at a decent rate. nmi_watchdog=1 tends to be harder for hardware 
> manufacturers to get right (for some reason or other).

no nmi_watchdog and nmi_watchdog=2, both result in
increasing NMI counts, nmi_watchdog=1, only in LOC
counts ...

# cat /proc/interrupts 
           CPU0       CPU1       
NMI:      75378      74923 
LOC:     159900     159896 
ERR:          0
MIS:          0

TIA,
Herbert


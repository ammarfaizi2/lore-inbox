Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261834AbVAHWJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261834AbVAHWJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 17:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbVAHWGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 17:06:47 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:61098 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261834AbVAHWCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 17:02:52 -0500
Subject: Re: Make pipe data structure be a circular list of pages, rather
	than
From: Lee Revell <rlrevell@joe-job.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       Mike Waychison <Michael.Waychison@Sun.COM>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0501081345440.2386@ppc970.osdl.org>
References: <41DE9D10.B33ED5E4@tv-sign.ru>
	 <Pine.LNX.4.58.0501070735000.2272@ppc970.osdl.org>
	 <1105113998.24187.361.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0501070923590.2272@ppc970.osdl.org>
	 <Pine.LNX.4.58.0501070936500.2272@ppc970.osdl.org> <41DEF81B.60905@sun.com>
	 <41DF1F3D.3030006@nortelnetworks.com>
	 <1105220326.24592.98.camel@krustophenia.net>
	 <Pine.LNX.4.58.0501081345440.2386@ppc970.osdl.org>
Content-Type: text/plain
Date: Sat, 08 Jan 2005 17:02:49 -0500
Message-Id: <1105221769.24592.118.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-01-08 at 13:51 -0800, Linus Torvalds wrote:
> 
> On Sat, 8 Jan 2005, Lee Revell wrote:
> > 
> > Many latency critical apps use (tmpfs mounted) FIFO's for IPC; the Linux
> > FIFO being one of the fastest known IPC mechanisms.  Each client in the
> > JACK (http://jackit.sf.net) graph wakes the next one by writing a single
> > byte to a FIFO.  Ardour's GUI, control, and audio threads interact via a
> > similar mechanism.  How would you expect this change to impact the inter
> > thread wakeup latency?  It's confusing when people say "performance",
> > meaning "increased throughput albeit with more latency".  For many
> > people that's a regression.
> 
> I posted the performance numbers in the thread already, and with every
> single throughput number I also talked abotu what the latency difference
> was. So quite frankly, if you were confused, I suspect it was because you
> didn't read them. Tssk, tssk.
> 

How embarassing, I found that message immediately after hitting send.
Looks like a big win.  I'll try the JACK stress test on it just to make
sure.

Lee



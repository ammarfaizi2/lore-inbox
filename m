Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268488AbUILGhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268488AbUILGhK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 02:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268496AbUILGhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 02:37:10 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:23820 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S268488AbUILGhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 02:37:06 -0400
Date: Sun, 12 Sep 2004 08:36:55 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Nigel Kukard <nkukard@lbsd.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: CPU Context corruption
Message-ID: <20040912063655.GB1444@alpha.home.local>
References: <4142DF44.7010900@lbsd.net> <1094906455.21088.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094906455.21088.2.camel@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 11, 2004 at 01:40:55PM +0100, Alan Cox wrote:
> On Sad, 2004-09-11 at 12:19, Nigel Kukard wrote:
> > What does this error mean?
> > 
> > 
> > CPU 0: Machine Check Exception: 0000000000000004
> > Bank 0: 820000001040080F
> > 
> > 
> > I have a Matsonic 9097c motherboard, 2.4Ghz prescott celeron cpu. This 
> > error seems to be random. We have replaced the motherboard & cpu to no 
> > avail.
> 
> It normally indicates a hardware problem. The precise meaning of all the
> bits is in the Intel chip docs (volume 3). If you've swapped the
> mainboard/cpu it might just be bad RAM.

He can also get precise info with Dave Jones' parsemce tool :

    http://www.kernel.org/pub/linux/kernel/people/davej/tools/

It currently says :

	Status: (4) Machine Check in progress.
	Restart IP invalid.
	parsebank(0): 820000001040080f @ 0
		External tag parity error
		CPU state corrupt. Restart not possible
		Bus and interconnect error
		Participation: Local processor originated request
		Timeout: Request did not timeout
		Request: Generic error
		Transaction type : Invalid
		Memory/IO : Other

Since it says it's neither memory nor I/O, I think it might be related to
a PCI parity error with some card, either during transfers or config access.

Regards,
Willy


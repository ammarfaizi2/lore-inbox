Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262648AbVDPFxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262648AbVDPFxQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 01:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262650AbVDPFxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 01:53:16 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:48648 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262648AbVDPFxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 01:53:11 -0400
Date: Sat, 16 Apr 2005 07:53:05 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Karl Kiniger <karl.kiniger@med.ge.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.30 Oops when connecting external USB hard drive
Message-ID: <20050416055305.GG7858@alpha.home.local>
References: <20050412173911.GA21311@wszip-kinigka.euro.med.ge.com> <20050414050243.GF7858@alpha.home.local> <20050415125048.GA21076@wszip-kinigka.euro.med.ge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050415125048.GA21076@wszip-kinigka.euro.med.ge.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2005 at 02:50:48PM +0200, Karl Kiniger wrote:
> On Thu, Apr 14, 2005 at 07:02:44AM +0200, Willy Tarreau wrote:
> > You may try to unload the ehci-hcd driver and load only uhci and check if
> > it still happens. I guess from the trace that the problem lies in the ehci
> > driver itself.
> 
> Your guess is right. With only uhci loaded it works (dog slow of course).
> When I then insmod the ehci-hcd driver: instant Oops.
> 
> Today I tried with another USB 2.0 enclosure w/o crash - it seems
> to dislike especially the Seagate enclosure.

Fine, it may not be an important bug.

> perhaps the output of cat /proc/bus/usb/devices gives some hint?
> (BTW: what does the asterisk in the 'C:' lines mean?)

I don't remember at all...

> On the two "GE Med. Kretz" USB<>IDE devices there is 
> a DVD recorder and a Maxtor HD connected, both are working fine
> as long as nobody tries to plug in this particular Seagate.
> 
> What to do next? I have no clue about the innards of ehci-hcd....

You should CC the ehci-hcd the usb-storage maintainers, they probably
will have more clues or ideas about what you encounter. A post to the
linux-usb-users list would be a good idea too. Also, if you can test
2.6 and find that it is broken only on 2.4, it will be easier for them
to send you some code to try.

Regards,
Willy


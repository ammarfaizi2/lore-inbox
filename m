Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbUDCGG4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 01:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbUDCGG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 01:06:56 -0500
Received: from c3p0.cc.swin.edu.au ([136.186.1.30]:37132 "EHLO swin.edu.au")
	by vger.kernel.org with ESMTP id S261611AbUDCGGy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 01:06:54 -0500
To: linux-kernel@vger.kernel.org
From: Tim Connors <tconnors+linuxkernel1080972247@astro.swin.edu.au>
Subject: Re:  solved (was Re: xterm scrolling speed - scheduling weirdness in 	2.6 ?!)
In-reply-to: <slrn-0.9.7.4-9426-9838-200404031530-tc@hexane.ssi.swin.edu.au>
References: <1073227359.6075.284.camel@nosferatu.lan>  <20040104225827.39142.qmail@web40613.mail.yahoo.com>  <20040104233312.GA649@alpha.home.local>  <20040104234703.GY1882@matchmail.com>  <1073296227.8535.34.camel@tiger> <1080930132.1720.38.camel@localhost> <slrn-0.9.7.4-9426-9838-200404031530-tc@hexane.ssi.swin.edu.au>
X-Face: A>QmH)/u`[d}b.a5?Xq=L&d?Q}cF5x|wu#O_mAK83d(Tw,BjxX[}n4<13.e$"d!Gg(I%n8fL)I9fZ$0,8s3_5>iI]4c%FXg{CpVhuIuyI,W'!5Cl?5M,dL-*dHYs}K9=YQZCN-\2j1S>cU6XPXsQhz$x`M\ZEV}nPw'^jPc41FiwTQZ'g)xNK{2',](o5mrODBHe))
Message-ID: <slrn-0.9.7.4-25410-10302-200404031604-tc@hexane.ssi.swin.edu.au>
Date: Sat, 3 Apr 2004 16:06:52 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Connors <tconnors+linuxkernel1080970205@astro.swin.edu.au> said on Sat, 3 Apr 2004 15:35:29 +1000:
> Soeren Sonnenburg <kernel@nn7.de> said on Fri, 02 Apr 2004 20:22:12 +0200:
> > Ok, there is indeed an issue in the *terminals. As above pointed out
> > buffering the programs output helps. Also a usleep of 5ms in the read
> > loop of the *terms would help.

I forgot to mention that I see other 2.6 scheduler regressions too.

I am on ADSL, and run wwwoffle to cache my www feed. In mozilla,
running through the proxy will quite often crawl - you can see it
displaying tags and words one by one. I have been unable to work out
under what circumstances this is triggered, but it is easily
understood given that mozilla on this box chews CPU (especially when
rendering whilst downloading), as does X. So this is much like the
xterm situation - 2 CPU chewing things, interacting with a third short
lived low CPU job (ls or some wwwoffle fork) that the other two are
relying on (mozilla and xterm directly, X indirectly)

This is my reason for not thinking this is an xterm bug. The scheduler
looks inherently fragile.


To help you work out my datapoint in relation to someone elses, my box
is a 500MHz AMD KII, now running 2.6.4. The video card is in no way
accelarated (crappy old nvidia card), so X likes to chew CPU easily.





-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/
Cult: (n) a small, unpopular religion.
Religion: (n) a large, popular cult.

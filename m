Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268224AbUH2RZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268224AbUH2RZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 13:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268230AbUH2RZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 13:25:29 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:2826 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S268224AbUH2RYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 13:24:01 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: "Rafael J. Wysocki" <rjw@sisk.pl>, gene.heskett@verizon.net,
       linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Date: Sun, 29 Aug 2004 20:23:34 +0300
User-Agent: KMail/1.5.4
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408290948.47890.gene.heskett@verizon.net> <200408291721.13192.rjw@sisk.pl>
In-Reply-To: <200408291721.13192.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408292023.34004.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I think, based on the last 25 hours of running both memburn and
> > setiathome at a -nice 19, and there have been no errors, that I might
> > have stumbled onto a fix.
> >
> > It seems the dram is marked DDR400, so I was trying to run it that
> > way.  Unforch, on checking the invoice for the umpteenth time, it
> > finally dawned on me that this particular AMD 2800XP is supposedly a
> > 333mhz FSB chip, and not rated for use with DDR400 memory.  Switching
> > the bios setting for the memory to 'auto' from 'spd' seems to effect
> > this particular item, and the memory now signs in as DDR333 Dual
> > Channel.
> >
> > And after 25 hours, no errors, nothing unusual in the logs.
> >
> > I guess I should go paint my face with egg or something...
>
> Not necessarily.  :-)  Some mobos based on the nforce2 chipsets should be
> able to clock FSB and memory asynchronously.   The very fact that you can
> set the memory clock separately in the BIOS indicates that your mobo is one
> of these. So, if it runs well at synchronous FSB and memory clock rates,
> but causes problems otherwise, the northbridge is probably fishy.  Or the
> memory is not up to the spec.  Anyway, the symptoms are quite "interesting"
> and it's good to know what they are.

The best thing is, we got another RAM test program which seems to be better
than memtest86 in some cases!
--
vda


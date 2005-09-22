Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750849AbVIVEAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbVIVEAV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 00:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbVIVEAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 00:00:21 -0400
Received: from smtp114.sbc.mail.re2.yahoo.com ([68.142.229.91]:22173 "HELO
	smtp114.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750813AbVIVEAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 00:00:20 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.14-rc1-mm1.5 - keyboard wierdness
Date: Wed, 21 Sep 2005 23:00:17 -0500
User-Agent: KMail/1.8.2
Cc: Valdis.Kletnieks@vt.edu
References: <200509220335.j8M3ZGEJ004230@turing-police.cc.vt.edu>
In-Reply-To: <200509220335.j8M3ZGEJ004230@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509212300.17740.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 September 2005 22:35, Valdis.Kletnieks@vt.edu wrote:
> I've had this happen twice now, running Andrew's "not quite -mm2" patch.
> 
> Symptoms: After about 20-30 minutes uptime, a running gkrellm shows system mode
> suddenly shoot up to 99-100%, and the keyboard dies.  Oddly enough, a USB mouse
> continued working, and the X server was still quite responsive (I was able to
> close Firefox by opening a menu with the mouse and selecting 'quit', for
> example).
> 
> alt-sysrq-foo still worked, but ctl-alt-N to switch virtual consoles didn't.
> sysrq-t produced a trace with nothing obviously odd - klogd, syslog, and the
> disk were all working.
> 
> Nothing interesting in the syslog - no oops, bug, etc..
> 
> Another odd data point (I didn't notice if this part happened the first time):
> gkrellm reported that link ppp0 had inbound packets on the modem port of a
> Xircom ethernet/modem combo card.  At the rate of 3.5M/second - a neat trick
> for a 56K modem.  When I unplugged the RJ-11, gkrellm *kept* reporting the
> inbound traffic.  When I ejected the card, *then* the ppp0 (and the alleged
> inbound packets) stopped - but still sitting at 99% system and no keyboard.
> 
> This ring any bells?  Any suggestions for instrumentation to help debug this?
> 

I have seen this couple of times when I would eject my prism54 card at
a "bad" time - my card sometimes gets stuck (a known problem with some
prism54 cards) and if I would eject it "too early" I would lose keyboard.
So I wait till it complain: 

	prism54: Your card/socket may be faulty, or IRQ line too busy :(

and eject and insert it again and all is fine.

-- 
Dmitry

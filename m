Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265588AbUAZXuX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 18:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265585AbUAZXuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 18:50:18 -0500
Received: from mail.tmr.com ([216.238.38.203]:32266 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S265592AbUAZXrH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 18:47:07 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: 2.6.2-rc in BK: Oops loading parport_pc.
Date: 26 Jan 2004 23:46:46 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bv48t6$71r$1@gatekeeper.tmr.com>
References: <20040125115129.GA10387@merlin.emma.line.org> <20040125151454.70b5011e.akpm@osdl.org> <20040126010832.GA5462@merlin.emma.line.org>
X-Trace: gatekeeper.tmr.com 1075160806 7227 192.168.12.62 (26 Jan 2004 23:46:46 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20040126010832.GA5462@merlin.emma.line.org>,
Matthias Andree  <matthias.andree@gmx.de> wrote:
| On Sun, 25 Jan 2004, Andrew Morton wrote:
| 
| > Matthias Andree <matthias.andree@gmx.de> wrote:
| > >
| > >  Loading the parport_pc modules crashes in 2.6.2-rc; I have recently done
| > >  a "bk pull" and enabled some PNP options, among them ISA PNP.
| > 
| > Often this is because some other, unrelated module left things registered
| > after it was removed.  Or otherwise wrecked shared data structures.
| 
| The breakage is somehow related to CONFIG_PNP. I set that option to N,
| ran "make oldconfig ; make", installed the kernel, rebooted, problem
| gone.

2.6.2-rc2:
  root> grep PNP .config
  CONFIG_PNP=y
  CONFIG_PNP_DEBUG=y
  CONFIG_ISAPNP=y
  CONFIG_PNPBIOS=y
  # CONFIG_BLK_DEV_IDEPNP is not set
  CONFIG_IP_PNP=y
  CONFIG_IP_PNP_DHCP=y
  CONFIG_IP_PNP_BOOTP=y
  CONFIG_IP_PNP_RARP=y

Boots and loads parport_pc just fine, so it looks as if either it got
fixed (likely) or other evildoers are at work.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

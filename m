Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263040AbUFJVDF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263040AbUFJVDF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 17:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263028AbUFJVDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 17:03:05 -0400
Received: from fw.osdl.org ([65.172.181.6]:48874 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263040AbUFJVCT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 17:02:19 -0400
Date: Thu, 10 Jun 2004 14:00:44 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: linux-kernel@vger.kernel.org, moilanen@austin.ibm.com
Subject: Re: [PATCH][RFC] Spinlock-timeout
Message-Id: <20040610140044.386c0553.rddunlap@osdl.org>
In-Reply-To: <20040610192430.GJ20632@lug-owl.de>
References: <1086467486.20906.59.camel@dhcp-client215.upt.austin.ibm.com>
	<20040605205117.GD20632@lug-owl.de>
	<1086893091.3476.37.camel@dyn95394175.austin.ibm.com>
	<20040610192430.GJ20632@lug-owl.de>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jun 2004 21:24:30 +0200 Jan-Benedict Glaw wrote:

| On Thu, 2004-06-10 13:44:52 -0500, Jake Moilanen <moilanen@austin.ibm.com>
| wrote in message <1086893091.3476.37.camel@dyn95394175.austin.ibm.com>:
| > On Sat, 2004-06-05 at 15:51, Jan-Benedict Glaw wrote:
| > > On Sat, 2004-06-05 15:31:26 -0500, Jake Moilanen <moilanen@austin.ibm.com>
| > > wrote in message <1086467486.20906.59.camel@dhcp-client215.upt.austin.ibm.com>:
| > > > Here's a patch that will BUG() when a spinlock is held for longer then X
| > > > seconds.  It is useful for catching deadlocks since not all archs have a
| > > > NMI watchdog.  
| > > I like the idea. However, I don't like touching all arch's Kconfig
| > > files. I think it's better to either put this into ./lib/Kconfig (well,
| > > doesn't really fit there), ot (even better:) put it into the Debug
| > > Kconfig file.
| > 
| > I think you're right that lib/Kconfig would not be the right place, but
| > I don't think there is a debug Kconfig.  I tried keeping the Kconfig
| 
| Not yet:) Somebody is working towards getting all the different debug
| options into a central Kconfig file. This was on LKML some four weeks
| ago...
| 
| > additions w/ CONFIG_DEBUG_SPINLOCK.  The other option is to make a debug
| > Kconfig, but every arch seems pretty different in what they have for
| > their debug section.
| 
| As I said, it's been worked on:)

Yes, I'll make a new version soon....

--
~Randy

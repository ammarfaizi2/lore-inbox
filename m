Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262094AbTKNWLv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 17:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbTKNWLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 17:11:51 -0500
Received: from fw.osdl.org ([65.172.181.6]:16525 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262094AbTKNWLu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 17:11:50 -0500
Date: Fri, 14 Nov 2003 14:07:03 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: why no Kconfig in "kernel" subdir?
Message-Id: <20031114140703.0ce36149.rddunlap@osdl.org>
In-Reply-To: <3FB54A62.6020601@nortelnetworks.com>
References: <3FB50B4D.1000300@nortelnetworks.com>
	<20031114092319.5260bd01.rddunlap@osdl.org>
	<3FB54A62.6020601@nortelnetworks.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Nov 2003 16:34:26 -0500 Chris Friesen <cfriesen@nortelnetworks.com> wrote:

| Randy.Dunlap wrote:
| 
| 
| > I consider PREEMPT and SMP arch-specific, not generic.
| 
| Interesting.  Might I ask why?  I thought that most of PREEMPT was 
| pretty arch-neutral.

Right, most of it is arch-neutral.
It appears that PA-RISC doesn't support PREEMPT:

include/asm-parisc/hardirq.h:
#ifdef CONFIG_PREEMPT
# error CONFIG_PREEMT currently not supported.
  [complete with typo]

and UML doesn't support PREEMPT either.


| > Will init/Kconfig do what you want?
| 
| As long as there is some place to put generic options that are 
| applicable to the system as a whole, then I'm happy.

I expect that it's workable.

--
~Randy
MOTD:  Always include version info.

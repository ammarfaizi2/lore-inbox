Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262473AbUDOVqi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 17:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbUDOVqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 17:46:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:17874 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262473AbUDOVqg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 17:46:36 -0400
Date: Thu, 15 Apr 2004 14:41:26 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>
Cc: linux-kernel@vger.kernel.org, mpm@selenic.com, jgarzik@pobox.com,
       akpm@osdl.org
Subject: Re: PATCH] Kconfig.debug family
Message-Id: <20040415144126.702d3480.rddunlap@osdl.org>
In-Reply-To: <200404152336.30621@WOLK>
References: <407CEB91.1080503@pobox.com>
	<20040414212539.GE1175@waste.org>
	<20040415135229.75964100.rddunlap@osdl.org>
	<200404152336.30621@WOLK>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Apr 2004 23:36:30 +0200 Marc-Christian Petersen wrote:

| On Thursday 15 April 2004 22:52, Randy.Dunlap wrote:
| 
| Hi Randy,
| 
| > This patch:
| > - creates lib/Kconfig.debug for generic kernel debug options
| > - creates arch/*/Kconfig.debug for arch-specific debug options
| > - moves KALLSYMS to the generic kernel debug options list
| > This is a first cut for review/comments.  I will double-check
| > the generic options list to see how it needs to be corrected...
| 
| I really appreciate it. But I have one comment/suggestion:
| 
| We might use lib/Kconfig.debug for all arches and use proper "depend on" if 
| there is stuff for some specific arch only. So we have every debug stuff just 
| in one file. What do you think?

Hi Marc,

That sounds like my first version (unposted), which failed IMO.
It looks OK if you/user does not enable viewing all flags/options
(in [xg]config -- I used xconfig).  However, if those options are
enabled, you/user sees all config options for all architectures,
and I didn't find that acceptable.  Feel free to disagree with me
and persuade me otherwise, because having them *all* in
lib/Kconfig.debug is nicer IMO.

The full patch to do this (against 2.6.5-bk2) is now available at:
http://developer.osdl.org/rddunlap/patches/kconfig_debug_265bk2.patch

if you or anyone else wants to compare how they look.

Thanks,
--
~Randy

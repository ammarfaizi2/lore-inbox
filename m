Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422730AbWGNTnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422730AbWGNTnb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 15:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422732AbWGNTnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 15:43:31 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:6621 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1422730AbWGNTna (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 15:43:30 -0400
Subject: i686 hang on boot in userspace
From: john stultz <johnstul@us.ibm.com>
To: Uwe Bugla <uwe.bugla@gmx.de>
Cc: Roman Zippel <zippel@linux-m68k.org>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
In-Reply-To: <20060714150418.120680@gmx.net>
References: <20060714150418.120680@gmx.net>
Content-Type: text/plain; charset=UTF-8
Date: Fri, 14 Jul 2006 12:43:22 -0700
Message-Id: <1152906202.5365.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-14 at 17:04 +0200, Uwe Bugla wrote:
> Hi everybody,
> first of all thanks to the explanatory hints how a magic Sysrq key works – I've learned a lot.
> 
> I first pressed ALT + PrintScreen + P, then ALT + PrintScreen + T.
> To avoid wordwrapping or other unwanted effects please see the resulting kern.log as outline attachment.
> 
> Could someone please explain to me what's behind that cryptic code?
> Hope I could help - still need a booting kernel, and I think I ain´t the only one.

Hmmm... I don't see anything that sticks out in the sysrq info (well,
not sure if the do_wp_page() is just trace junk or not - CC'ed Peter
just in case). Maybe this is related to the expand files OOM thing that
Martin saw?

If you boot w/ init=/bin/bash do you also see the hang? If you execute
"date" a few times, does it seem to keep proper track of time?

Also could you enable softlockup detection? (CONFIG_DETECT_SOFTLOCKUP)
Which you can find under Kernel debugging in the make menuconfig.

thanks
-john


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264275AbTKZRmN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 12:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264277AbTKZRmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 12:42:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:4020 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264275AbTKZRmB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 12:42:01 -0500
Date: Wed, 26 Nov 2003 09:35:43 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Vince <fuzzy77@free.fr>
Cc: zwane@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [kernel panic @ reboot] 2.6.0-test10-mm1
Message-Id: <20031126093543.6b249c01.rddunlap@osdl.org>
In-Reply-To: <3FC4E42A.40906@free.fr>
References: <3FC4DA17.4000608@free.fr>
	<Pine.LNX.4.58.0311261213510.1683@montezuma.fsmlabs.com>
	<3FC4E42A.40906@free.fr>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Nov 2003 18:34:34 +0100 Vince <fuzzy77@free.fr> wrote:

| Zwane Mwaikambo wrote:
| > On Wed, 26 Nov 2003, Vince wrote:
| > 
| > <4>Oops: 0000 [#49]
| > 
| > At the point you're at there really isn't much state left to work from.
| > Any chance you can get at the logs (if it hit disk) and get the first
| > oops?
| > 
| 
| Nothing ever hits the disk (In interrupt handler - not syncing ...), 
| that's the reason why I had to install kmsgdump in the first place.
| (Sidenote: a few days ago, I had the intent to install the lkcd kernel 
| patches, but gave up because of the time required to 
| patch/compile/install/setup correctly the kernel and userspace utilities 
| (not .deb of lkcd-utils available...)).
| I suppose I could enlarge the kernel message log size, but the kmsgdup 
| documentation states:
| ---------------------------------
| If you have changed your messages buffer size (which is 16 kB by 
| default), you should modify the size in "include/asm/kmsgdump.h", 
| parameter LOG_BUF_LEN. Some people required 32 kB. But you shouldn't 
| exceed 60 kB since the dump is done in real mode (16 bits).
| For kernel versions 2.5.6x and later, the LOG_BUF_LEN parameter is part
| of the kernel .config file (LOG_BUF_SHIFT) so you don't need to modify
| it at all.
| ---------------------------------
| 
| ...so I you think 60kB would be enough to catch the first oops -- or if 
| the doc is outdated -- I can try this...

wow... ooops.  a kmsgdump user.  :)

No, the doc is not outdated, and since the log buf size must be a
power of 2, 32 KB is the largest that is currently supported.
Sorry about that.

--
~Randy
MOTD:  Always include version info.

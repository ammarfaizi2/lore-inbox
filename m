Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132735AbRDDCdU>; Tue, 3 Apr 2001 22:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132736AbRDDCdL>; Tue, 3 Apr 2001 22:33:11 -0400
Received: from 069up090.chartermi.net ([24.247.69.90]:8832 "EHLO
	oof.netnation.com") by vger.kernel.org with ESMTP
	id <S132735AbRDDCdE>; Tue, 3 Apr 2001 22:33:04 -0400
Date: Tue, 3 Apr 2001 22:32:23 -0400
From: Simon Kirby <sim@netnation.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.3 freeze under heavy writing + open rxvt
Message-ID: <20010403223222.A669@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Three times now I've had 2.4.3 freeze on my dual CPU box while doing a
"dd if=/dev/zero of=/dev/hdc bs=1024k" (a drive to be RMA'd :)).  I got
bored and opened an rxvt, and as the machine was swapping in (I assume),
everything froze.  The mouse still moved for about 5 seconds before the
freeze, and the window was visible as it was attempting to start tcsh.

I'm guessing that what's happening is something is waiting on a lock and
blocking interrupts (?) for five seconds while it is swapping in, and the
NMI lockup detector is kicking in and really breaking it.

I have my serial console plugged in and minicom actually capturing now,
so I'll see if I can get a trace of some sort.

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266987AbTBCTIY>; Mon, 3 Feb 2003 14:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266986AbTBCTIY>; Mon, 3 Feb 2003 14:08:24 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:48316 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S266987AbTBCTIX>;
	Mon, 3 Feb 2003 14:08:23 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15934.49235.619101.789799@harpo.it.uu.se>
Date: Mon, 3 Feb 2003 20:17:39 +0100
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org, jt@hpl.hp.com
Subject: Re: two x86_64 fixes for 2.4.21-pre3
In-Reply-To: <20030129162824.GA4773@wotan.suse.de>
References: <15921.37163.139583.74988@harpo.it.uu.se>
	<20030124193721.GA24876@wotan.suse.de>
	<15926.60767.451098.218188@harpo.it.uu.se>
	<20030128212753.GA29191@wotan.suse.de>
	<15927.62893.336010.363817@harpo.it.uu.se>
	<20030129162824.GA4773@wotan.suse.de>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen writes:
 > > 1. One unknown ioctl is logged from RH8.0 init:
 > > 
 > > ioctl32(iwconfig:185): Unknown cmd fd(3) cmd(00008b01){00} arg(ffffda90) on socket:[389]
 > 
 > Probably harmless, but if you figure it out please send me a patch.

The ioctl is SIOCGIWNAME, which is used by iwconfig from the wireless-tools
package to check if a given net dev is a wireless thing or not (called from
ifup in RedHat as a type test on the net dev).

Unfortunately, include/linux/wireless.h has a big pile of ioctls and arg/res
types that would need to be checked, so I'll defer this to Jean Tourrilhes (cc:d).

/Mikael

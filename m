Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271214AbRICEZW>; Mon, 3 Sep 2001 00:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271246AbRICEZO>; Mon, 3 Sep 2001 00:25:14 -0400
Received: from OSTRICH.RES.CMU.EDU ([128.2.151.162]:45064 "HELO
	ostrich.res.cmu.edu") by vger.kernel.org with SMTP
	id <S271230AbRICEY7>; Mon, 3 Sep 2001 00:24:59 -0400
Date: Mon, 3 Sep 2001 00:25:18 -0400
From: Benjamin Gilbert <bgilbert@backtick.net>
To: linux-kernel@vger.kernel.org
Subject: matroxfb problems with dualhead G400
Message-ID: <20010903002518.A12008@ostrich.andrew.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been trying to set up dualhead text console with matroxfb and a
16MB G400, with mixed success.  What I think I'm seeing is that the
scrollback from the primary head, when it gets long enough (i.e., cat
/boot/System.map), intrudes on the secondary head.  If the secondary
head is set to the same resolution and bit depth as the primary, I
can (sometimes) actually see the scrollback text go by on the
secondary.  The rest of the time, I just get garbage on the
secondary.  Scrolling text on the second head, OTOH, does not affect
the primary head.  Occasionally, scrolling text on the primary head
will cause a kernel oops, although this isn't consistent; it happens
less than 25% of the time.

I've tried various combinations of video resolutions and matroxfb
boot-time options, but haven't really determined anything conclusive. 
The problem lasts from boot until the first time that the fbdev
resolution is changed on the primary monitor; then the problem goes
away.  This seems to be true regardless of the initial resolution of
the primary monitor.  Setting "video=matroxfb:nopan" makes the
problem rarer, but it still seems to pop up occasionally -- I oopsed
once while testing this.

All of this is before starting XFree86, so X isn't a factor here.

Kernel is vanilla 2.4.9.  Let me know what other information you need
from me.

Thanks in advance
--Benjamin Gilbert

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276973AbRJHP6r>; Mon, 8 Oct 2001 11:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276968AbRJHP6g>; Mon, 8 Oct 2001 11:58:36 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:14090 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S276966AbRJHP63>; Mon, 8 Oct 2001 11:58:29 -0400
Date: Mon, 8 Oct 2001 11:54:00 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: linux-kernel@vger.kernel.org
Subject: Breaking system configuration in stable kernels
Message-ID: <Pine.LNX.3.96.1011008113808.27023A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  I've beaten this dead horse before, but Linux will not look to
management like a viable candidate for default o/s until whoever releases
new versions of *stable* kernel series with cosmetic changes which break
existing systems running earlier releases of the same stable kernel
series.

  The last time I complained, it was about changing the name of a module
itself, this time the names of the parameters of modules have been
changed. Couldn't that have waited for 2.5, or for-bloody-ever? The names
of the parameters to the cmpci module were changed, for example from
"fm_io" to "fmio" which prevents the module from loading with a newer
kernel. And if the "options" line in modules.conf is changed, then it
won't load with older kernels. Maybe I'm to only one who has to roll back
out of a new release?

  This is serious, because the module can't be loaded by hand if
modules.conf has invalid parameters. So loading would have to be moved to
rc.local, and done with correct parameters, which eliminates demand
loading of the module. PITA when sound is only loaded to play a message to
the operator to change the backup media.

  I love getting problems like this on my vacation, I'm pissed, and I
really think it indicates a lack of attention to detail. I think I saw
this in another module while doing a quick diff and grep, but it should be
in any modules. Cosmetic changes which impact users can wait, even
including fixes in spelling in error messages, since people *do* grep logs
for them. Grrr!

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.


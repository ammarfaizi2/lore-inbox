Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261460AbUKIKBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbUKIKBS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 05:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbUKIKBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 05:01:18 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:43494 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261460AbUKIKAl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 05:00:41 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 9 Nov 2004 10:46:48 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: video4linux-list@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] drivers/media/video/ cleanups
Message-ID: <20041109094648.GB5587@bytesex>
References: <20041107175017.GP14308@stusta.de> <20041108114008.GB20607@bytesex> <20041109004341.GO15077@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041109004341.GO15077@stusta.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> OK, the patches follow as followups to this mail.

Thanks, I'll look through that when preparing my next patch set.
Will take some time through as I've just pushed updates and also
will be offline for a week soon.

> > moment automatically is useless.  cx88_risc_disasm() for example is
> > useful for debugging the driver.  And that there is no in-kernel user
> 
> But couldn't this be #if 0'ed?

Yes, it could.

> BTW: Can't lirc be included in the main kernel?

I don't care, the lirc people should, I already have to many projects
for my time.

Last time I checked the code was in a pretty bad state, it needs a
major overhaul IMHO before it can be included.  Lots of historical
cruft (dates back to 2.2 days), parts are not SMP save, ...

At least for the TV cards I prefeare to use the linux input layer
instead, see the ir-kbd-* drivers.  They didn't catch up yet with
lirc on supported hardware through, so I don't want break lirc now.

But the stuff in bttv-if.c is obsolete and I plan to drop that
altogether some day, see the comment about that in bttv.h.  Given that
there will be no 2.7 in near future due to the new devel model I maybe
should make that a time bomb instead ...

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)

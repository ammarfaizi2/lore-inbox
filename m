Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262544AbTHZDwU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 23:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262537AbTHZDwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 23:52:20 -0400
Received: from smtp1.clear.net.nz ([203.97.33.27]:8695 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S262544AbTHZDwS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 23:52:18 -0400
Date: Tue, 26 Aug 2003 15:45:52 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: 2.4.22 hangs with pcmcia and linux-wlan
In-reply-to: <Pine.LNX.4.21.0308252234010.25458-100000@linux08.ece.utexas.edu>
To: "Hmamouche, Youssef" <youssef@ece.utexas.edu>
Cc: Christian Hesse <news@earthworm.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1061869538.2790.9.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <Pine.LNX.4.21.0308252234010.25458-100000@linux08.ece.utexas.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Similar results here, except I can be more specific. I see the issue
using pcmcia only. The package I'm using is the
external-to-the-kernel-tree pcmcia-cs-3.2.3. Under 2.4.22, I get a
complete freeze (no SysRq, no flashing cursor) when I insmod i82365.o. I
tried recompiling the whole kernel & modules using gcc 2.96 and 3.2 to
no avail.  If I use the kernel tree's code, I can insmod okay, but my
ltmodem_cs driver reports the modem as being busy all the time. The
problem was fixed by reverting to 2.4.21 (I'd already deleted pre2,
which was working). No configuration changes required - just a
recompile.

Regards,

Nigel

On Tue, 2003-08-26 at 15:37, Hmamouche, Youssef wrote:
> Out of curiosity, what happens when you remove the card? Does the system
> come back to normal or does it stay in the same state?
> 
> Youssef
> 
> On Tue, 26 Aug 2003, Christian Hesse wrote:
> 
> > Hi,
> > 
> > I'm running kernels with pcmcia-cs-3.2.4 and linux-wlan-ng-0.2.1-pre11 (also 
> > tried 0.2). With 2.4.22-rc3 to final the system hangs if I insert my LevelOne 
> > WPC-0100 (Prism-II-base wlan), no output at all. Everything worked well up to 
> > and including 2.4.22-rc2.
> > 
> > Regards,
> >   Christian
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

You see, at just the right time, when we were still powerless,
Christ died for the ungodly.
	-- Romans 5:6, NIV.


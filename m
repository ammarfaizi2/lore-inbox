Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271007AbTHGVje (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 17:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271021AbTHGVje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 17:39:34 -0400
Received: from smtp2.clear.net.nz ([203.97.37.27]:46759 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S271007AbTHGVjd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 17:39:33 -0400
Date: Fri, 08 Aug 2003 09:38:59 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: [Linux-fbdev-devel] [PATCH] Framebuffer: 2nd try: client
	notification mecanism & PM
In-reply-to: <1060263168.593.77.camel@gaston>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Pavel Machek <pavel@suse.cz>, James Simmons <jsimmons@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Pavel Machek <pavel@ucw.cz>
Message-id: <1060292180.3507.27.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <Pine.LNX.4.44.0308070000540.17315-100000@phoenix.infradead.org>
 <1060249101.1077.67.camel@gaston> <20030807100309.GB166@elf.ucw.cz>
 <1060263168.593.77.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Would this play well with the suspend process itself displaying output?
(Eg progress, errors...).

Regards,

Nigel

On Fri, 2003-08-08 at 01:32, Benjamin Herrenschmidt wrote:
> On Thu, 2003-08-07 at 12:03, Pavel Machek wrote:
> 
> > I believe solution to this is simple: always switch to kernel-owned
> > console during suspend. (swsusp does it, there's patch for S3 to do
> > the same). That way, Xfree (or qtopia or whoever) should clean up
> > after themselves and leave the console to the kernel. (See
> > kernel/power/console.c)
> 
> I admit I quite like this solution. It would also help displaying
> something sane (blank, pattern, whatever) on screen during driver
> teardown instead of the junk left by X...
> 
> I'll look into including that switch into my pmac code as well
> and see if it works properly in all cases (I think so). Also,
> recent DRI CVS finally has working suspend/resume (works on
> console switch too).
> 
> Ben.
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


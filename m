Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262152AbTJST1I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 15:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262187AbTJST1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 15:27:08 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:7848 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262190AbTJST1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 15:27:04 -0400
Date: Sun, 19 Oct 2003 21:27:03 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Aviram Jenik <aviram@beyondsecurity.com>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [pm] Add error handling to software_suspend
Message-ID: <20031019192702.GB12886@atrey.karlin.mff.cuni.cz>
References: <20031018210705.GA22191@elf.ucw.cz> <200310192119.19446.aviram@beyondsecurity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310192119.19446.aviram@beyondsecurity.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This adds error handling to software_suspend(), 
> 
> Suspending to disk with this patch applied I can see the resume is stuck on:
> "Waiting for DMAs to settle down..."
> (previously it booted before I could see where the problem is).
> 
> I guess it's another evidence that the problem is with the i830
> module?

I don't think so. Waiting for DMAs is gross hack where we sleep with
interrupts disabled -- waiting for any running DMAs to end / timeout
/etc.

You might want to add some more debug printks....
				Pavel 


-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261273AbUKWOwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbUKWOwI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 09:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbUKWOwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 09:52:08 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:42180 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261273AbUKWOv6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 09:51:58 -0500
Date: Tue, 23 Nov 2004 15:51:13 +0100
From: Jens Axboe <axboe@suse.de>
To: Alan Chandler <alan@chandlerfamily.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide-cd problem
Message-ID: <20041123145112.GC13174@suse.de>
References: <200411201842.15091.alan@chandlerfamily.org.uk> <200411221919.32174.alan@chandlerfamily.org.uk> <200411222348.42149.alan@chandlerfamily.org.uk> <200411230713.32013.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411230713.32013.alan@chandlerfamily.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23 2004, Alan Chandler wrote:
> On Monday 22 November 2004 23:48, Alan Chandler wrote:
> ...
> > If I make the delay 600ns it works - I guess my hardware is a little off
> > spec.
> >
> 
> I did a binary chop on the value to find the cut off point between what works 
> and what doesn't.  Its approx 535ns (534 failed, 537 worked).
> 
> All this was with 2.6.9, 
> 
> 2.6.10-rc2 is still failing during the cd initialisation on boot.  Here I 
> tried with bot 600ns and 700ns delays in drive_is_ready, but both values fail 
> with what looks like missed interrupts.  I'll try instrumenting this a bit 
> more to find out what is happening.

It's getting more and more interesting! Look forward to hearing what
your instrumentation brings.

There are other reports of acpi causing interrupt problems with cdroms
in 2.6.10-rc2, so it would be best if you stuck to 2.6.9 for testing
this particular problem.

-- 
Jens Axboe


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264271AbUFKQ4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264271AbUFKQ4r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 12:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264235AbUFKQ4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 12:56:15 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:31211 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264238AbUFKQzB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 12:55:01 -0400
Date: Fri, 11 Jun 2004 18:54:39 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>,
       linux-kernel@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Ed Tomlinson <edt@aei.ca>, Andrew Morton <akpm@osdl.org>
Subject: Re: flush cache range proposal (was Re: ide errors in 7-rc1-mm1 and later)
Message-ID: <20040611165438.GC4309@suse.de>
References: <20040605092447.GB13641@suse.de> <20040606161827.GC28576@bounceswoosh.org> <200406100238.11857.bzolnier@elka.pw.edu.pl> <20040610061141.GD13836@suse.de> <20040610164135.GA2230@bounceswoosh.org> <40C89F4D.4070500@pobox.com> <40C8A241.50608@pobox.com> <20040611075515.GR13836@suse.de> <20040611161701.GB11095@bounceswoosh.org> <40C9DE7F.8040002@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40C9DE7F.8040002@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11 2004, Jeff Garzik wrote:
> Unfortunately, that's not the answer drive guys want to hear, because 
> FUA limits the optimization potential from previous ATA.  ;-)  Maybe 
> drive performance is high enough these days that queued-FUA as a 
> standard mode of operation is tolerable...

Data integrity doesn't come for free. Take a pick :-)

> >If the drive receives a queued barrier write (NCQ or Legacy), it will
> >finish processing all previously-received queued commands and post
> >good status for them, then it will process the barrier operation, post
> >status for that barrier operation, then it will continue processing
> >queued commands in the order received.
> 
> If queued-FUA is out of the question, this seems quite reasonable.  It 
> appears to achieve the commit-block semantics described for barrier 
> operation, AFAICS.

Actually from Linux's point of view, drive may reorder previously
committed requests - just not around the barrier.

-- 
Jens Axboe


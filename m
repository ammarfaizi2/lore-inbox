Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268295AbUHQPrl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268295AbUHQPrl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 11:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268283AbUHQPq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 11:46:26 -0400
Received: from mx1.redhat.com ([66.187.233.31]:25264 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268301AbUHQPe1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 11:34:27 -0400
Date: Tue, 17 Aug 2004 11:33:26 -0400
From: Alan Cox <alan@redhat.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@redhat.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: PATCH: straighten out the IDE layer locking and add hotplug
Message-ID: <20040817153326.GA31746@devserv.devel.redhat.com>
References: <20040815151346.GA13761@devserv.devel.redhat.com> <200408171630.07979.bzolnier@elka.pw.edu.pl> <20040817144604.GA30778@devserv.devel.redhat.com> <200408171705.43974.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408171705.43974.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2004 at 05:05:43PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > You can't unload them in 2.4.
> Really?  That would simplify a lot of considerations...

I wanted to make that work but it proved too interesting in handing the
drive back to legacy

> > We can do it the 2.4-ac way - that works with the locking I think. What
> if you are talking about abusing HDIO_SCAN_HWIF then HELL NO

No I'm talking about the 2.4-ac way - using the bus state stuff which is
currently useless.

> > might be nicer if it works out is to follow the shutdown/suspend code
> > approach so that we actually queue the "unplug" into the command stream.
> 
> and we are back to lack of sysfs integration

Not really. We don't need sysfs to queue a series of command phases and then
drop the drive.

Alan


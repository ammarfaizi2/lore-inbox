Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264340AbTGLLhM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 07:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264768AbTGLLhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 07:37:12 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:2502 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264340AbTGLLhL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 07:37:11 -0400
Date: Sat, 12 Jul 2003 13:51:51 +0200
From: Jens Axboe <axboe@suse.de>
To: Andy Polyakov <appro@fy.chalmers.se>
Cc: linux-kernel@vger.kernel.org, proski@gnu.org
Subject: Re: Regarding drivers/ide/ide-cd.c in 2.5.72
Message-ID: <20030712115151.GP843@suse.de>
References: <3EEF8E2E.5E14946E@fy.chalmers.se> <20030619122010.GL6445@suse.de> <3EF1C4C8.98300966@fy.chalmers.se> <20030619140735.GU6445@suse.de> <3F0EBB05.E90B3DF2@fy.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F0EBB05.E90B3DF2@fy.chalmers.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 11 2003, Andy Polyakov wrote:
> > > > > ... In the nutshell the problem is that [as it is
> > > > > now] every failed SG_IO request is replayed second time without data
> > > > > transfer. ... Suggested patch
> > > > > overcomes this problem by immediately purging the failed SG_IO request
> > > > > from the request queue.
> > > >
> > > > Patch looks fine, care to resend actually trying to follow the style in
> > > > the file in question?
> > >
> > > Revised to my best ability for follow the coding style of file in
> > > question. A:-)
> > 
> > Much better, thanks :)
> 
> And it slipped through again:-( Sharpen up! BTW, the proposed patch

Calm down, I pass the fixes on and sometimes the just fall through the
cracks (and not always just my cracks).

> fixes even http://marc.theaimsgroup.com/?t=105634805100001&r=1&w=2,
> where induced kernel crash occurs upon packet replay. Applicable to
> up to 2.5.75. A.

It looks reasonable, I'm wondering whether the ->ide_dma_off() isn't too
harsh in the first place. But we can look at that later.

-- 
Jens Axboe


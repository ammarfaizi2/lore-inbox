Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264766AbTE1P0n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 11:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264767AbTE1P0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 11:26:43 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:36068 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264766AbTE1P0m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 11:26:42 -0400
Date: Wed, 28 May 2003 17:39:22 +0200
From: Jens Axboe <axboe@suse.de>
To: Chris Mason <mason@suse.com>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Andrew Morton <akpm@digeo.com>, kernel@kolivas.org,
       matthias.mueller@rz.uni-karlsruhe.de, manish@storadinc.com,
       andrea@suse.de, marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Message-ID: <20030528153922.GA845@suse.de>
References: <3ED2DE86.2070406@storadinc.com> <200305281305.44073.m.c.p@wolk-project.de> <20030528042700.47372139.akpm@digeo.com> <200305281331.26959.m.c.p@wolk-project.de> <20030528125312.GV845@suse.de> <3ED4B49A.4050001@gmx.net> <20030528130839.GW845@suse.de> <1054132096.32362.120.camel@tiny.suse.com> <20030528143333.GY845@suse.de> <1054133920.32358.126.camel@tiny.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1054133920.32358.126.camel@tiny.suse.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 28 2003, Chris Mason wrote:
> On Wed, 2003-05-28 at 10:33, Jens Axboe wrote:
> 
> > > On UP boxes it's possible the requests are starving in the drive, SCSI
> > > users should try with the max tags set down to something sensible,
> > > between 8 and 32.
> > > 
> > > IDE people can try lowering the max_kb_per_request paramater in
> > > /proc/ide/<drive>/settings, but this should only affect starvation with
> > > the writeback cache on.
> > > 
> > > I made a patch a while ago that timed how long people spent waiting in
> > > __get_request_wait, it might help us figure out where the starvation is
> > > really happening.
> > 
> > But this seems totally unrelated to the reported problems, we are
> > talking about complete stalls of the mouse. No amount of io starvation
> > should provoke something like that.
> 
> Well, if it wasn't io related starvation, andrew's batch requests patch
> wouldn't change things.  I'm hoping the stats patch will get us some
> numbers to go along with the perceived stalls, almost done merging.

Correction then, it doesn't appear to be starvation in the usual sense.
But you are right, pulling some stats out of the situation would be
nice. I still can't reproduce here.

-- 
Jens Axboe


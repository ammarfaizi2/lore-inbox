Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751744AbWFCRkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751744AbWFCRkb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 13:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751746AbWFCRkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 13:40:31 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:3532 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751744AbWFCRkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 13:40:31 -0400
Subject: Re: [patch] cfq: ioprio inherit rt class
From: Lee Revell <rlrevell@joe-job.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
       ck list <ck@vds.kolivas.org>
In-Reply-To: <200606031010.08794.kernel@kolivas.org>
References: <200605271150.41924.kernel@kolivas.org>
	 <20060602171215.GM4400@suse.de>  <200606031010.08794.kernel@kolivas.org>
Content-Type: text/plain
Date: Sat, 03 Jun 2006 13:40:28 -0400
Message-Id: <1149356428.28744.27.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-06-03 at 10:10 +1000, Con Kolivas wrote:
> On Saturday 03 June 2006 03:12, Jens Axboe wrote:
> > Not sure. RT io needs to be considered carefully, but I guess so does RT
> > CPU scheduling. For now I'd prefer to play it a little safer, and only
> > inheric the priority value and not the class.
> 
> The problem I envisioned with that was that realtime tasks, if they don't 
> specify an io priority (as most current code doesn't), would basically get io 
> priority 4 and have the same proportion as any nice 0 SCHED_NORMAL task 
> whereas -nice tasks automatically are getting better io priority. How about 
> givent them normal class but best priority so they are at least getting the 
> same as nice -20?
> 

Con,

Have you seen RT threads trying to disk IO 'in the wild' or is this a
theoretical concern?  I don't know of any such apps.

Lee


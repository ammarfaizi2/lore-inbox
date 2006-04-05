Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751184AbWDEJTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbWDEJTu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 05:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbWDEJTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 05:19:50 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:47907 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751184AbWDEJTt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 05:19:49 -0400
Date: Wed, 5 Apr 2006 11:20:06 +0200
From: Jens Axboe <axboe@suse.de>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Vishal Patil <vishpat@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: CSCAN I/O scheduler for 2.6.10 kernel
Message-ID: <20060405092006.GA4117@suse.de>
References: <4745278c0603301955w26fea42eid6bcab91c573eaa3@mail.gmail.com> <4745278c0603301958o4c2ed282x3513fdb459d8ec7c@mail.gmail.com> <4432D6D4.2020102@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4432D6D4.2020102@tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04 2006, Bill Davidsen wrote:
> Vishal Patil wrote:
> >Maintain two queues which will be sorted in ascending order using Red
> >Black Trees. When a disk request arrives and if the block number it
> >refers to is greater than the block number of the current request
> >being served add (merge) it to the first sorted queue or else add
> >(merge) it to the second sorted queue. Keep on servicing the requests
> >from the first request queue until it is empty after which switch over
> >to the second queue and now reverse the roles of the two queues.
> >Simple and Sweet. Many thanks for the awesome block I/O layer in the
> >2.6 kernel.
> >
> Why both queues sorting in ascending order? I would think that one 
> should be in descending order, which would reduce the seek distance 
> between the last i/o on one queue and the first on the next.

Then it wouldn't be CSCAN, now would it? :-)

-- 
Jens Axboe


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbWFBRJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbWFBRJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 13:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbWFBRJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 13:09:57 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:37636 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750802AbWFBRJ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 13:09:57 -0400
Date: Fri, 2 Jun 2006 19:12:16 +0200
From: Jens Axboe <axboe@suse.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: ck list <ck@vds.kolivas.org>, linux list <linux-kernel@vger.kernel.org>
Subject: Re: [ck] [patch] cfq: ioprio inherit rt class
Message-ID: <20060602171215.GM4400@suse.de>
References: <200605271150.41924.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605271150.41924.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 27 2006, Con Kolivas wrote:
> Jens, ml
> 
> I was wondering if cfq io priorities should be explicitly set to the realtime 
> class when no io priority is specified from realtime tasks as in the 
> following patch? (rt_task() will need to be modified to suit the PI changes in
> -mm)

Not sure. RT io needs to be considered carefully, but I guess so does RT
CPU scheduling. For now I'd prefer to play it a little safer, and only
inheric the priority value and not the class.

-- 
Jens Axboe


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266619AbTGKHs4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 03:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269813AbTGKHs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 03:48:56 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:34523 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266619AbTGKHsz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 03:48:55 -0400
Date: Fri, 11 Jul 2003 10:03:35 +0200
From: Jens Axboe <axboe@suse.de>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.75 does not boot - TCQ oops
Message-ID: <20030711080335.GD843@suse.de>
References: <200307102251.42787.ivg2@cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307102251.42787.ivg2@cornell.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 10 2003, Ivan Gyurdiev wrote:
> See, 
> 
> http://www.ussg.iu.edu/hypermail/linux/kernel/0307.0/0515.html
> 
> where the bug is described for 2.5.74.
> I got no replies, and the bug persists in 2.5.75 (+bk patches).
> 
> Note:
> The machine boots with TASKFILE on, TCQ is causing the problem.

Looks like IDE using the queue before it has been setup, probably Bart
broke it when he moved the TCQ init around. I'll take a look.

-- 
Jens Axboe


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932454AbWBSXwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbWBSXwI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 18:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbWBSXwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 18:52:08 -0500
Received: from kanga.kvack.org ([66.96.29.28]:39300 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S932455AbWBSXwH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 18:52:07 -0500
Date: Sun, 19 Feb 2006 18:47:13 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Bastian Blank <bastian@waldi.eu.org>,
       Arthur Othieno <apgo@patchbomb.org>, Jean Delvare <khali@linux-fr.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH/RFC] remove duplicate #includes, take II
Message-ID: <20060219234713.GA3192@kvack.org>
References: <20060218145525.GA32618@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060218145525.GA32618@MAIL.13thfloor.at>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 18, 2006 at 03:55:25PM +0100, Herbert Poetzl wrote:
> so if folks want to cherry pick and/or comment on
> the first two categories, please do so, I will
> collect all the feedback and produce a patch to
> get rid of the duplicates later ...

This sort of patch isn't as interesting as actually fixing the mess 
known as include/linux/sched.h and include/linux/sched.h...  Most places 
in the kernel don't actually need the majority of sched.h, just a handful 
of functions like set_task_state().  fs.h is another tangled web of 
dependancies.  I did some experimenting back in the 2.2 days and it was 
possible to cut something like 10-20% off the kernel build time.

That said, it's a big job.

		-ben
-- 
"Ladies and gentlemen, I'm sorry to interrupt, but the police are here 
and they've asked us to stop the party."  Don't Email: <dont@kvack.org>.

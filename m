Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262373AbVCVC7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbVCVC7e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 21:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262544AbVCVC5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 21:57:23 -0500
Received: from fire.osdl.org ([65.172.181.4]:8105 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262558AbVCVC4p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 21:56:45 -0500
Date: Mon, 21 Mar 2005 18:56:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm2 vs audio for kino and tvtime, now 2.6.12-rc1-mm1
Message-Id: <20050321185623.5fb2592c.akpm@osdl.org>
In-Reply-To: <200503212135.07063.gene.heskett@verizon.net>
References: <200503082326.28737.gene.heskett@verizon.net>
	<20050321153728.2f239b49.akpm@osdl.org>
	<200503212135.07063.gene.heskett@verizon.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett <gene.heskett@verizon.net> wrote:
>
> ...
> tvtime works, no audio glitches in the startup.  This is a pcHDTV-3000 
> card, running in Never Twice Same Color mode as yet.
> 
> xsane works normally I believe, doing a preview scan ok.

Whew.

> kino works, but doesn't really want to time share with the much cpu 
> hungrier tvtime, this results a very noticeable lag in the preview 
> video coming in directly from the cameras imager via firewire, and 
> sometimes an outright freeze of 2-3 seconds duration when kmail is 
> makeing a mail fetch run.

Is that unexpected?  Are there other kernels which you found better behaved
in this regard?  There are CPU scheduler changes in -mm, but they're
unlikely to affect UP or small SMP.

> spcagui works once I'd reinstalled the spca50x stuff
> 
> /. pops right up in mozilla-1.7.5, also in firefox
> 
> Those seem to be the main things of interest right now, to me.  
> 
> Anything else I should specifically check on this UP machine?
> 
> As I add content to this message, I am occasionally seeing lags 
> between what I type and its showing up on the screen but its 
> certainly better than 2.6.10 or 11 was by quite a ways.  This is 
> related to the kino lags in that I believe its kmail's net access 
> that is causeing them.

hm, OK.  Is much disk I/O happening during the lags?

> Overall, I don't have any instant squawks Andrew.  Looks good, 
> generally feels good.  Itches might develop later though.  I'm using 
> the cfq scheduler, were there any changes of note there?

Relative to 2.6.121-mm2?  Yes, CFQ underwent radical changes.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266837AbUI0RNO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266837AbUI0RNO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 13:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266833AbUI0RNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 13:13:13 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:6547 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S266813AbUI0RM4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 13:12:56 -0400
Date: Mon, 27 Sep 2004 19:12:53 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: jonathan@jonmasters.org, Lars Marowsky-Bree <lmb@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Thomas Habets <thomas@habets.pp.se>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] oom_pardon, aka don't kill my xlock
Message-ID: <20040927171253.GA9728@MAIL.13thfloor.at>
Mail-Followup-To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	jonathan@jonmasters.org, Lars Marowsky-Bree <lmb@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Thomas Habets <thomas@habets.pp.se>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200409230123.30858.thomas@habets.pp.se> <20040923234520.GA7303@pclin040.win.tue.nl> <1096031971.9791.26.camel@localhost.localdomain> <200409242158.40054.thomas@habets.pp.se> <1096060549.10797.10.camel@localhost.localdomain> <20040927104120.GA30364@logos.cnet> <20040927125441.GG3934@marowsky-bree.de> <35fb2e590409270612524c5fb9@mail.gmail.com> <20040927133554.GD30956@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040927133554.GD30956@logos.cnet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2004 at 10:35:54AM -0300, Marcelo Tosatti wrote:
> On Mon, Sep 27, 2004 at 02:12:26PM +0100, Jon Masters wrote:
> > Hi all,
> > 
> > Just out of interest then...suppose we've got a loopback swap device
> > and that we can extend this by creating a new file or extending
> > somehow the existing one.
> > 
> > What would be wrong with having the page reclaim algorithms use one of
> > the low memory watermarks as a trigger to call in to userspace to
> > extend the swap available if possible? This is probably what Microsoft
> > et al do with their "Windows is extending your virtual memory, yada
> > yada blah blah". Comments? Already done?
> 
> You dont to change kernel code for that - make a script to monitor 
> swap usage, as soon as it gets below a given watermark, you swapon 
> whatever swapfile you want.

hmm, sounds good, but what if next 'burst' of
swapped out data is larger than the watermark?

I'm no friend of the 'extend swap idea' so don't
get me wrong, but userspace can just reduce the
cases where you get out-of-swap, without support
from the kernel side (via some userspace helper)

best,
Herbert

> Makes sense yes.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

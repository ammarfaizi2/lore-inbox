Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266333AbUI0PUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266333AbUI0PUr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 11:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266362AbUI0PUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 11:20:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51344 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266333AbUI0PUp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 11:20:45 -0400
Date: Mon, 27 Sep 2004 10:35:54 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: jonathan@jonmasters.org
Cc: Lars Marowsky-Bree <lmb@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Thomas Habets <thomas@habets.pp.se>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] oom_pardon, aka don't kill my xlock
Message-ID: <20040927133554.GD30956@logos.cnet>
References: <200409230123.30858.thomas@habets.pp.se> <20040923234520.GA7303@pclin040.win.tue.nl> <1096031971.9791.26.camel@localhost.localdomain> <200409242158.40054.thomas@habets.pp.se> <1096060549.10797.10.camel@localhost.localdomain> <20040927104120.GA30364@logos.cnet> <20040927125441.GG3934@marowsky-bree.de> <35fb2e590409270612524c5fb9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35fb2e590409270612524c5fb9@mail.gmail.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2004 at 02:12:26PM +0100, Jon Masters wrote:
> Hi all,
> 
> Just out of interest then...suppose we've got a loopback swap device
> and that we can extend this by creating a new file or extending
> somehow the existing one.
> 
> What would be wrong with having the page reclaim algorithms use one of
> the low memory watermarks as a trigger to call in to userspace to
> extend the swap available if possible? This is probably what Microsoft
> et al do with their "Windows is extending your virtual memory, yada
> yada blah blah". Comments? Already done?

You dont to change kernel code for that - make a script to monitor 
swap usage, as soon as it gets below a given watermark, you swapon 
whatever swapfile you want.

Makes sense yes.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbWDUHdB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbWDUHdB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 03:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbWDUHdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 03:33:01 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:45321 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751271AbWDUHdA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 03:33:00 -0400
Date: Thu, 20 Apr 2006 13:47:14 +0000
From: Pavel Machek <pavel@suse.cz>
To: Hugh Dickins <hugh@veritas.com>
Cc: Jeff Chua <jeffchua@silk.corp.fedex.com>, Jeff Garzik <jeff@garzik.org>,
       Matt Mackall <mpm@selenic.com>, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: sata suspend resume ...
Message-ID: <20060420134713.GA2360@ucw.cz>
References: <Pine.LNX.4.64.0604192324040.29606@indiana.corp.fedex.com> <Pine.LNX.4.64.0604191659230.7660@blonde.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604191659230.7660@blonde.wat.veritas.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> > Any change of getting suspend/resume to work on my IBM X60s notebook.
> > 
> > Disk model is ...
> > 
> > 	MODEL="ATA HTS541060G9SA00"
> > 	FW_REV="MB3I"
> > 
> > Linux 2.6.17-rc2.
> > 
> > System suspends ok. Resume ok. but no disk access after that.
> 
> Not the same disk model, but I've been having similar trouble on a T43p.
> 
> I was delighted to see the MSI suspend/resume fix go into 2.6.17-rc2,
> but then disappointed.  A bisection found that Matt Mackall's sensible
> rc1 patch, to speed up get_cmos_time, has removed what often used to be
> a 2 second delay in resuming: things work well when I reinstate that
> delay (1 second has proved not enough).  Below is the patch I'm using -
> where I've failed to resist mucking around to avoid those double calls
> to get_cmos_time, sorry: really it's just mdelay(2000) needed somewhere
> (until someone who knows puts in something more scientific).
> 
> Your problem, of course, is quite likely to be something else entirely;
> but I thought I ought to speak up, in case it does help.

Could you

1) try if mdelay(2000) also helps?

2) binary-search on drivers to see which one breaks it?

							Pavel
-- 
Thanks, Sharp!

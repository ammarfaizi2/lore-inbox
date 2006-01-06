Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030557AbWAGTQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030557AbWAGTQF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 14:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030563AbWAGTQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 14:16:01 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:60425 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1030554AbWAGTPx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 14:15:53 -0500
Date: Fri, 6 Jan 2006 04:17:54 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Adam Belay <ambx1@neo.rr.com>, Alan Stern <stern@rowland.harvard.edu>,
       Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [patch] pm: fix runtime powermanagement's /sys	interface
Message-ID: <20060106041754.GA2496@ucw.cz>
References: <Pine.LNX.4.50.0601051729400.30092-100000@monsoon.he.net> <Pine.LNX.4.44L0.0601061035090.5127-100000@iolanthe.rowland.org> <20060107000826.GC20399@elf.ucw.cz> <20060107075851.GD3184@neo.rr.com> <20060107102013.GB9225@elf.ucw.cz> <20060107130652.GB3972@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060107130652.GB3972@neo.rr.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Also there's nothing "runtime" about the PCMCIA PM API.  It's much more
> > > like calling ->remove() as it disabled the device all together.  
> > 
> > It looks enough runtime to me.
> 
> As was already discussed, we don't want to modify every userspace
> application to check if the device it needs is "on" (resumed) or
> "off" (suspended).  It's just two painful with third party apps etc.
> Therefore, the kernel needs to handle this more seemlessly.  In my

But we do not want to reactivate device on first access. Certainly not
in PCMCIA case. Reactivation is separate problem.

						Pavel

-- 
Thanks, Sharp!

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751152AbWBTAl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbWBTAl4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 19:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbWBTAl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 19:41:56 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:48270 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751152AbWBTAlz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 19:41:55 -0500
Date: Mon, 20 Feb 2006 01:41:42 +0100
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: greg@kroah.com, torvalds@osdl.org, akpm@osdl.org, linux-pm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-pm] [PATCH 3/5] [pm] Respect the actual device power states in sysfs interface
Message-ID: <20060220004142.GI15608@elf.ucw.cz>
References: <Pine.LNX.4.50.0602171758160.30811-100000@monsoon.he.net> <20060218155543.GE5658@openzaurus.ucw.cz> <Pine.LNX.4.50.0602191557520.8676-100000@monsoon.he.net> <20060220000907.GE15608@elf.ucw.cz> <Pine.LNX.4.50.0602191611130.8676-100000@monsoon.he.net> <20060220002053.GF15608@elf.ucw.cz> <Pine.LNX.4.50.0602191628270.8676-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0602191628270.8676-100000@monsoon.he.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Ne 19-02-06 16:36:34, Patrick Mochel wrote:
> 
> On Mon, 20 Feb 2006, Pavel Machek wrote:
> 
> > On Ne 19-02-06 16:17:01, Patrick Mochel wrote:
> 
> > > I really fail to see what your fundamental objection is. This restores
> > > compatability, makes the core simpler, and adds the ability to use the
> > > additional states, should drivers choose to implement them; all for
> > > relatively little code. It seems a like a good thing to me..
> >
> > Compatibility is already restored.
> 
> No, the interface is currently broken. The driver core does not
> dictate

There were two different interfaces, one accepted 0 and 2, everything
else was invalid, and second accepted 0, 1, 2, 3.

If you enter D2 on echo 2, you are breaking compatibility with 2.6.15
or something like that.

Please let this interface die and create new one. (And notice that
this is exactly same advice you gave me month ago).
								Pavel

-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...

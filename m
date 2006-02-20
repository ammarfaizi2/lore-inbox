Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932500AbWBTB0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbWBTB0V (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 20:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbWBTB0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 20:26:21 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:51466 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S932500AbWBTB0V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 20:26:21 -0500
Date: Mon, 20 Feb 2006 02:26:20 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Phillip Susi <psusi@cfl.rr.com>, Alan Stern <stern@rowland.harvard.edu>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       Alon Bar-Lev <alon.barlev@gmail.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Flames over -- Re: Which is simpler?
Message-ID: <20060220012619.GA27899@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Pavel Machek <pavel@ucw.cz>, Phillip Susi <psusi@cfl.rr.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Kyle Moffett <mrmacman_g4@mac.com>,
	Alon Bar-Lev <alon.barlev@gmail.com>,
	Kernel development list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.0602191138470.9165-100000@netrider.rowland.org> <43F8C464.3000509@cfl.rr.com> <20060219194343.GA15311@elf.ucw.cz> <20060220005617.GB90469@dspnet.fr.eu.org> <20060220010102.GB15965@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220010102.GB15965@elf.ucw.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 02:01:02AM +0100, Pavel Machek wrote:
> Actually, if you really want to do this, it would probably make sense
> to do at blockdevice level -- with device mapper magic or something.
> 
> That way you could prompt user "return that flash driver, I still want
> to write to it" after surprise unplug, etc. And suspend is special
> case of surprise unplug, then replug.

I'm not sure.  Suspend is not a surprise, so you can do things so that
you don't lose anything (what I described is pretty much unmounting
while keeping file references).  Surprise unplug, there is no way you
can make the filesystem clean if it wasn't already.

I also think that USB flash and this kind of things should go back to
clean state as soon as possible even whe mountd, but that's a
different issue.

  OG.


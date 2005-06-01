Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261329AbVFAJLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbVFAJLJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 05:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbVFAJLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 05:11:09 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:34451 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261329AbVFAJLE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 05:11:04 -0400
Date: Wed, 1 Jun 2005 11:06:23 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [RFC] Add some hooks to generic suspend code
Message-ID: <20050601090622.GB6693@elf.ucw.cz>
References: <1117524577.5826.35.camel@gaston> <20050531101344.GB9614@elf.ucw.cz> <1117550660.5826.42.camel@gaston> <20050531212556.GA14968@elf.ucw.cz> <1117582309.5826.60.camel@gaston> <20050601081336.GA6693@elf.ucw.cz> <1117614857.19020.32.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117614857.19020.32.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Why do you need it? Do you initiate suspend without userland asking
> > > > you to?
> > > 
> > > Because there is an existing API, via /dev/apm_bios, and that's all X
> > > understands ! And because I've always done that ;)
> > 
> > Try stopping doing that ;-).
> 
> Certainly not short-term. Again, it would be nice to have something
> better, but heh, you need to go step by step. I have this big rework
> where I re-implement most of the pmac suspend code on top of the generic
> code (cleans up a lot of stuff) but I don't want to touch the userland
> ABI for now, that would be too much of a chance. And /dev/apm_bios X
> notofication stuff seems to actually fix problems for some users.

Ok.

> I'd rather not break an existing and relied upon userland interface now,
> at least not until we have a well accepted replacement that has been
> around for some time.
> 
> I do agree however that it may be nice to make the APM emulation code
> more generic & shared between architectures. That's something I intend
> to look into next. But I would like my current stuff to get in after
> 2.6.12 is released.

Well, but that means that we can get those "please don't use these
callbacks if you can avoid it" messages, right :-).

Seems like lots of stuff is going to happen in pm post-2.6.12: I'd
like to finally fix pm_message_t, too...
								Pavel

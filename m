Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbVIOLQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbVIOLQw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 07:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbVIOLQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 07:16:52 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:32432 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750746AbVIOLQv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 07:16:51 -0400
Date: Thu, 15 Sep 2005 13:16:01 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: Re: [linux-pm] swsusp3: push image reading/writing into userspace
Message-ID: <20050915111601.GF2725@elf.ucw.cz>
References: <20050914223206.GA2376@elf.ucw.cz> <1126749596.3987.5.camel@localhost> <20050915063753.GA2691@elf.ucw.cz> <1126768581.3987.31.camel@localhost> <20050915073744.GA2725@elf.ucw.cz> <1126776726.4452.50.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1126776726.4452.50.camel@localhost>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > You could reclaim it. There are 10 times as many hits (239,000) for
> > > suspend2, and I've never wanted it to be called swsusp2 anyway :). As
> > > for suspend4, at the moment, I'm not planning on ever progressing beyond
> > > 2.x.
> > 
> > Sorry, have to ask...
> > 
> > "not planning on progressing" == version number stays "2" no matter
> > what changes, or "not planning on progressing" == not plan to use
> > swsusp3/uswsusp infrastructure?
> 
> I'm not planning on ever progressing beyond 2.x because I'm seeing the
> code I have now as pretty much feature complete. There are a few small
> areas that I'd like to improve (reinstating module support being one -
> it was a mistake to remove it), but I don't see the need for a complete
> redesign. That said, I was careful to say 'at the moment'. I'm not
> denying for a second that things might change.

Ok.

> Regarding the 'swsusp3/uswsusp infrastructure': as I see it at the
> moment (feel free to correct me), your new revision is only moving as
> much code as you can to userspace (plus changes that are made necessary
> by that). Beyond maybe reducing the kernel size a little, I don't see
> any advantage to that - it just makes things more complicated and
> requires the user to set up more in the way of an initrd or initramfs in
> order to suspend and resume. You end up with more code to maintain to
> get the same functionality (same amount of kernel code or slightly less
> plus extra userland code to do all the reading and writing). I'm

Agreed. OTOH interface code is quite small (~100 lines).

> If the main impetus is seeking to reduce kernel code size, why not just
> provide the option of building your code as a module for those who are
> concerned about that statistic?

It is source code size that I'm concerned about. And flexibility; with
writer in userspace, I (or anyone else :-) can do all kinds of
graphical progress bars, esc-to-cancel, ... that would be too ugly to
do in kernel.
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address

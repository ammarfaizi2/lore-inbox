Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262047AbULPWUi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262047AbULPWUi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 17:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbULPWT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 17:19:27 -0500
Received: from mail.kroah.org ([69.55.234.183]:29351 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262047AbULPWS5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 17:18:57 -0500
Date: Thu, 16 Dec 2004 14:18:43 -0800
From: Greg KH <greg@kroah.com>
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: debugfs in the namespace
Message-ID: <20041216221843.GA10172@kroah.com>
References: <20041216110002.3e0ddf52@lembas.zaitcev.lan> <20041216190835.GE5654@kroah.com> <41C20356.4010900@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41C20356.4010900@sun.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2004 at 04:51:18PM -0500, Mike Waychison wrote:
> I thought debugfs was meant for just debugging.  As there is no plans
> for standardizing its namespace, why are we allowing ourselves to rely
> on it being mounted at all?
> 
> AFAICT, there should be no excuse for userspace to actually rely on any
> of the data within debugfs.  Otherwise we end up with yet another
> filesystem whose role is: Chaotic hodgepodge of magic files created by
> drivers that couldn't bother to be well-organized.
> 
> Please, let's not make debugfs part of userspace.  Keep it for what it
> is, debugging purposes only.

I'm not saying we will ever make it "required" at all.  It's just that
people are going to want to mount the thing, and are already asking me
where we should mount it at.  If you pick a different place than me,
fine, I don't mind.  It's the user who is asked to report some info that
happens to be in debugfs that is going to want to know where to put it,
as they have no idea even what it is.  Distros are going to ask what to
put in their fstabs for where to mount the thing too.

So, let's pick a place and be done with it.

I like /dbg (3 characters total to get to, which is shorter than /debug
which takes at least 4, 3 chars and a tab).  Pete likes /debug.  Jan
Engelhardt want to hide the thing from people at /.debugfs.

Hm, what about /.debug ?  That's a compromise that I can live with (even
less key strokes to get to...)

Or is their some restriction on putting hidden directories in the root
filesystem as specified by the LSB?

So, /.debug sound acceptable?

thanks,

greg k-h

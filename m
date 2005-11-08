Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030368AbVKHV5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030368AbVKHV5Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 16:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030372AbVKHV5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 16:57:16 -0500
Received: from mail.kroah.org ([69.55.234.183]:2280 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030368AbVKHV5P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 16:57:15 -0500
Date: Tue, 8 Nov 2005 13:56:41 -0800
From: Greg KH <greg@kroah.com>
To: "Marco d'Itri" <md@Linux.IT>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: udev on 2.6.14 fails to create /dev/input/event2 on T40 Thinkpad
Message-ID: <20051108215641.GA19289@kroah.com>
References: <E1EYdMs-0001hI-3F@think.thunk.org> <20051106203421.GB2527@kroah.com> <20051107053648.GA7521@thunk.org> <20051107155243.GA14658@kroah.com> <20051107181706.GB8374@thunk.org> <20051107182434.GC18861@kroah.com> <20051108033019.GA6129@thunk.org> <20051108044348.GB5516@kroah.com> <20051108131451.GD6129@thunk.org> <20051108215209.GA24796@wonderland.linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051108215209.GA24796@wonderland.linux.it>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2005 at 10:52:09PM +0100, Marco d'Itri wrote:
> On Nov 08, Theodore Ts'o <tytso@mit.edu> wrote:
> 
> > .. and the Synaptics driver wants to talk to /dev/input/event2, and
> > _not_ /dev/input/event3.  But the Debian scripts seem to think that
> > the only thing of value to expose is the /dev/input/event3, the very
> > top of the stack.  /dev/input/event1, and /dev/input/event2 are both
> > not showing up on my system once a I boot a post-2.6.14 kernel.
> Yes, sure. The current Debian package uses udevsynthesize, which knows
> nothing about what happened post-2.6.14 in sysfs.

Ugh, you don't use 'udevstart'?  Oh well...

Ted, this is a distro issue, not a kernel one.  Marco, you are going to
get a lot of error reports about this once 2.6.15-rc1 is out...

Good luck,

greg k-h

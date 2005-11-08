Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030300AbVKHVwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030300AbVKHVwV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 16:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030313AbVKHVwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 16:52:21 -0500
Received: from attila.bofh.it ([213.92.8.2]:6340 "EHLO attila.bofh.it")
	by vger.kernel.org with ESMTP id S1030300AbVKHVwU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 16:52:20 -0500
Date: Tue, 8 Nov 2005 22:52:09 +0100
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: udev on 2.6.14 fails to create /dev/input/event2 on T40 Thinkpad
Message-ID: <20051108215209.GA24796@wonderland.linux.it>
References: <E1EYdMs-0001hI-3F@think.thunk.org> <20051106203421.GB2527@kroah.com> <20051107053648.GA7521@thunk.org> <20051107155243.GA14658@kroah.com> <20051107181706.GB8374@thunk.org> <20051107182434.GC18861@kroah.com> <20051108033019.GA6129@thunk.org> <20051108044348.GB5516@kroah.com> <20051108131451.GD6129@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051108131451.GD6129@thunk.org>
User-Agent: Mutt/1.5.11
From: md@Linux.IT (Marco d'Itri)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 08, Theodore Ts'o <tytso@mit.edu> wrote:

> .. and the Synaptics driver wants to talk to /dev/input/event2, and
> _not_ /dev/input/event3.  But the Debian scripts seem to think that
> the only thing of value to expose is the /dev/input/event3, the very
> top of the stack.  /dev/input/event1, and /dev/input/event2 are both
> not showing up on my system once a I boot a post-2.6.14 kernel.
Yes, sure. The current Debian package uses udevsynthesize, which knows
nothing about what happened post-2.6.14 in sysfs.

> Great....  I'll file a bug report to Debian, and hopefully they can
> get this mess straightened out before 2.6.15 (and hopefully before
> 2.6.14-rc1) ships.
Not unless you will send me a tested patch for the init script, since I
do not run rc kernels myself.
(Or at least you will help me with some testing.)

-- 
ciao,
Marco

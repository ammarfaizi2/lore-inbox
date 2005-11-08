Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965349AbVKHDaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965349AbVKHDaX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 22:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965357AbVKHDaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 22:30:23 -0500
Received: from thunk.org ([69.25.196.29]:26822 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S965349AbVKHDaW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 22:30:22 -0500
Date: Mon, 7 Nov 2005 22:30:19 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: udev on 2.6.14 fails to create /dev/input/event2 on T40 Thinkpad
Message-ID: <20051108033019.GA6129@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org
References: <E1EYdMs-0001hI-3F@think.thunk.org> <20051106203421.GB2527@kroah.com> <20051107053648.GA7521@thunk.org> <20051107155243.GA14658@kroah.com> <20051107181706.GB8374@thunk.org> <20051107182434.GC18861@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051107182434.GC18861@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 10:24:34AM -0800, Greg KH wrote:
> > from Debian with a post 2.6.14 kernel, and it wasn't working for me.
> 
> I see that 073 is in unstable, which fixed a lot of problems with 071,
> 072 and 073 due to Debian configuration issues.  I suggest you try that.

I've just tried udev 073 from Debian unstable, with a freshly pulled
kernel 2.6.14 from earlier in the evening on 11/7.  Same failure:

/dev/input only has /dev/input/event3, and is missing the event0, event1,
and event2 files that is present if I boot 2.6.14.

So is this a Debian bug, a kernel bug, or a udev bug?  What is going
on?  I don't know enough about recent changes to udev and/or the
events sent to udev to start debugging this, but this is something
that works in 2.6.14 and fails post-2.6.14....  

So this is what I believe Andrew would call "a regression".  :-)

						- Ted

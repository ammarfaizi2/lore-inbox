Return-Path: <linux-kernel-owner+w=401wt.eu-S932738AbWLNOMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932738AbWLNOMj (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 09:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932736AbWLNOMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 09:12:39 -0500
Received: from adelie.ubuntu.com ([82.211.81.139]:53714 "EHLO
	adelie.ubuntu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932738AbWLNOMi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 09:12:38 -0500
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches
	for 2.6.19]
From: Ben Collins <ben.collins@ubuntu.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Greg KH <gregkh@suse.de>,
       Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@osdl.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <4580E37F.8000305@mbligh.org>
References: <20061214003246.GA12162@suse.de> <22299.1166057009@lwn.net>
	 <20061214005532.GA12790@suse.de>
	 <Pine.LNX.4.64.0612131954530.5718@woody.osdl.org>
	 <4580E37F.8000305@mbligh.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 14 Dec 2006 09:12:25 -0500
Message-Id: <1166105545.6748.212.camel@gullible>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-13 at 21:39 -0800, Martin J. Bligh wrote:
> The Ubuntu feisty fawn mess was a dangerous warning bell of where we're
> going. If we don't stand up at some point, and ban binary drivers, we
> will, I fear, end up with an unsustainable ecosystem for Linux when
> binary drivers become pervasive. I don't want to see Linux destroyed
> like that.

Yes, people have been worried about this for years, and to my knowledge,
it seems like things have been getting better with drivers, not worse
(look at Intel). And yet, people want to enforce more and more
restrictions against binary-only drivers, when it appears that we are
already winning.

You can't talk about drivers that don't exist for Linux. Things like
bcm43xx aren't effected by this new restriction for GPL-only drivers.
There's no binary-only driver for it (ndiswrapper doesn't count). If the
hardware vendor doesn't want to write a driver for linux, you can't make
them. You can buy other hardware, but that's about it.

Here's the list of proprietary drivers that are in Ubuntu's restricted
modules package:

	madwifi (closed hal implementation, being replaced in openhal)
	fritz
	ati
	nvidia
	ltmodem (does that even still work?)
	ipw3945d (not a kernel module, but just the daemon)

In over a year that list has only grown by ipw3945d. None of our users
are asking for new proprietary drivers. Believe me, if they needed them,
I'd hear about it. We have more cases of new unsupported hardware than
we do of new hardware with binary-only drivers. This proposed
restriction doesn't fix that.

You know what I think hurts us more than anything? You know what
probably keeps companies from writing drivers or releasing specs? It's
because they know some non-paid kernel hackers out there will eventually
reverse engineer it and write the drivers for them. Free development,
and they didn't even have to release their precious specs.

Don't get me wrong, I'm not bashing reverse engineering, or writing our
own drivers. It's how Linux got started. But the problem isn't as narrow
as people would like to think. And proprietary code isn't a growing
problem. At best, it's just a distraction that will eventually go away
on it's own.

The whole hardware vendor landscape is showing this, and it's not
because we locked down the kernel, it's because we've shown how well we
play with others, and how easy it is to get along with the whole
community. Do we want to destroy this good will?

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932319AbWAVJmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbWAVJmJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 04:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbWAVJmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 04:42:08 -0500
Received: from thunk.org ([69.25.196.29]:10691 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932319AbWAVJmH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 04:42:07 -0500
Date: Sun, 22 Jan 2006 04:41:44 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Michael Loftis <mloftis@wgops.com>
Cc: Bernd Petrovitsch <bernd@firmix.at>, Lee Revell <rlrevell@joe-job.com>,
       Sven-Haegar Koch <haegar@sdinet.de>,
       Matthew Frost <artusemrys@sbcglobal.net>, linux-kernel@vger.kernel.org,
       James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Development tree, PLEASE?
Message-ID: <20060122094144.GB7127@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Michael Loftis <mloftis@wgops.com>,
	Bernd Petrovitsch <bernd@firmix.at>,
	Lee Revell <rlrevell@joe-job.com>,
	Sven-Haegar Koch <haegar@sdinet.de>,
	Matthew Frost <artusemrys@sbcglobal.net>,
	linux-kernel@vger.kernel.org,
	James Courtier-Dutton <James@superbug.co.uk>
References: <20060121031958.98570.qmail@web81905.mail.mud.yahoo.com> <1FA093EB58B02DE48E424157@dhcp-2-206.wgops.com> <1137829140.3241.141.camel@mindpipe> <Pine.LNX.4.64.0601212250020.31384@mercury.sdinet.de> <1137881882.411.23.camel@mindpipe> <3B0BEE012630B9B11D1209E5@dhcp-2-206.wgops.com> <1137883638.411.38.camel@mindpipe> <1137883888.3291.53.camel@gimli.at.home> <4BC1BE8FDDB41AAA7205E258@dhcp-2-206.wgops.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4BC1BE8FDDB41AAA7205E258@dhcp-2-206.wgops.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 22, 2006 at 01:57:19AM -0700, Michael Loftis wrote:
> 
> Yes, I realise all of this.  But everyone seems to get this damned 
> territorial attitude that I want to see kernel development stopped, quite 
> the opposite.  All I want to see is a stable target for certain windows of 
> time.  So that way when bugs are fixed that are trivial there's a place to 
> go without upgrading scads of userland stuff or worrying about lots of 
> unrelated change.

A stable target is trivial; you just don't make any changes to it.
2.6.10 is a stable target. However, the moment you start wanting
security fixes, and support for new hardware, while still having a
"stable target", this is where life gets difficult. 

The disconnect seems to be on how hard this is perceived to be; you
seem to be focusing on the trivial cases, where all you have to do is
add a new PCI ID to a driver's white list, for example.  Everyone else
is focusing on all of the horror stories where in order to support new
hardware, major pieces of core kernel functionality had to be ripped
apart and rearchitected in order to support said new hardware, or the
problems where people only develop a fix to one specific kernel
version, and no one else bothers to forward-port or back-port the fix
to other kernel versions.

Obviously the truth lies somewhere in between these two extremes, but
I think there are some indicators that might tend to show that those
who think you are wrong might have a point.

a) If this was so easy, someone would have done it by now ---
especially those maintaining distro kernels of one kind or another:
i.e., Red Hat, SuSE, Debian, Ubuntu, etc.

b) As a related argument, "if you think this is so easy, why don't you
try it yourself?"

c) We have tried to do it in the past, i.e., with 2.4, and it was
pretty clear that in the long run, it didn't work well at all.

Maybe you think that "certain windows of time" is would make the
problem tractable if it were shorter than 2.4 was in practice, but
longer than the current 2.6.x.y stable series (for example).

I still think that in the long run, if you want to be able to support
new hardware, it is inevitable that you will be disappointed.  Yes
sometimes it only requires a new PCI ID --- until you run into the
time when it requires a major roto-tilling of the main project.

						- Ted

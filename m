Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267939AbUH1Aab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267939AbUH1Aab (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 20:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267867AbUH1AaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 20:30:06 -0400
Received: from jib.isi.edu ([128.9.128.193]:4232 "EHLO jib.isi.edu")
	by vger.kernel.org with ESMTP id S267939AbUH1A2L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 20:28:11 -0400
Date: Fri, 27 Aug 2004 17:28:06 -0700
From: Craig Milo Rogers <rogers@isi.edu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>, greg@kroah.com,
       nemosoft@smcc.demon.nl, linux-usb-devel@lists.sourceforge.net
Subject: PWC: A Plea for Grace
Message-ID: <20040828002806.GH24018@isi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, Greg, Nemosoft, and esteemed members of the mailing lists:

	I plea for a graceful transition.

	Rather than immediately removing the codec registration hook
from the pwc driver, and instantly degrading an up-to-then stable
driver in a now-stable kernel release series, I ask that all concerned
parties consider the following plan:

1)	The pwc codec registration hook will be reinstated in the
	pwc driver, but the driver will be marked "deprecated"
	in appropriate comments, documentation, and perhaps build files.

2)	The deprecated driver will be scheduled to be removed from
	the next Linux kernel major release series (2.7, 2.8, 3.0,
	whatever is next).

	1) This will be a firm deadline, and all involved parties,
	   whether developers or users, will have the opportunity
	   to be cognizant of it, and prepare for its eventual
	   arrival.

3)	A new driver, say pwc2, will be created that will pass the raw
	data stream to user-mode application programs.

	1) Nemosoft's present implementation of raw streams can serve
	   as a baseline implementation.

	2) The final raw stream API will be coordinated with l4v2.

4)	An API and framework will be constructed to allow user-mode
	stream decoding (decompression), with minimum impact on
	application programs, as described in my previous message.

	1) This design should be coordinated with the v4l2 project,
	   and adopted as a standard for v4l2, if there are no serious
	   technical objections to this approach.

5)	A team will be assembled to implement this design.

	1) The team will need to coordinate with, or be a subset of, the
	   v4l2 team.

6)	Coordinating with this, an effort will be made to talk to
	Philips, Logitech, and other concerned manufacturers, and present
	them with a rational business case for allowing the open-source
	implementation of the currently proprietary codecs.

7)	Finally, and admittedly the most fragile link in my proposal,
	the current out-of-the-kernel pwcx (closed-source codec) module
	will continue to be maintained and offered until the transition to
	pwc2 is complete.  Please remember, everyone, that without access
	to the codecs presently embodied in pwcx, the in-kernel pwc driver
	or a reimplemtation of it is of little real interest to most users
	of the hardware supported by the pwc driver.


	I realize that I'm asking for forebearance, and
let-bygones-be-bygones, from a number of people.  In particular, this
plan won't work without Nemosoft's active involvement, as his approval
is needed to properly resurrect the present pwc driver, and he's the
only person at present who can maintain the pwcx module.

	Please consider this proposal of graceful transition as a
positive policy evolution for the Linux kernel, and for the Linux
community at large.

					Craig Milo Rogers


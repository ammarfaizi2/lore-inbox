Return-Path: <linux-kernel-owner+w=401wt.eu-S1751393AbXAUTlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbXAUTlf (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 14:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbXAUTlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 14:41:35 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:38598 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393AbXAUTle (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 14:41:34 -0500
X-Originating-Ip: 74.109.98.130
Date: Sun, 21 Jan 2007 14:40:47 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@CPE00045a9c397f-CM001225dbafb6
To: Nicholas Miell <nmiell@comcast.net>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, linville@tuxdriver.com
Subject: Re: [PATCH] Introduce simple TRUE and FALSE boolean macros.
In-Reply-To: <1169401892.2999.1.camel@entropy>
Message-ID: <Pine.LNX.4.64.0701211430020.17235@CPE00045a9c397f-CM001225dbafb6>
References: <Pine.LNX.4.64.0701210454590.2844@CPE00045a9c397f-CM001225dbafb6>
 <1169401892.2999.1.camel@entropy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Jan 2007, Nicholas Miell wrote:

> On Sun, 2007-01-21 at 05:03 -0500, Robert P. J. Day wrote:
> >   Introduce the TRUE and FALSE boolean macros so that everyone can
> > stop re-inventing them, and remove the one occurrence in the
> > source tree that clashes with that change.

> If you're going to introduce true and false macros, you should
> probably use the official all-lowercase C99 version.

i'm going to try this one more time, and see if i can get my point
across.  *yes*, the *eventual* goal should be to use the official
all-lowercase C99 versions of "true" and "false", and the patch i
proposed is, in fact, the first step in getting there.

by adding (temporarily) the definitions of TRUE and FALSE to types.h,
you should then (theoretically) be able to delete over 100 instances
of those same macros being *defined* throughout the source tree.
you're not going to be deleting the hundreds and hundreds of *uses* of
TRUE and FALSE (not yet, anyway) but, at the very least, by adding two
lines to types.h, you can delete all those redundant *definitions* and
make sure that nothing breaks.  (it shouldn't, of course, but it's
always nice to be sure.)

*now*, once that's done, you can start going through the tree and
doing the conversion from upper case to lower case, little by little,
subsystem by subsystem.

the predictable response will be, "you really should do that all at
once."  that's not going to happen, and you know it, and i know it.
that kind of change would be too big, and too disruptive.  so why not
just add two macro defines, then delete over 100 lines of what are now
redundant definitions, make sure nothing breaks, then move on to phase
two.

do we understand one another now?

rday

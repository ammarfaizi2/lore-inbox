Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbUAEURM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 15:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbUAEURM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 15:17:12 -0500
Received: from thunk.org ([140.239.227.29]:64441 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261188AbUAEURJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 15:17:09 -0500
Date: Mon, 5 Jan 2004 15:11:44 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@osdl.org>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Daniel Jacobowitz <dan@debian.org>, Andries Brouwer <aebr@win.tue.nl>,
       Rob Love <rml@ximian.com>, rob@landley.net,
       Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org
Subject: Re: udev and devfs - The final word
Message-ID: <20040105201144.GA11179@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Vojtech Pavlik <vojtech@suse.cz>, Greg KH <greg@kroah.com>,
	Linus Torvalds <torvalds@osdl.org>,
	viro@parcelfarce.linux.theplanet.co.uk,
	Daniel Jacobowitz <dan@debian.org>,
	Andries Brouwer <aebr@win.tue.nl>, Rob Love <rml@ximian.com>,
	rob@landley.net, Pascal Schmidt <der.eremit@email.de>,
	linux-kernel@vger.kernel.org
References: <20040104230104.A11439@pclin040.win.tue.nl> <Pine.LNX.4.58.0401041847370.2162@home.osdl.org> <20040105030737.GA29964@nevyn.them.org> <Pine.LNX.4.58.0401041918260.2162@home.osdl.org> <20040105035037.GD4176@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0401041954010.2162@home.osdl.org> <20040105043830.GE4176@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0401042043020.2162@home.osdl.org> <20040105074717.GB13651@kroah.com> <20040105111556.GA20272@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040105111556.GA20272@ucw.cz>
User-Agent: Mutt/1.5.4i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 05, 2004 at 12:15:56PM +0100, Vojtech Pavlik wrote:
> 
> Mutt with IMAP is rather bearable even on a GPRS connection (40kbps,
> 1sec latency). On a 100baseTX it's not distinguishable from local
> operation.

Hmm... I've tried using mutt/IMAP over GPRS connection, and I find it
extremely unpleasant, myself.  My solution is to use isync to provide
a local cached copy of the IMAP server on my laptop, and then run mutt
against the local cached copy.  

I have a patch to isync which allows it to issue multiple IMAP
commands in parallel (instead of operating in lockstep fashion):

http://bugs.debian.org/cgi-bin/bugreport.cgi//tmp/async-imap-patch?bug=226222&msg=3&att=1

With this patch, isync works very well, even over high latency, slow
speed links.

						- Ted

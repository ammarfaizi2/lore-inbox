Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265374AbUAEVGu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 16:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265697AbUAEVGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 16:06:50 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:36026 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S265374AbUAEVGs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 16:06:48 -0500
Date: Mon, 5 Jan 2004 22:06:25 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: "Theodore Ts'o" <tytso@mit.edu>, Vojtech Pavlik <vojtech@suse.cz>,
       Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@osdl.org>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Daniel Jacobowitz <dan@debian.org>, Andries Brouwer <aebr@win.tue.nl>,
       Rob Love <rml@ximian.com>, rob@landley.net,
       Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org
Subject: Re: udev and devfs - The final word
Message-ID: <20040105210625.GA26428@ucw.cz>
References: <Pine.LNX.4.58.0401041847370.2162@home.osdl.org> <20040105030737.GA29964@nevyn.them.org> <Pine.LNX.4.58.0401041918260.2162@home.osdl.org> <20040105035037.GD4176@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0401041954010.2162@home.osdl.org> <20040105043830.GE4176@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0401042043020.2162@home.osdl.org> <20040105074717.GB13651@kroah.com> <20040105111556.GA20272@ucw.cz> <20040105201144.GA11179@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040105201144.GA11179@thunk.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 05, 2004 at 03:11:44PM -0500, Theodore Ts'o wrote:

> On Mon, Jan 05, 2004 at 12:15:56PM +0100, Vojtech Pavlik wrote:
> > 
> > Mutt with IMAP is rather bearable even on a GPRS connection (40kbps,
> > 1sec latency). On a 100baseTX it's not distinguishable from local
> > operation.
> 
> Hmm... I've tried using mutt/IMAP over GPRS connection, and I find it
> extremely unpleasant, myself.  My solution is to use isync to provide
> a local cached copy of the IMAP server on my laptop, and then run mutt
> against the local cached copy.  
> 
> I have a patch to isync which allows it to issue multiple IMAP
> commands in parallel (instead of operating in lockstep fashion):
> 
> http://bugs.debian.org/cgi-bin/bugreport.cgi//tmp/async-imap-patch?bug=226222&msg=3&att=1
> 
> With this patch, isync works very well, even over high latency, slow
> speed links.

That looks very nice. Now, if there were a way how to make the isync
IMAP connections go over a compressed ssh link (like I'm doing with
Mutt/IMAP) that'd be very cool.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

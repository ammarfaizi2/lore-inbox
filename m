Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264890AbUAEOzu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 09:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264920AbUAEOzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 09:55:49 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:12047 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S264890AbUAEOzr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 09:55:47 -0500
Date: Mon, 5 Jan 2004 13:27:56 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Daniel Jacobowitz <dan@debian.org>, Andries Brouwer <aebr@win.tue.nl>,
       Rob Love <rml@ximian.com>, rob@landley.net,
       Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
Message-ID: <20040105132756.A975@pclin040.win.tue.nl>
References: <20040104000840.A3625@pclin040.win.tue.nl> <Pine.LNX.4.58.0401031802420.2162@home.osdl.org> <20040104034934.A3669@pclin040.win.tue.nl> <Pine.LNX.4.58.0401031856130.2162@home.osdl.org> <20040104142111.A11279@pclin040.win.tue.nl> <Pine.LNX.4.58.0401041302080.2162@home.osdl.org> <20040104230104.A11439@pclin040.win.tue.nl> <Pine.LNX.4.58.0401041847370.2162@home.osdl.org> <20040105030737.GA29964@nevyn.them.org> <Pine.LNX.4.58.0401041918260.2162@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0401041918260.2162@home.osdl.org>; from torvalds@osdl.org on Sun, Jan 04, 2004 at 07:33:16PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 04, 2004 at 07:33:16PM -0800, Linus Torvalds wrote:

[A mailbox full of messages, too many to reply to.
Yes, Daniel Jacobowitz understood that I referred to fsid in the NFS case:

  There is a great variation here in what various servers and clients do,
  but roughly speaking filehandles tend to contain a fsid, and this fsid
  often (no fsid= given) involves (major,minor,ino).

No, I have not talked this year about exporting /dev. Also interesting.
Yes, as I said, one can avoid NFS problems by giving fsid=.
It is similar elsewhere. A thousand minor problems are caused by
unstable device numbers. All annoying, each can be solved easily
once one has figured out what goes wrong and why. That is why I say
"preferably stable across reboots".]


What remains to be said?

Linus, let me try a bit more to address what I see as a misconception
in your posts.

> It shouldn't be fixed by saying "device numbers have to be stable across 
> reboots", because the fact is, we're most likely going to have storage 
> that is really really hard to enumerate in a repeatable fashion.

You have this strange hangup concerning "enumerate", and then keep
repeating to others that enumerating is impossible, and that therefore
stable device numbers are impossible, and that consequently, since we
cannot have stable device numbers expecting them to be stable is broken.

It is an old misconception - I recall you telling me how many billion years
an "ls /dev" would take with 64-bit device numbers.

No - I never advocated "find a device number by enumeration".
Quite the opposite, I advocated "use a hash of the serial number
as the device number of a disk". And more generally, "it is the
driver's job to assign a device number".

So it is not difficult at all to give this network attached storage
a stable device number.

And if one can, there is no reason not to do so.
It may even allow udev to give stable names as well.


Andries

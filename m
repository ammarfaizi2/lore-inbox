Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264443AbTLGQSy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 11:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264444AbTLGQSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 11:18:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:38882 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264443AbTLGQSx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 11:18:53 -0500
Date: Sun, 7 Dec 2003 08:18:49 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Eduard Bloch <edi@gmx.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: cdrecord hangs my computer
In-Reply-To: <20031207110122.GB13844@zombie.inka.de>
Message-ID: <Pine.LNX.4.58.0312070812080.2057@home.osdl.org>
References: <Law9-F31u8ohMschTC00001183f@hotmail.com>
 <Pine.LNX.4.58.0312060011130.2092@home.osdl.org> <3FD1994C.10607@stinkfoot.org>
 <20031206084032.A3438@animx.eu.org> <Pine.LNX.4.58.0312061044450.2092@home.osdl.org>
 <20031206220227.GA19016@work.bitmover.com> <Pine.LNX.4.58.0312061429080.2092@home.osdl.org>
 <20031207110122.GB13844@zombie.inka.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 7 Dec 2003, Eduard Bloch wrote:
>
> But somehow most Windows programers have easy way to deal with devices,
> they have clear paths to get hardware access where on Linux there is
> often something not thought out well which ruins your day. Examples?

What? There _is_ a very well thought out way of accessing devices in UNIX.
It is way superior to the mess that is windows. It is called a "device
node", and a hypothetical program might use a syntax like this:

	record dev=/dev/hdc

to access the device "/dev/hdc".

This is nothing new. This is how UNIX has worked for the last thirty years
or so. It's not only quite readable, but because everybody uses device
nodes the same way, it's consistent which makes it even more pleasant to
use. So if you were to want to mount the thing you recorded, you'd use

	mount /dev/hdc mntpoint

and notice how we used the same name again?

In contrast, the old cdrecord interfaces are an UNBELIEVABLE PILE OF CRAP!
It's an interface that is based on some random hardware layout mechanism
that isn't even TRUE any more, and hasn't been true for a long time. It's
not helpful to the user, and it doesn't match how devices are accessed by
everything else on the system.

It's bad from a technical standpoint (anybody who names a generic device
with a flat namespace is just basically clueless), and it's bad from a
usability standpoint. It has _zero_ redeeming qualities.

		Linus

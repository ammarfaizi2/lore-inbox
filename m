Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265907AbUAFFHs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 00:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266040AbUAFFHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 00:07:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:2532 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265907AbUAFFHp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 00:07:45 -0500
Date: Mon, 5 Jan 2004 21:07:30 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Andries Brouwer <aebr@win.tue.nl>, Daniel Jacobowitz <dan@debian.org>,
       Rob Love <rml@ximian.com>, rob@landley.net,
       Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
In-Reply-To: <20040106042831.GI4176@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0401052106030.2653@home.osdl.org>
References: <20040105030737.GA29964@nevyn.them.org>
 <Pine.LNX.4.58.0401041918260.2162@home.osdl.org> <20040105132756.A975@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0401050749490.21265@home.osdl.org> <20040105205228.A1092@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0401051224480.2153@home.osdl.org> <20040106001326.A1128@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0401051522390.5737@home.osdl.org>
 <20040106005944.GH4176@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0401051714420.2170@home.osdl.org>
 <20040106042831.GI4176@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 6 Jan 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:
> > 
> > Oh, don't look too closely at some pseudo-code, it's not like the code
> > would actually do that for a minor number. But for things like major
> > number allocation for disk devices, it might not be too far off. And we 
> > migth even want to start off the minors at some "random" offset (obviously 
> > while keeping the alignment right for the partition handling)
> 
> True, but...  Let me put it that way - entire area is a minefield and
> I would really like to avoid nasty surprises from "obvious" patches,
> what with having just spent 4 months dealing with the fallout from one
> such beast.

Hey, it's entirely possible that we won't be able to do it at _all_ during 
2.7.x, since it would require that all the distributions have started 
using udev or equivalent. Which is by no means certain at all. It's 
possible that just lack of ubiqutous infrastructure will mean that it 
would be too painful to even try this in a few months..

Do don't worry too much.

		Linus

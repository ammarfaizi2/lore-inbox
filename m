Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266057AbUAFBRf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 20:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266058AbUAFBRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 20:17:35 -0500
Received: from fw.osdl.org ([65.172.181.6]:7108 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266057AbUAFBRd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 20:17:33 -0500
Date: Mon, 5 Jan 2004 17:17:20 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Andries Brouwer <aebr@win.tue.nl>, Daniel Jacobowitz <dan@debian.org>,
       Rob Love <rml@ximian.com>, rob@landley.net,
       Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
In-Reply-To: <20040106005944.GH4176@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0401051714420.2170@home.osdl.org>
References: <20040104230104.A11439@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0401041847370.2162@home.osdl.org> <20040105030737.GA29964@nevyn.them.org>
 <Pine.LNX.4.58.0401041918260.2162@home.osdl.org> <20040105132756.A975@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0401050749490.21265@home.osdl.org> <20040105205228.A1092@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0401051224480.2153@home.osdl.org> <20040106001326.A1128@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0401051522390.5737@home.osdl.org>
 <20040106005944.GH4176@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 6 Jan 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:
> 
> Cute.  There's a little issue of, say it, meaningful relationship between
> sda and sda4, completely lost that way.  And _that_ has nothing to do with
> device enumeration.

Oh, don't look too closely at some pseudo-code, it's not like the code
would actually do that for a minor number. But for things like major
number allocation for disk devices, it might not be too far off. And we 
migth even want to start off the minors at some "random" offset (obviously 
while keeping the alignment right for the partition handling)

		Linus

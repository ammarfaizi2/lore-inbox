Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265850AbUAEC3J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 21:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265849AbUAEC3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 21:29:09 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:22793 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S265850AbUAEC3G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 21:29:06 -0500
Date: Mon, 5 Jan 2004 03:29:01 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Andries Brouwer <aebr@win.tue.nl>, Linus Torvalds <torvalds@osdl.org>,
       Rob Love <rml@ximian.com>, rob@landley.net,
       Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
Message-ID: <20040105032901.A11459@pclin040.win.tue.nl>
References: <20040103141029.B3393@pclin040.win.tue.nl> <Pine.LNX.4.58.0401031423180.2162@home.osdl.org> <20040104000840.A3625@pclin040.win.tue.nl> <Pine.LNX.4.58.0401031802420.2162@home.osdl.org> <20040104034934.A3669@pclin040.win.tue.nl> <Pine.LNX.4.58.0401031856130.2162@home.osdl.org> <20040104142111.A11279@pclin040.win.tue.nl> <Pine.LNX.4.58.0401041302080.2162@home.osdl.org> <20040104230104.A11439@pclin040.win.tue.nl> <20040104223710.GY4176@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040104223710.GY4176@parcelfarce.linux.theplanet.co.uk>; from viro@parcelfarce.linux.theplanet.co.uk on Sun, Jan 04, 2004 at 10:37:10PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 04, 2004 at 10:37:10PM +0000, viro@parcelfarce.linux.theplanet.co.uk wrote:

Hi Al - a happy 2004 to you too!

> Now, care to explain how preserving aforementioned common Unix idiom
> is related to your expostulations?

Hmm. You sound like you agree that random device numbers and NFS
are a bad combination, but don't see why my example might be
relevant.

There is a great variation here in what various servers and clients do,
but roughly speaking filehandles tend to contain a fsid, and this fsid
often (no fsid= given) involves (major,minor,ino). When device numbers
vary randomly, the fsid may vary randomly. Various bad things may happen:
maybe all file handles go stale (or, worse, refer to something else),
or maybe device numbers on the client vary randomly.

Andries


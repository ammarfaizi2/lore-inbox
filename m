Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261660AbVA3ImE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbVA3ImE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 03:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbVA3ImE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 03:42:04 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48026 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261660AbVA3ImA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 03:42:00 -0500
Date: Sun, 30 Jan 2005 08:41:54 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Roman Zippel <zippel@linux-m68k.org>, Andries Brouwer <aebr@win.tue.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: Possible bug in keyboard.c (2.6.10)
Message-ID: <20050130084154.GU8859@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.61.0501270318290.4545@82.117.197.34> <20050127125637.GA6010@pclin040.win.tue.nl> <Pine.LNX.4.61.0501272248380.6118@scrub.home> <20050128105937.GA5963@ucw.cz> <20050129045055.GS8859@parcelfarce.linux.theplanet.co.uk> <20050129112510.GB2268@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050129112510.GB2268@ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2005 at 12:25:10PM +0100, Vojtech Pavlik wrote:
> I know. As I said, this is a problem I know about, and will be fixed. I
> was mainly interested whether anyone sees further problems in scenarios
> which don't include device addition/removal.
> 
> We already fixed this in serio, and input and gameport are next in the
> list.

OK, I'll bite.  What's to guarantee that no events will happen in
the middle of serio_unregister_port(), right after we'd done
serio_remove_pending_events()?

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264305AbUADUt4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 15:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264376AbUADUt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 15:49:56 -0500
Received: from findaloan.ca ([66.11.177.6]:19109 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id S264305AbUADUty (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 15:49:54 -0500
Date: Sun, 4 Jan 2004 13:44:04 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Valdis.Kletnieks@vt.edu
Cc: Andries Brouwer <aebr@win.tue.nl>, Linus Torvalds <torvalds@osdl.org>,
       Rob Love <rml@ximian.com>, rob@landley.net,
       Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
Message-ID: <20040104184404.GA20697@mark.mielke.cc>
Mail-Followup-To: Valdis.Kletnieks@vt.edu,
	Andries Brouwer <aebr@win.tue.nl>,
	Linus Torvalds <torvalds@osdl.org>, Rob Love <rml@ximian.com>,
	rob@landley.net, Pascal Schmidt <der.eremit@email.de>,
	linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
References: <20040101164831.A2431@pclin040.win.tue.nl> <1072972440.3975.29.camel@fur> <Pine.LNX.4.58.0401021238510.5282@home.osdl.org> <20040103040013.A3100@pclin040.win.tue.nl> <Pine.LNX.4.58.0401022033010.10561@home.osdl.org> <20040103141029.B3393@pclin040.win.tue.nl> <Pine.LNX.4.58.0401031423180.2162@home.osdl.org> <20040104000840.A3625@pclin040.win.tue.nl> <20040104011626.GB6398@mark.mielke.cc> <200401040154.i041saXG029539@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401040154.i041saXG029539@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 03, 2004 at 08:54:36PM -0500, Valdis.Kletnieks@vt.edu wrote:
> ISTR that SunOS 4.0 handled an NFS-mounted /dev and swap just fine
> some 15 years ago? (in fact, due to performance differences between
> the disks on a Sun3/ 2xx server and the shoebox disk on a 3/50, you
> could page faster over the net than to a local /dev/swap).

Whether it did at some point, or whether it didn't, doesn't really matter.

It doesn't need to, and with the amount of memory that most computers come
with these days, remote access storage for tiny kernel data structures, like
that which would be required for tmpfs /dev that is only populated with the
devices that actually exist, just isn't worth it.

> So it's more a case of "we have decided to do it differently" than
> "that's so nuts that it shouldn't be expected to work"....

I was saying "why do you think this is a good model?" not "I can't imagine
why you would do it..." :-) Sorry it didn't come across as I intended.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbUBQHSw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 02:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbUBQHSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 02:18:52 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:59911 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S261595AbUBQHSp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 02:18:45 -0500
Date: Mon, 16 Feb 2004 23:18:38 -0800
From: jw schultz <jw@pegasys.ws>
To: Linux kernel <linux-kernel@vger.kernel.org>
Cc: John Bradford <john@grabjohn.com>, Jeff Garzik <jgarzik@pobox.com>,
       Linus Torvalds <torvalds@osdl.org>,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: UTF-8 practically vs. theoretically in the VFS API
Message-ID: <20040217071838.GD9466@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	Linux kernel <linux-kernel@vger.kernel.org>,
	John Bradford <john@grabjohn.com>, Jeff Garzik <jgarzik@pobox.com>,
	Linus Torvalds <torvalds@osdl.org>,
	viro@parcelfarce.linux.theplanet.co.uk
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca> <200402150006.23177.robin.rosenberg.lists@dewire.com> <20040214232935.GK8858@parcelfarce.linux.theplanet.co.uk> <200402150107.26277.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.58.0402141827200.14025@home.osdl.org> <20040216183616.GA16491@schmorp.de> <Pine.LNX.4.58.0402161040310.30742@home.osdl.org> <4031197C.1040909@pobox.com> <200402161948.i1GJmJi5000299@81-2-122-30.bradfords.org.uk> <20040216201610.GC17015@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040216201610.GC17015@schmorp.de>
User-Agent: Mutt/1.3.27i
X-Message-Flag: Annoy potential new customers!  Reach new depths of advertising opportunism!  Contact this email address to see your product or service featured in this space.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 16, 2004 at 09:16:10PM +0100, Marc Lehmann wrote:
> On Mon, Feb 16, 2004 at 07:48:19PM +0000, John Bradford <john@grabjohn.com> wrote:
> > Quote from Jeff Garzik <jgarzik@pobox.com>:
> > None of this is a real problem, if everything is set up correctly and
> > bug free.  Unfortunately the Just Works thing falls apart in the,
> > (frequent), instances that it's not :-(.
>       
> And this is the whole point.
> 
> BTW, to people trying to explain some properties of UTF-8 to me. I don't
> think ad-hominem attacks like assuming that I don't understand UTF-8
> (without any indication that this is so) are useful.
> 
> The point here is that the kernel does, in a very narrow interpretation,
> not support the use of UTF-8, because proper support of UTF-8 means that
> no illegal byte sequences will be produced.

That "interpretation" is so narrow as to be unrealistic.
The kernel supports UTF-8 the same way a stage supports
rock musicians.  You confuse support with enforce, rather
like confusing tolerance with endorsement.

And it should be noted that the kernel doesn't produce file
names.  It only passes them along.

> Of course, I can feed the kernel UTF-8, and if everybody does that, it
> will generally work quite fine. However, Windows surely works fine if
> every program only feeds allowed values into system calls. And even unix
> dialects without memory protection work, as long as everybody plays
> fair.
>
> The point is, however, that this is highly undesirable, and it would be
> nice to have a kernel that would (optionally) fully support a UTF-8

You mean enforce again.  That enhancement request has been
rejected repeatedly because such a thing would be highly
undesirable.  What might be a convenient but unnecessary
restriction today is too likely to become an unbearable
restriction tomorrow.  I don't want the kernel to have to
care about what is or isn't valid UTF-8.  I certainly don't
want to have the kernel loaded with outdated character
tables.

> environment in where applications can feed UTF-8 and _expect_ UTF-8 in
> return, which _is_ a security issue.

I want an environment where applications can feed bytestreams
and expect the same bytestream in return.  I see enough
problems as a result of filesystems that don't do that.

> It's very desirable to have a kernel that actively supports this. IT is

You mean enforces again.  Kernel as police, next thing you
will want is a kernel that prevents undesirable character
sequences.

> clearly not _required_, of course. But then again, process abstraction
> is also not required...

I'll tell you what.  Patch libc.  You can add UTF-8 filename
enforcement to libc.  There are only a few system calls that
would need to have their wrappers enlarged.  I'm sure the
libc people will direct you to someplace very warm if you
ask them for this enhancement.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt

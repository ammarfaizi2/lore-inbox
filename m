Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135895AbREBUmT>; Wed, 2 May 2001 16:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135892AbREBUmJ>; Wed, 2 May 2001 16:42:09 -0400
Received: from pop.gmx.net ([194.221.183.20]:60749 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S135897AbREBUly>;
	Wed, 2 May 2001 16:41:54 -0400
Date: Wed, 2 May 2001 22:41:23 +0200
From: Daniel Elstner <daniel.elstner@gmx.net>
To: Chris Mason <mason@suse.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reiserfs+lndir problem [was: 2.4.4 SMP: spurious EOVERFLOW "Value too large for defined data type"]
Message-Id: <20010502224123.0539e8c6.daniel@master.daniel.homenet>
In-Reply-To: <71770000.988757331@tiny>
In-Reply-To: <20010502004152.23a0751b.daniel@master.daniel.homenet>
	<71770000.988757331@tiny>
X-Mailer: Sylpheed version 0.4.64 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 May 2001 18:48:51 -0400 Chris Mason <mason@suse.com> wrote:

> Ok, can you reproduce with a set of sources other than X?  I would leave
> glibc alone for now, unless you can reproduce on ext2.

No.
I tried building kernel 2.4.4 five times in a row - no errors.
Also some diff's after two `make dep' didn't show anything.

The xfree-dri sources from cvs failed, too.
Something special with imake?

-- Daniel


> > Hi,
> > 
> > On Mon, 30 Apr 2001 21:03:47 -0400 Chris Mason <mason@suse.com> wrote:
> > 
> >> > Apparently it's a reiserfs/symlink problem.
> >> > I tried doing the lndir on an ext2 partition, sources still
> >> > on reiserfs. And it worked just fine!
> >> 
> >> Neat, thanks for the extra details.  Does that mean you can consistently
> >> repeat on reiserfs now?  What happens when you do the lndir on reiserfs
> >> and diff the directories?
> > 
> > I just played around a bit with the following results:
> > 
> > sources on reiserfs, lndir on reiserfs -> make fails, diff ok
> > sources on reiserfs, lndir on ext2     -> make ok
> > sources on ext2, lndir on reiserfs     -> make fails, diff ok
> > 
> > Doing the diff against a second copy of the tree shows no errors, too.
> > Always the same behaviour: You have to run lndir at least twice to
> > get the error. If the link tree was already set up after a boot, the
> > error occurs only after rm + lndir + rm + lndir.
> > 
> > There's a strange way to get things working just like after a reboot.
> > After diff'ing the link tree with the 2nd copy (both on reiserfs),
> > make World won't fail - at least once.

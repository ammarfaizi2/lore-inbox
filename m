Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317521AbSINVMT>; Sat, 14 Sep 2002 17:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317540AbSINVMT>; Sat, 14 Sep 2002 17:12:19 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:13585
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S317521AbSINVMS>; Sat, 14 Sep 2002 17:12:18 -0400
Date: Sat, 14 Sep 2002 14:14:52 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Alex Davis <alex14641@yahoo.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, miquels@cistron.nl,
       linux-kernel@vger.kernel.org
Subject: Re: Possible bug and question about ide_notify_reboot in 2.4.19
In-Reply-To: <20020914195223.48337.qmail@web40510.mail.yahoo.com>
Message-ID: <Pine.LNX.4.10.10209141359590.6925-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Sep 2002, Alex Davis wrote:

> > Hint 1. Other people make disks too.
> I'm glad you and I realize that. It seems that others might not. So
> far, in this thread, only one person using one brand of disk (IBM)
> has found something in writing about the cache issue. Let's see, 
> that leaves Maxtor/Quantum, Seagate, Fujitsu, .....

I can list a bunch, but I know about them under heavy NDA's with anvils
looming over head.

Like what happens if a drive issues a self flush cache and receives an
error so the next issue from user/kernel space will cause the device to
internally deadlock.  Yeah this is a firmware bug, imho.  Yet when it was
to be addressed by the commitee, "NONE" of the drive vendors reported back
their behavior, iirc.  Thus the proposal was dropped.

> > Hint 2. The guys who did the code include a member of the standards
> > committee.
> And your point is...?? Does this somehow preclude them being wrong??

You should come in the room sometime and watch.
It is not so much being wrong, it is all in the language.

There are things in the standard, which make Bill Clinton look squeaky
clean.  You think Clinton's "is" was bad.

Try this one, "READ_VERIFY"

You issue a write to platter, then a read_verify to have the device do an
internal comparison.  Usually a bastardized benchmark pile of dung.
Some drive vendors in the past would pull the data out of dirty disk
buffer cache, and not off the platters.  Translation it never made it to
platter, and you never know if it did.  When caught by their competitors,
the language change to "shall have been read off the platter some time in
the past".  Yet you just issued a write to platter, so that means that
data can not have been read in the past but must be in the future.

Future/Past the pull it out of cache.

Want more to make your guts turn?

Andre Hedrick
LAD Storage Consulting Group


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbTJOK1V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 06:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262550AbTJOK0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 06:26:18 -0400
Received: from smtp2.att.ne.jp ([165.76.15.138]:51451 "EHLO smtp2.att.ne.jp")
	by vger.kernel.org with ESMTP id S262538AbTJOK0G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 06:26:06 -0400
Message-ID: <00eb01c39306$aaa1e790$3eee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: "John Bradford" <john@grabjohn.com>, <linux-kernel@vger.kernel.org>
References: <32a101c3916c$e282e330$5cee4ca5@DIAMONDLX60> <200310131014.h9DAEwY3000241@81-2-122-30.bradfords.org.uk> <33a201c39174$2b936660$5cee4ca5@DIAMONDLX60> <200310131033.h9DAXkHu000365@81-2-122-30.bradfords.org.uk> <33d201c3917d$668c8310$5cee4ca5@DIAMONDLX60> <200310131202.h9DC2KlZ000194@81-2-122-30.bradfords.org.uk>
Subject: Re: Why are bad disk sectors numbered strangely, and what happens to them?
Date: Wed, 15 Oct 2003 19:23:20 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford replied to me:

> >   IF the bad sector doesn't get reused then great, then the next bit of
> > effort will be to try to get the sector marked as bad, if there is any way
> > to do that under Linux.  See the next question, which is now being reposted
> > for at least the fourth time.
> >   BUT IF the same sector number gets rewritten then hopefully the same
> > sector number will be associated with a reallocated non-defective sector and
> > the data will get written properly.
>
> Yes, that's what I'd hope, unless the disk ran out of spare space to
> allocate.

Surely two reallocations wouldn't have made it run out of spare space?

Besides, the S.M.A.R.T. log didn't have any statistics anywhere near
failure, and if the drive had run out of spare space then surely one or two
of the statistics should have gone down to zero.

> > > >    How can I tell Linux to mark the sector as bad, knowing the LBA
> > > >    sector number?
> > >
> > > Don't.  If the drive can't fix this problem itself, throw it in the bin.
> >
> > THE DRIVE HAS 1, ONE, HITOTSU, UNO, UN, BAD SECTOR.
>
> No, the last SMART test re-allocated one sector.

Yeah, but it's not even quite clear if the reallocated sector is the same as
the defective sector.  Something is pretty screwy, and I've asked some
friends at Toshiba to discuss it during their next visit (and they know
they're getting cat food instead of my wife's cooking  _^o^_)  Nonetheless,
it is customary to dump drives when they have increasingly numerous defects,
not when they have one.

> That sector may have gone bad in the next few minutes.  Unlikely, but possible.

I think you mean that the replacement sector might have gone bad in the
minutes after the reallocation.  Unlikely but possible, yes.  I guess I will
probably try to write zeroes to the sector using the suggestion by Maciej
Zenczykowski, but first I'll ask the Toshiba people if they have different
preferences.

> > The drive is capable of
> > doing reallocations.  What kind of operation can be done that will persuade
> > the drive to do the reallocation?
>
> The drive has _done_ a reallocation.  You posted that the reallocated
> sector count had gone from 1 to 2.  This is why I said if it can't fix
> the problem, bin it.  It doesn't seem to have fixed the problem yet.

It's not obvious if the reallocated sector was the same one as the detected
defective sector.  I thought it seemed not to be.  You pointed out that it
is unlikely but possible.

> Somebody else might read this thread, and want full instructions.

OK, sorry I thought you just hadn't read what you were replying to.

> 3. Run the tests again.  Your drive fixed one bad sector, let's see if
>    it completes the test again without finding more.

Yeah, but I was already upset by finding that the same sector number
remained bad even after it "should" have been the one that was reallocated.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbTJZLjw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 06:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263090AbTJZLjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 06:39:52 -0500
Received: from smtp1.att.ne.jp ([165.76.15.137]:1498 "EHLO smtp1.att.ne.jp")
	by vger.kernel.org with ESMTP id S263088AbTJZLju (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 06:39:50 -0500
Message-ID: <358a01c39bb5$c651c7a0$24ee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: "John Bradford" <john@grabjohn.com>,
       "Mudama, Eric" <eric_mudama@Maxtor.com>,
       "'Hans Reiser '" <reiser@namesys.com>,
       "'Wes Janzen '" <superchkn@sbcglobal.net>,
       "'Rogier Wolff '" <R.E.Wolff@BitWizard.nl>,
       <linux-kernel@vger.kernel.org>, <nikita@namesys.com>,
       "'Pavel Machek '" <pavel@ucw.cz>,
       "'Justin Cormack '" <justin@street-vision.com>,
       "'Vitaly Fertman '" <vitaly@namesys.com>,
       "'Krzysztof Halasa '" <khc@pm.waw.pl>
References: <334101c39b94$268a0370$24ee4ca5@DIAMONDLX60> <200310261039.h9QAdniV000310@81-2-122-30.bradfords.org.uk>
Subject: Re: Blockbusting news, results get worse
Date: Sun, 26 Oct 2003 20:38:53 +0900
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

John Bradford pretended to reply to me:

> > 4.  When writing ZEROES to the bad sector, the drive reports SUCCESS.
> > But it lies.  Subsequent attempts to read still fail.  Subsequent
> > writing of zeroes appears to succeed again.  Subsequent attempts to read
> > still fail.
>
> > I still have to say, we can't fix Toshiba, and we can avoid Toshiba, but
> > meanwhile we can fix Linux.
>
> How do you suggest we 'fix' 4, above, other than to flush the cache
> and verify each time a full sector of zeros is written to the disk?

Number 4 cannot be fixed by Linux.  Why do you pervert my writing?

The refusal to remove a known defective block from ordinary use in the file
system can be fixed.  How many times does this need to be said?  Why do you
pretend that this is not what I have been saying in this entire thread?

If I understand Hans Reiser's message correctly, this fix has indeed been
made in ReiserFS version 4.  I thank Mr. Reiser.  (By the way, I volunteer
about one day each weekend for testing, and I am hardly in a position to
contribute funds.  Please let's not beggar each other.)

By the way some participants in this thread have argued that the block
should not be replaced by zeroes or random garbage without notice.  I fully
agree.  The block should be replaced by zeroes or random garbage WITH
notice.  From the point of view of logging it in the system log, it is
enough to log it once, it doesn't have to be logged over and over again.
>From the point of view of informing the user whose program is running, the
dd command does an excellent job, but some unknown program was remaining
silent when I/O errors were originally detected and logged.  I still think
it is better to get that block out of the file system so that when that file
is rewritten or when other new files get created or extended then they won't
try to reuse that block.  But I've said this enough too.  I guess it's time
to stop beating this dead horse.  But anyway Mr. Reiser understood, and I am
glad, and I thank him.


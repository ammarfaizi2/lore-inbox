Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbTJSILU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 04:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbTJSILU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 04:11:20 -0400
Received: from smtp3.att.ne.jp ([165.76.15.139]:20160 "EHLO smtp3.att.ne.jp")
	by vger.kernel.org with ESMTP id S262072AbTJSILP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 04:11:15 -0400
Message-ID: <021501c39618$615619c0$24ee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: "Mudama, Eric" <eric_mudama@Maxtor.com>,
       "'Hans Reiser '" <reiser@namesys.com>,
       "'Wes Janzen '" <superchkn@sbcglobal.net>,
       "'Rogier Wolff '" <R.E.Wolff@BitWizard.nl>,
       "'John Bradford '" <john@grabjohn.com>, <linux-kernel@vger.kernel.org>,
       <nikita@namesys.com>, "'Pavel Machek '" <pavel@ucw.cz>,
       "'Justin Cormack '" <justin@street-vision.com>,
       "'Russell King '" <rmk+lkml@arm.linux.org.uk>,
       "'Vitaly Fertman '" <vitaly@namesys.com>,
       "'Krzysztof Halasa '" <khc@pm.waw.pl>
References: <785F348679A4D5119A0C009027DE33C105CDB300@mcoexc04.mlm.maxtor.com>
Subject: Re: Blockbusting news, results are in
Date: Sun, 19 Oct 2003 17:09:36 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Mudama replied to me:

> > Does anyone need more?
>
> Why don't you ask your friends at Toshiba whether that model supports
> automatic reallocation, and if it does, how to enable it?

1.  I didn't have to ask whether it does, because the S.M.A.R.T. logs
already showed that it had done so.  The probelm is that it didn't do so to
the block that was involved in this issue.

2.  I did ask a different question, why that particular block wasn't getting
reallocated, and my friends answered, and this answer was already reported
in this thread a few days ago.

3.  If there were a way to enable reallocation in case of permanent errors,
I think my friends would have said.  But they sure didn't say there were any
user-settable options, they only said some approximations of how it was
designed.  It does reallocations after temporary read errors but not after
permanent read errors (where permanent means 255 failures in auto-retry).
They think it does reallocations after temporary write errors, they weren't
sure if it does reallocations after permanent write errors, now we know that
it doesn't do reallocations after permanent write errors, and this is how it
is designed, with no hint of options to toggle.

> > We do not know if Toshiba is the only maker whose firmware
> > refuses to reallocate bad blocks when permanent errors are
> > detected, because the makers aren't saying.
>
> What would you like "us disk makers" to say?

How to force reallocations even when data are lost, so that the block number
can still be accessed even though the data will be random or zeroes until it
gets written again.  How to force reallocations even when data are lost, to
prevent a different problem (i.e. if the block is not reallocated and then a
subsequent write appears to succeed, I don't really think that spot on the
platter has really reliably recovered even if you think so, I think the new
data might still get lost again in a few milliseconds or minutes).

> If every other part of your computer is warrantied for 1 year, why should
> disk drives alone in the cheapest OEM systems carry 3 year warranties?

Why does RAM carry 6 year warranties?  (Maybe some don't but this is
common.)

> BTW, you're welcome to buy "premium" drives with 3-year or 5-year
> warranties.  (3 on most vendor's high end ATA products, and 5 years on
> most SCSI products)

I haven't seen that, even on a SCSI product.

Meanwhile, regarding ATA and warranties, here's a question for you.  I
bought a Maxtor 80GB desktop hard drive at a time when it was a high end
product.  The drive came with two sets of instructions, one in Japanese and
one in English.  Which set of instructions do you think most customers read
here in Japan?  And then which set of instructions do you think was more
likely to have correct jumpering instructions?  I couldn't quite be sure
which set of jumpering instructions to believe, because even though Maxtor's
parent might be in the US (I'm not sure actually), I did buy this thing in
the Japanese market with Japanese packaging and one of the two sets of
instructions in Japanese.  So I sent e-mail to Maxtor to ask which
instructions were correct, but Maxtor didn't answer.  I phoned Maxtor, and
it turned out that the phone number was answered in Singapore, and the
person didn't answer my question but gave a different e-mail address for me
to send my question to.  So I sent e-mail to Maxtor's different e-mail
address to ask again which instructions were correct and explain everything
that had happened so far.  Maxtor still never answered.  Would you like to
know why my level of trust in Maxtor drives is as low as it has been in IBM
drives since a previous experience and has been in Toshiba drives for the
past week?  This doesn't exactly reflect drive reliability unless I guess
wrong which set of jumpering instructions to obey.  But still, suppose I
guessed wrong, then would Maxtor provide a warranty?

> In most cases these premium warranties will only cost you $5-$10.

I've still never seen them on parts that way, not for 550 yen or 1,100 yen
or any other amount.  I've occasionally seen it on entire computers, for
example Dell, or a store warranty at Bic Camera, for around 5% of the price
of the computer.

> > If their disk drives start to develop bad blocks after two
> > years, then customers don't discover how bad Toshiba's firmware
> > is until two years have passed, and now they can't even make
> > claims to get firmware fixed.
>
> What do you want "fixed" in the firmware?

Reallocate bad blocks when bad blocks are detected, even in situations when
the badness is detected as permanent.  This answer hasn't been clear yet
from this thread?????

> I still don't understand why your Toshiba engineer friends couldn't help
> you beyond listening to the drive bounce off the crash stop.

They're not sure yet if they can.  Officially of course they can't, because
of the warranty rules that have already been discussed.

> (BTW, if the drive is clunking because it can't acquire at a certain
> location, odds are that more than just the user data at that sector is a
> problem.

It didn't sound like clunking.  It sounded like repeated seeks.  It didn't
sound like 255 repeated seeks, so I'm guessing it probably does something
like try 15 retries without seeking, then seek again and try another 15
times, etc.

Meanwhile, the end result still holds.  In at least some cases, known
defective firmware is refusing to do reallocations when reallocations are
possible.  Other makers' firmware is less known.  We still need to keep
lists of bad blocks known by the OS and filesystems and drivers, and we
still need to keep those blocks away from ordinary file operations.  These
lists remain as necessary as they ever were.  Unless we get some guarantees
of good behavior by drives, if we don't make lists of bad blocks then we
will have to say that Linux and disk drives shouldn't be used together in
any computer.


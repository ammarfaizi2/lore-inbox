Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbTHYMRI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 08:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbTHYMRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 08:17:08 -0400
Received: from smtp1.att.ne.jp ([165.76.15.137]:54736 "EHLO smtp1.att.ne.jp")
	by vger.kernel.org with ESMTP id S261230AbTHYMRC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 08:17:02 -0400
Message-ID: <052a01c36b02$9de086f0$24ee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: "Jamie Lokier" <jamie@shareable.org>
Cc: <linux-kernel@vger.kernel.org>
References: <003701c36972$a980e1d0$78ee4ca5@DIAMONDLX60> <20030825042414.GC20529@mail.jlokier.co.uk>
Subject: Re: Input issues - key down with no key up
Date: Mon, 25 Aug 2003 21:15:40 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jamie Lokier" <jamie@shareable.org> replied to me:

> > For Japanese versions of Windows 95 or 98 or NT4, of course the Japanese
> > keys do produce input.  Of course the Japanese layout driver is
> > involved.  I don't recall if the lower-level keyboard driver has a name
> > that distinguishes it from the US-101 driver, but the binaries are
> > almost certainly different.

[And for Japanese versions of Windows 2000 and Windows XP, of course the
Japanese keys do produce input.  Of course the Japanese layout driver is
involved, but also the lower-level driver is named for the Japanese-106
keyboard.]

> Do you know what the Japanese keys do under Linux?

I don't recall them doing anything under Linux.  I think I've read some
people say that the Japanese keys yield spaces for them, which would not be
too bad because three of those keys are next to the space bar anyway.  But I
think I get no input at all for them, which also isn't too bad (mostly -- 
but see below).

Of course the problem which is too bad is getting no input for the keys
yen-sign or-bar and backslash underscore.

In 2.4, after the USB-to-emulated-PS/2 translation level in the driver was
finally patched, I think that all of the Japanese keys were finally patched
to yield the same as the PS/2 translations of the USB keys.  The patch was
different from the one which I sent which was ignored, for which the
difference is OK (the effect is the same) but it really bugged me that it
was ignored for months.  Anyway, after the patch in 2.4, the potential of
letting the Japanese keys do something in Linux depended only on the
possibility of acting at the PS/2 layer or above.

In 2.6, I have a feeling that there might be one or two levels of breakage,
as there has been for the yen-sign or-bar and backslash underscore keys.
Sorry I neglected to test them two days ago.  But for that matter, the test
which I reported two days ago seems to have been ignored again.  I can only
volunteer about one day a week, but some people get paid to do this as their
job, and I wonder why my report has been ignored.

Now, I think I've read that ATOK can run under Linux.  Monopolysoft's IME is
based on ATOK's IME so a lot of people are used to it.  There are also other
IMEs under development for Linux.  For me and at least one other Usenetter
in Japan, it is a nuisance that Shift+Space turns on the X-11 IME, because
we often type it when we just want a space (if our thumb is still on the
Shift key from typing the previous character).  It really would be nice if
we could configure the hankaku/zenkaku key to turn the IME on or off the way
ATOK and Monopolysoft do, and then configure Shift+Space to just input a
Space.  But this would depend on making the Japanese keys do something in
Linux.  By the way the hankaku/zenkaku key is the one which isn't next to
the space bar, it's in the position which yields ` and ~ on a US keyboard.

(As for why the hankaku/zenkaku key turns the IME on and off instead of
switching between hankaku and zenkaku, the reason is yet another compound of
hacks, but people are used to it now.  Actually Alt+hankaku/zenkaku does
still also turn the IME on and off as it always did.  Except under Linux of
course.  I think it's still a no-op under Linux.)


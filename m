Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262290AbTINDxa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 23:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262292AbTINDxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 23:53:30 -0400
Received: from smtp3.att.ne.jp ([165.76.15.139]:46220 "EHLO smtp3.att.ne.jp")
	by vger.kernel.org with ESMTP id S262290AbTINDv4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 23:51:56 -0400
Message-ID: <1b7301c37a73$861bea70$2dee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: <linux-kernel@vger.kernel.org>
Cc: "Vojtech Pavlik" <vojtech@suse.cz>
Subject: 2.6.0-test5 vs. Japanese keyboards
Date: Sun, 14 Sep 2003 12:51:32 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In thread "Re: Trying to run 2.6.0-test3", Alan Cox replied to me:

> > What will it take this time?
>
> Posting the patch with any luck ?

I knew that that would not be sufficient.  On 2003.07.24, I think in the
days of 2.6.0-test1, junkio@cox.net posted a patch for Japanese PS/2
keyboards.  On 2003.08.31, in the days of 2.6.0-test4, I posted a revised
patch to include Japanese USB keyboards.  2.6.0-test5 includes neither of
them because the keyboard driver maintainers don't personally depend on
Japanese keyboards.

Since posting has not been sufficient, I beg Mr. Pavlik, just once per
release, please try pretending that you might have to depend on a Japanese
keyboard.  You don't have to use one daily as your colleague Dr. Fabian
does.  Just twice per release, once in a plain text console and once under
X11, please try testing a Japanese PS/2 keyboard and Japanese USB keyboard.

In particular the troublesome keys are yen bar and backslash underscore.
You don't need a Japanese font.  If you use an ASCII font then the keys
display as backslash bar and backslash underscore.  If you use a Japanese
font then the keys display as yen bar and yen underscore.  In all cases the
ASCII backslash or JIS-Romaji yen character are code point 0x5C.

(Don't worry about the labels on the right-hand side of each key, for direct
kana input.  Less than 0.1% of Japanese and other residents of Japan ever
use direct kana input under Monopolysoft Windows, and probably none at all
under Linux.  When inputting Japanese, common practice is to input the
pronunciation in Italian characters and let the OS convert first to kana and
then to Kanji.  We depend on the labels on the left-hand side of each key,
including the two mentioned above.  Exception 1:  yen and backslash are
really the same character even though the keys have different labels.
Exception 2:  a shifted 0 doesn't really produce a ~ but it is enough that a
shifted ^ does so, but it doesn't matter that Linux has added real input for
a shifted 0.)


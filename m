Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262725AbTLULIn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 06:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbTLULIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 06:08:43 -0500
Received: from smtp1.att.ne.jp ([165.76.15.137]:17599 "EHLO smtp1.att.ne.jp")
	by vger.kernel.org with ESMTP id S262725AbTLULIc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 06:08:32 -0500
Message-ID: <0d6001c3c7b2$bbf900b0$43ee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: "John Bradford" <john@grabjohn.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cannot input bar with JP106 keyboards
Date: Sun, 21 Dec 2003 20:07:14 +0900
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

John Bradford wrote:

> The placement of some keys seems to have changed over time.

IBM used to change key placements once or twice per sub-model of any model
of keyboard.  Other manufacturers made various changes too.  Things settled
down around 20 years ago.

> tilde was once shift-0, whilst shift-caret was once overbar.

I don't know why most keyboards still show a tilde on the 0 (zero) key, but
I've never seen it produce any input except in Linux.  Most keyboards still
show an overbar on the caret key but most fonts during the past 10 years
display it as tilde.

> Backslash and Yen share the same code in 8-bit variations of
> ASCII-based.  Therefore, the lower-right backslash key and the
> upper-right Yen key may in some cases be used interchangably.

In all cases, except on some IBM model that was more than 20 years old.  Of
course the scan codes are different, which is necessary because the shifted
characters are different (and also the kana characters are different, for
the handful of direct kana typists who are rumored to exist, but I've never
met one).  It seems inconsistent to me that the lower right backslash key
still produces a yen sign on input when shift 0 doesn't produce a tilde or
overbar, but consistency doesn't rule.  The yen sign displays as a backslash
in ASCII fonts.  The yen sign and curly braces and some other characters
display as alphabetics in some other national fonts.

> However, with unicode representations, both backslash and Yen and
> tilde and overbar have separate codes

Double-byte Japanese character codes always had separate wide characters for
backslash and tilde, and dozens of different bars.  It's no surprise that
Unicode would include all those wide characters, though of course with
different code points than the common codings (EUC and ShiftJIS).  If
Unicode has separate narrow characters for all four of these characters,
well, they're not all going to get used in ordinary text input and display.

> and I personally think it would be a good idea to default to the
traditional key-mappings, so that these characters can be easily input on
systems which correctly support them.

That would be sort of like requiring all Linux users to learn the Dvorak
layout because typing is easier (faster) for users who have already learned
the Dvorak layout.  That would alienate the mass majority who learned to use
a more common national layout.  After all the reason these national layouts
remain common is because of the mass majorities who already learned them.
It is the same in Japan.  You have to let ordinary keys work the way they
traditionally have.

By the way, you used the word "traditional" where I think the fact is
"archaic and even then only on some fraction of keyboards."  I used the word
"traditionally" for keyboards as they've been used for the past 20 years.

> As I understand it there was traditionally a distinction between pipe,
> (a broken vertical line), and bar, (solid vertical line).

Archaically in one manufacturer's character set I think.  I saw the same
distinction in one manufacturer's US EBCDIC character set too, but never saw
both characters on any card punch, printer, or terminal.

> Pipe is the fourth character on the lower-right backslash key.
> Bar is the second character on the upper-right yen key.

The one that is always used as a pipe or or-bar is the shifted form of the
upper-right yen key.

The one that you see as the shifted form of the direct kana input mode of
the lower-right backslash key is another one of those that produces no
input.  There are a few more that you didn't mention.  Japanese keyboards
also often have markings for a British pound sign, US cent sign, Kanji
repetition marker, rectangular logical not character, and an extra pair of
quotation marks, as shifted forms of direct kana input mode of some keys.
But those also produce no input.  These also I think only produced input in
one manufacturer's archaic character set, I think.  JIS-Romaji (single byte
code points in the range 0 to 127) certainly do not include a British pound
sign, US cent sign, backslash, more than one vertical bar, or more than one
of tilde and overbar.  Some manufacturers sensibly decline to print these
non-existent characters on the keys of their keyboards.


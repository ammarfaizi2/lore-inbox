Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136759AbREAXMy>; Tue, 1 May 2001 19:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136760AbREAXMo>; Tue, 1 May 2001 19:12:44 -0400
Received: from hera.cwi.nl ([192.16.191.8]:22522 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S136759AbREAXM2>;
	Tue, 1 May 2001 19:12:28 -0400
Date: Wed, 2 May 2001 01:12:18 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200105012312.BAA61113.aeb@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, stian@sletner.com
Subject: Re: [PATCH] Dead keys
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The issue here is that the dead keys themselves
> are producing the wrong characters.

No. If someone without diaeresis key uses the double quote,
and attaches dead_diaeresis to it, she probably wants that
double quote when it is followed by a space.
When programming one needs quotes etc.
When writing text one needs a-umlaut and c-cedilla etc.
Very few people need a lone diaeresis. I do not mind if most
people would need an additional keystroke to obtain that.

> the dead_* are wrong, and I can't change them with a keymap, afaik?

Yes, you can. Linux keyboard handling is very flexible.

You can change the table of compose definitions with loadkeys,
and there is no restriction of what is combined with what.
You can also make any symbol into a dead symbol.

Example:

% loadkeys
plain keycode 53 = 0x0d2f
compose '/' 'o' to '\370'
%

This makes the slash (on my keyboard) into a dead slash:
when followed by an o I get the Danish oslash (ø),
and otherwise it remains a slash.

Explanation of the loadkeys input: 
The first line makes unadorned [no Shift, Ctrl, Alt] slash
(on my keyboard the key with keytop / has keycode 53 as showkey tells me)
into a dead ASCII slash. The 0d part is for "dead".
The 2f part is hex for the ASCII slash (octal 057).
The combine statement adds a combination to the compose table.
(Maybe it was there already - didnt check.)
For 2f and 370, see ascii(7) and iso_8859-1(7).

Andries

[Yes, a very small example, and the input contains numbers
in decimal, octal and hexadecimal.]

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280464AbRJaUZu>; Wed, 31 Oct 2001 15:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280480AbRJaUZl>; Wed, 31 Oct 2001 15:25:41 -0500
Received: from cerberus.blazeconnect.net ([208.255.12.239]:29200 "EHLO
	monolith.blazeconnect.net") by vger.kernel.org with ESMTP
	id <S280464AbRJaUZ2>; Wed, 31 Oct 2001 15:25:28 -0500
Subject: 2.4.13 devfs related problem...I think
From: "Greg A. Bur" <greg@blazeconnect.net>
To: Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13 (Preview Release)
Date: 31 Oct 2001 15:26:03 -0500
Message-Id: <1004559963.6241.8.camel@anubis>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Last weekend I downloaded a tarball of kernel 2.4.13 and proceeded to
build it for my system.  The compile went cleanly as expected and when I
did a depmod -a I didn't get any unresolved symbols.  After rebooting
the computer I ran into a strange problem.  Just after the message
"Backspace key sends ^?" the machine apparently locked up.  There was no
activity from the harddrive although I could toggle the caps lock,
scroll lock and numlock keys on the keyboard.  The usual three finger
salute illicited no response(I have it disabled in /etc/inittab which
may be the reason.)  Out of frustration I cycled the power and booted
back into my previous kernel, 2.4.9.  I compiled 2.4.13 again and
removed a few experimental options I had enabled, IPv6 and such.  Again
I rebooted and the results were the same.  After doing some searching on
Google I ran across a problem with the pts file system and the dev file
system.  Again I recompiled disabling the pts file system.  Again the
system hung at "Backspace key sends ^?."  After booting back to the
2.4.9 kernel, I compiled a 2.4.13 _without_ devfs support.  Upon doing
so the machine proceeded to boot normally.  This has me very puzzled.
My question is am I doing something wrong?  Was there some documentation
I neglected to read that would explain this to me?  It isn't absolutely
mission critical that I am running the 2.4.13 kernel I just like to
remain current.  Judging by the traffic here on the list I'm guessing we
are edging closer to 2.4.14 which I will most likely try if I can't
figure out a solution for my current problem.  If anyone has any
suggestions or perhaps can point me in the right direction I would
greatly appreciate it.  Thank you in advance to anyone who may take time
to assist me.

-- 

Greg A. Bur
Secretary/Treasurer BlazeConnect Inc.
greg@blazeconnect.net
http://www.blazeconnect.net
Voice:  (231)597-0376
Fax:    (231)597-0393


-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Gnome PGP version 0.4

mQGiBDsmr/oRBACKyg093fkecRe/U88oWPmPfTkb+39vXFEADEnICQuu0FXaiYJY
JrvZyudbUIH3ndqYP6MELApVhyP3fxt950E3VhWzyDBB3Y0ER/9muIp49pYSRk6U
pKRv/gZMWd2wzdgkD9u7utCyrBnTm8u4C6S5h4RpG5KQkkXVRLAdaSI7LwCgxC1a
f2z9E8OVLqf9LC1Gzi6G4gkD/2WTBJr/O7JD0dUVXkZoSUWcNsE8nyX7RSNV5lK0
buEvGa7I4Pe9+a+2JOHy2slcApP/32mNpJlh61K5UkxHmzwadNt86s6JGLzmN/uJ
AvD+tD7GGrc5EhqA0FZkiHObHukAEoVALgBy9LorVGwPh9lOA3s7aKRF/3l/v8YI
pMIkA/0avqGC3AKRdU9b6QNekgzq/C+huAUT7wPO5e8wNwUbWzAvzMd1BU8UtMp7
sitb+A5y7QVzgUSq+jgSY7VVhL8W5LnLongKhn/aC2JqI425TCFTXPBN/BTryFUx
GieKgxkZAMbzLRGBQPuvCMIOabj5DXTHtL4fzwHKhCfNkISQfLQjR3JlZyBBLiBC
dXIgPGdyZWdAYmxhemVjb25uZWN0Lm5ldD6IXQQTEQIAHQUCOyav+gUJAeEzgAUL
BwoDBAMVAwIDFgIBAheAAAoJEIOucOLj5OPKE9AAn25bOxcJhRLggto+iJhYjR9d
q33rAKCrn7fzo9/ix0zADAj3zFEOPlZn1bkBDQQ7JrAFEAQAvb4l9wYO5/fIEhgA
YB/HQJSK2v6L61/eCtjxxP8HrgOkYb+3ThLfAPFnIqkKTG1U1rakuewuCvXMKQCq
Yw5iTdBeyU7GZ7C+RoYLWDjYuTd43+LAVgvjP3p8YUEsnDA+JeRuAvokAyzGwNz8
DXbRXLpxQl72mT0C+zmk4BABeVcABAsD/RLC8yE5YRWJCzpZui3eMWVEWT18BdtJ
DevXu/nWyUvgdrFxQFwxD1TVMAhJRW4MpfwNpx/ABCr79THfG7N/6oBcw51EbaYn
4B6o6VWCmQKzhEY5VGp4m2GehR5d/FcONp9u41/cpB56jiAAQjKhIS07rUf8sZbh
YCxZWgQhsMr8iEwEGBECAAwFAjsmsAUFCQHhM4AACgkQg65w4uPk48rpFQCfVVMC
CdzWGjWBcy+sLhZY6esj4I0AoLZiZa8rPDbzRy87faoki5BGbTuo
=EU8Q
-----END PGP PUBLIC KEY BLOCK-----


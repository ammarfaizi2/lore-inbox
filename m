Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289665AbSAJT34>; Thu, 10 Jan 2002 14:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289624AbSAJT2O>; Thu, 10 Jan 2002 14:28:14 -0500
Received: from zeus.kernel.org ([204.152.189.113]:17823 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S289645AbSAJT1M>;
	Thu, 10 Jan 2002 14:27:12 -0500
Date: Thu, 10 Jan 2002 13:37:12 -0500
From: Bob Toxen <bob@cavu.com>
Message-Id: <200201101837.g0AIbCO02438@cavu.com>
To: jdthood@mail.com, linux-kernel@vger.kernel.org,
        linux-laptop@vger.kernel.org
Subject: Re: [PATCH] Combined APM patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Just browsing the diff between my patch and Stephen's, I have
> a couple of questions.

> < static int			suspends_pending; /* = 0 */
> ---
> > static int			suspends_pending;

> Is it not good practice to note when the code _assumes_ zero-
> initialization?  I have seen comments like these elsewhere in
> the kernel sources.

Comments should _not_ echo code.  One should assumes that the reader
knows the language.  Instead, comments should explain _what the purpose_
of that line of code or section of code is if it is not obvious to those
that the comments are written to.

Thus, the following should be considered correct:

static int			suspends_pending;

Both of the following lines have superfluous code or commants and should
be avoided:

static int			suspends_pending; /* = 0 */
static int			suspends_pending = 0;

Likewise, parentheses where none are needed just get in the way of useful
stuff and slows down understanding the program.  Some parentheses in
complex expressions or when the precedence of operator evaluation is
confusing, such as bitwise ops can be helpful.

Btw, I have been writing system-level c code for 26 years and learned by
reading and modifying Unix system code at Berkeley.

Best regards,

Bob Toxen, CTO
Fly-By-Day Consulting, Inc.           "Experts in Linux & network security"
bob@cavu.com
http://www.cavu.com                   [Linux/Unix & Network Security Consulting]
http://www.realworldlinuxsecurity.com [My 5* book: "Real World Linux Security"]
http://www.cavu.com/sunset.html       [Sunset Computer]
Quality Linux, UNIX and network security and software consulting since 1990.

GPG Public key available at http://www.cavu.com/pubkey.txt (book@cavu.com)
  and at http://pgp5.ai.mit.edu/pks-commands.html#extract
  and on the CD-ROM that comes sealed and attached to Real World Linux Security
pub  1024D/E3A1C540 2000-06-21 Bob Toxen <book@cavu.com>
     Key fingerprint = 30BA AA0A 31DD B68B 47C9  601E 96D3 533D E3A1 C540
sub  2048g/03FFCCB9 2000-06-21

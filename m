Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289988AbSAKPWg>; Fri, 11 Jan 2002 10:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289987AbSAKPW0>; Fri, 11 Jan 2002 10:22:26 -0500
Received: from smtp04.wxs.nl ([195.121.6.59]:36080 "EHLO smtp04.wxs.nl")
	by vger.kernel.org with ESMTP id <S289984AbSAKPWU>;
	Fri, 11 Jan 2002 10:22:20 -0500
Subject: Re: [PATCH] Combined APM patch
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 11 Jan 2002 10:22:24 -0500
Message-Id: <1010762545.788.2.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Is it not good practice to note when the code _assumes_ zero-
>> initialization?  I have seen comments like these elsewhere in
>> the kernel sources.
>
> Comments should _not_ echo code.  One should assumes that the reader
> knows the language.  Instead, comments should explain _what the
> purpose_  of that line of code or section of code is if it is not
> obvious to those that the comments are written to.

I agree that comments should not try to explain C to the
reader.  Comments should provide additional information,
such as telling the reader what the code is supposed to
do (as opposed to what it actually does, which may or may
not be the same thing).

In the line
    static int suspends_pending; /* = 0 */
the comment is not there to tell the reader that the variable
is initialized to zero.  It is there to tell the reader that
the variable _needs to be_ initialized to zero in order for
the code to work properly.  This is useful information,
because if someone later wants to modify the code to make
this variable non-static, the comment tells that person that
the variable will need an initializer.

--
Thomas






Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316223AbSEQN7c>; Fri, 17 May 2002 09:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316225AbSEQN7b>; Fri, 17 May 2002 09:59:31 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:526 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S316223AbSEQN7b>; Fri, 17 May 2002 09:59:31 -0400
Message-Id: <200205171355.g4HDtaY22326@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Rusty Russell <rusty@rustcorp.com.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: AUDIT: copy_from_user is a deathtrap.
Date: Fri, 17 May 2002 15:58:03 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E178hJU-0002GS-00@wagner.rustcorp.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 May 2002 10:58, Rusty Russell wrote:
> > > 	/* of course this returns 0 or -EFAULT! */
> > > 	return copy_from_user(xxx);
> >
> > So lets verify and fix them. Post the list to the kenrel janitors
>
> Again, like we did 12 months ago you mean?
>
> We could do that, or, we could fix the actual problem, which is the
> HUGE FUCKING BEARTRAP WHICH CATCHES EVERY SINGLE NEW PROGRAMMER ON THE
> WAY THROUGH.

Looks like it is waiting for me yet (if I'll ever do something useful
for lk).

> Not fixing earlier was criminal, not fixing it today is insane.

What's the problem? People don't understand what copy_x_user() returns
and how to check return value properly?

Maybe good function name(s) will help?

copy_{from,to}_user_and_count()

> There are 415 uses of copy_to/from_user which are wrong, despite an
> audit 12 months ago by the Stanford checker.

What are typical errors?
--
vda

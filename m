Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265592AbRGEXut>; Thu, 5 Jul 2001 19:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265603AbRGEXuj>; Thu, 5 Jul 2001 19:50:39 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:11014 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S265592AbRGEXuc>; Thu, 5 Jul 2001 19:50:32 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: linux/macros.h(new) and linux/list.h(mod) ...
Date: Fri, 6 Jul 2001 01:54:07 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <XFMail.20010705162149.davidel@xmailserver.org> <0107060149080M.03760@starship>
In-Reply-To: <0107060149080M.03760@starship>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <0107060154070N.03760@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 July 2001 01:49, you wrote:
> On Friday 06 July 2001 01:21, Davide Libenzi wrote:
> > On 05-Jul-2001 Alan Cox wrote:
> > >> Life's a bitch.
> > >> cf. get_user(__ret_gu, __val_gu); (on i386)
> > >>
> > >> Time to invent a gcc extension which gives us unique names? :)
> > >
> > >#define min(a,b) __magic_minfoo(a,b, __var##__LINE__, __var2##__LINE__)
> > >
> > >#define __magic_minfoo(A,B,C,D) \
> > >       { typeof(A) C = (A)  .... }
> >
> > Anyway I think that :
> >
> > int _a = 5;
> >
> > for (;;) {
> >         int _a = _a;
> >         ...
> > }
> >
> > must :
> >
> > 1) assign the upper level value of _a
> >
> > or :
> >
> > 2) generate an compiler error
>
> Well, I happen to agree with you, but in this case, c's scope rules
> are stupidly broken, they are not going to change, and we have to
> live with it ;-)
>
> --
> Daniel

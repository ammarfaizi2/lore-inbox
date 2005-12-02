Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbVLBNVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbVLBNVp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 08:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbVLBNVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 08:21:45 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:61839 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1750726AbVLBNVo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 08:21:44 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Coywolf Qi Hunt <coywolf@gmail.com>
Subject: Re: Use enum to declare errno values
Date: Fri, 2 Dec 2005 15:20:52 +0200
User-Agent: KMail/1.8.2
Cc: Pekka Enberg <penberg@cs.helsinki.fi>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Paul Jackson <pj@sgi.com>, francis_moreau2000@yahoo.fr,
       linux-kernel@vger.kernel.org
References: <20051123132443.32793.qmail@web25813.mail.ukl.yahoo.com> <84144f020512020418x7ebf5e3bt54cde14ec6a7a954@mail.gmail.com> <2cd57c900512020456n2f31101k@mail.gmail.com>
In-Reply-To: <2cd57c900512020456n2f31101k@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512021520.53191.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 December 2005 14:56, Coywolf Qi Hunt wrote:
> 2005/12/2, Pekka Enberg <penberg@cs.helsinki.fi>:
> > Hi,
> >
> > 2005/12/2, Denis Vlasenko <vda@ilport.com.ua>:
> > > > There is another reason why enums are better than #defines:
> >
> > On 12/2/05, Coywolf Qi Hunt <coywolf@gmail.com> wrote:
> > > This is a reason why enums are worse than #defines.
> > >
> > > Unlike in other languages, C enum is not much useful in practices.
> > > Maybe the designer wanted C to be as fancy as other languages?  C
> > > shouldn't have had enum imho. Anyway we don't have any strong motives
> > > to switch to enums.
> >
> > I don't follow your reasoning. The naming collision is a real problem
> > with macros. With enum and const, the compiler can do proper checking
> > with meaningful error messages. Please explain why you think #define
> > is better for Denis' example?
> >
> >                                      Pekka
> 
> That is a bad bad style. It should be `#define FOO 123' if you have to
> write it.

I suspect this style was invented exactly as a device to stop confusing
macro names with variable/function names.

> It's also hard to see what the confusing bar is "if you are looking at
> file.c alone".

int f(int foo, int bar) {...}

bar is a parameter of type "int" of function f(). What else it could be here?
It's basic C.

> enum is worse than typdef.  Don't you see why we should use `struct
> task_struct', rather than `task_t'?
>
> Introducing enum alone can't solve the problems from bad macro usage
> habits. Actually, it's not anything wrong with macros, it's
> programers' bad coding style.
> 
> Macros play an important role in C, but enums don't.

Looks more like your personal dislike to enum keyword.
--
vda

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbVLDNKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbVLDNKk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 08:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbVLDNKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 08:10:40 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:62357 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S932206AbVLDNKk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 08:10:40 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Vadim Lobanov <vlobanov@speakeasy.net>
Subject: Re: Use enum to declare errno values
Date: Sun, 4 Dec 2005 15:10:18 +0200
User-Agent: KMail/1.8.2
Cc: Bill Davidsen <davidsen@tmr.com>, Coywolf Qi Hunt <coywolf@gmail.com>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Paul Jackson <pj@sgi.com>, francis_moreau2000@yahoo.fr,
       linux-kernel@vger.kernel.org
References: <20051123132443.32793.qmail@web25813.mail.ukl.yahoo.com> <4390701C.1030803@tmr.com> <Pine.LNX.4.58.0512020844560.27440@shell4.speakeasy.net>
In-Reply-To: <Pine.LNX.4.58.0512020844560.27440@shell4.speakeasy.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512041510.18662.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 December 2005 18:56, Vadim Lobanov wrote:
> On Fri, 2 Dec 2005, Bill Davidsen wrote:
> 
> > Coywolf Qi Hunt wrote:
> > >
> > > That is a bad bad style. It should be `#define FOO 123' if you have to
> > > write it.
> > >
> > > It's also hard to see what the confusing bar is "if you are looking at
> > > file.c alone".
> > >
> > > enum is worse than typdef.  Don't you see why we should use `struct
> > > task_struct', rather than `task_t'?
> > >
> > > Introducing enum alone can't solve the problems from bad macro usage
> > > habits. Actually, it's not anything wrong with macros, it's
> > > programers' bad coding style.
> >
> > Using enum doesn't *solve* problems, it does *allow* type checking, and
> > *prevent* namespace pollution. Use of typedef allows future changes, if
> > you use "struct XXX" you're stuck with it.
> 
> You're not stuck with anything onerous in this case. Namely,
> 
> If you have "enum XXX" and you want to go to "enum YYY", then...
> 	sed 's/enum XXX/enum YYY/g'
> If you have "struct XXX" and you want to go to "struct YYY", then...
> 	sed 's/struct XXX/struct YYY/g'
> If you have "enum XXX" and you want to go to "struct YYY", then...
> This is a big change, and should be done with care anyway. If struct YYY
> happens to be large, then suddenly you can get all sorts of nifty stack
> overflows.

I was talking about _anonymous enums_. There you do not have enum XXX,
you have only named constants of type int:

enum { CONST = 12345 };

CONST is of type "int" here.
--
vda

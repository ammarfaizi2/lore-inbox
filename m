Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313686AbSDHQGL>; Mon, 8 Apr 2002 12:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313688AbSDHQGK>; Mon, 8 Apr 2002 12:06:10 -0400
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23]:55988 "EHLO
	mel-rto4.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S313686AbSDHQGJ>; Mon, 8 Apr 2002 12:06:09 -0400
Message-ID: <00a801c1df17$55295ae0$95dc0e50@machine1>
From: "Philippe Elie" <phil.el@wanadoo.fr>
To: "Bill Davidsen" <davidsen@tmr.com>,
        "John Levon" <movement@marcelothewonderpenguin.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.96.1020408104259.21476B-100000@gatekeeper.tmr.com>
Subject: Re: Two fixes for 2.4.19-pre5-ac3
Date: Mon, 8 Apr 2002 18:06:18 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Bill Davidsen" <davidsen@tmr.com>
Sent: Monday, April 08, 2002 4:48 PM


> On Sun, 7 Apr 2002, John Levon wrote:
>
> > But what about the recent discussion on the removal of sys_call_table ?
> >
> > (I believe it was along the lines of "it's ugly, prevent it ...", "ah,
> > but it has real uses, so why can't it stay as deprecated/unadvised ?"
> > "*no response*").
> >
> > I'm a bit disappointed this has just gone in without any real discussion
> > on the usefulness of this for certain circumstances :(
>
>   Sure, removing that would break a lot of cracker software. Oh wait,
> maybe that's a good thing...

It's really easy for cracker to patch sys_call even if it the table is not
exported. Not exporting the sys call table is just to encourage good
programming technics not a protection against machiavel things.

>   For legitimate use, if any, a compile-time optional system call could be
> added requiring a capability to use, and programs which are currently
> doing that (AFS?) can be converted to use another f/s interface. I have
> seen a few mentions of software which DO use that capability, I'm not sure
> I've seen one which can be done no other way.

As stated oprofile needs it, there is no other efficient way to track exec,
mmap and other sys call needed for profiler. I hope a consensus can
be reach : explain than unloading module wich patch the sys call table
are unsafe on SMP, discourage the use of sys call table patch, but do
not forbid that.

--
Philippe Elie



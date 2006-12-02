Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162947AbWLBLBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162947AbWLBLBZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 06:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162946AbWLBLBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 06:01:05 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:27140 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1162934AbWLBLAt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 06:00:49 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: Willy Tarreau <w@1wt.eu>
Subject: Re: [2.4 PATCH] missing parenthesis
Date: Sat, 2 Dec 2006 12:00:24 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <200612011510.58990.m.kozlowski@tuxland.pl> <20061201174035.GA18203@1wt.eu>
In-Reply-To: <20061201174035.GA18203@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612021200.24989.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willy, 

> Thanks for your work at fixing all this code. I'm wondering though,
> given the type of errors, this code should never have been able to
> build at all, so that means that it might not be used at all.

Either not used or #ifdef'ed so much that it is rarely build.

> As a general rule of thumb, keep in mind that we're not much tempted
> to fix known unused code, especially if it's unmaintained. The reason

Maybe dumb question but ... how do I know which parts of code are unused
and/or unmaintained?

> is simple : when some code does not work, people who need it often
> maintain patches in their tree to make it work. When we start changing
> things there, their patches often apply with rejects. Anyway, *I* am
> still for a clean kernel because I know that there's nothing more
> annoying than spending days chasing a bug which we discover was known
> for years.
> 
> So what I can propose you is that we :
>   - postpone those patches for 2.4.35-pre

Ok.

>   - ask maintainers of each of these files if he accepts to fix the
>     file, because some of them are totally against any such change.

Ok. Couple of questions:

- how do we do that?
- do I resend each patch to proper maintainer?
- if there is no maintainer then what? (btw. is there any other
more accurate source of MAINTAINERS for each file in the kernel tree?)
- do I have to resend them once more to LKML?

>   - we would merge the accepted patches and those without any reply
>     which we consider relevant early in the 35-pre cycle so that
>     people have some time to inform us about the potential conflicts
>     they encounter.
> 
> Quite frankly, there should be very few problems, considering that we
> have affected more files with the gcc4 patches and that nobody
> complained.
> 
> As an exception, if you get some maintainer's approval for some of
> the patches during 2.4.34 cycle, of course I will merge them first
> because as I said, it's important to maintain supported code in good
> shape.
> 
> Is it OK for you ?

Sure.

-- 
Regards,

	Mariusz Kozlowski

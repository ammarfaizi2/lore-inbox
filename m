Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751301AbVLaE7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbVLaE7u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 23:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbVLaE7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 23:59:50 -0500
Received: from dial169-116.awalnet.net ([213.184.169.116]:42246 "EHLO
	raad.intranet") by vger.kernel.org with ESMTP id S1751301AbVLaE7t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 23:59:49 -0500
From: Al Boldi <a1426z@gawab.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] strict VM overcommit accounting for 2.4.32/2.4.33-pre1
Date: Sat, 31 Dec 2005 07:59:02 +0300
User-Agent: KMail/1.5
Cc: barryn@pobox.com, linux-kernel@vger.kernel.org
References: <200512302306.28667.a1426z@gawab.com> <1135990502.28365.43.camel@localhost.localdomain>
In-Reply-To: <1135990502.28365.43.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512310759.02962.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Gwe, 2005-12-30 at 23:06 +0300, Al Boldi wrote:
> > > +3 - (NEW) paranoid overcommit The total address space commit
> > > +      for the system is not permitted to exceed swap. The machine
> > > +      will never kill a process accessing pages it has mapped
> > > +      except due to a bug (ie report it!)
> >
> > This one isn't in 2.6, which is critical for a stable system.
>
> Actually it is
>
> In the 2.4 case we took  "50% RAM + swap" as the safe sane world 'never
> OOM kill' and to all intents and purposes it works. We also had a 100%
> paranoia mode.
>
> When it was ported to 2.6 (not by me) whoever did it very sensibly made
> the percentage tunable and removed "mode 3" since its mode 2 0% ram and
> can be set that way.

Only, doesn't this imply that you cannot control overcommit unless backed by 
swap?  i.e Without swap the kernel cannot use all of ram, because it would 
overcommit no-matter what, thus invoking OOM-killer.

Which raises an important question:  What's overcommit to do with limiting 
access to physical RAM?

Thanks!

--
Al


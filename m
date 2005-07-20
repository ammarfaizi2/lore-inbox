Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261478AbVGTJZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261478AbVGTJZr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 05:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbVGTJZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 05:25:47 -0400
Received: from mail.yosifov.net ([193.200.14.114]:13746 "EHLO home.yosifov.net")
	by vger.kernel.org with ESMTP id S261478AbVGTJZn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 05:25:43 -0400
Subject: Re: Noob question. Why is the for-pentium4 kernel built
	with	-march=i686 ?
From: Ivan Yosifov <ivan@yosifov.net>
Reply-To: ivan@yosifov.net
To: Kerin Millar <kerframil@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1121852642.18129.39.camel@localhost>
References: <1121792852.11857.6.camel@home.yosifov.net>
	 <Pine.LNX.4.61.0507191950020.89@yvahk01.tjqt.qr>
	 <1121798151.15700.9.camel@home.yosifov.net>
	 <pan.2005.07.20.08.03.25.15476@gmail.com>
	 <1121847799.31603.5.camel@home.yosifov.net>
	 <1121852642.18129.39.camel@localhost>
Content-Type: text/plain
Date: Wed, 20 Jul 2005 12:25:07 +0300
Message-Id: <1121851507.10454.3.camel@home.yosifov.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> <snip>
> 
> > > Also, I believe that the -march=pentium4 option /was/ actually used up
> > > until kernel 2.6.10 where it was dropped because of a risk that some
> > > versions of gcc would cause the kernel to use SSE registers for data
> > > movement (which is a no-no).
> > > 
> > 
> > You seem right. I fetched a 2.6.9 tarball and it is really built with
> > -march=pentium4. Do you know which are versions of gcc in question ?
> > 
> 
> No, I'm afraid not. I only know that the advice came from Richard
> Henderson who (I think) is one of the core glibc hackers. You can see
> the point at which it was introduced by Linus in the ChangeLog (2nd
> message from last):
> 
> http://www.kernel.org/pub/linux/kernel/v2.6/ChangeLog-2.6.10

Seems to be this one:

<torvalds@ppc970.osdl.org>
	Don't use "-march=pentium3" for gcc tuning.
	
	rth tells me that some versions of gcc may end up using the
	SSE registers for data movement when you do that.
	
	Use "-march=i686 -mtune=xxxx" instead.
	
	(We do the same thing for march=pentium2/4 too, just for
	consistency).


The way it is worded it seems that it is a problem with *some* versions
of gcc only on p3, not p4.

Cheers,
Ivan Yosifov.




Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263212AbTIATLv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 15:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263238AbTIATLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 15:11:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25263 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263212AbTIATLs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 15:11:48 -0400
Date: Mon, 1 Sep 2003 16:14:25 -0300 (BRT)
From: Marcelo Tosatti <marcelo@parcelfarce.linux.theplanet.co.uk>
X-X-Sender: marcelo@logos.cnet
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "J.A. Magallon" <jamagallon@able.es>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] check_gcc for i386
In-Reply-To: <Pine.LNX.4.44.0308310003050.20930-100000@logos.cnet>
Message-ID: <Pine.LNX.4.44.0309011612190.6008-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 31 Aug 2003, Marcelo Tosatti wrote:

> 
> 
> On Sat, 30 Aug 2003, Jeff Garzik wrote:
> 
> > Alan Cox wrote:
> > > On Sad, 2003-08-30 at 23:58, Marcelo Tosatti wrote:
> > > 
> > >>> ifdef CONFIG_MPENTIUM4
> > >>>-CFLAGS += -march=i686
> > >>>+CFLAGS += $(call check_gcc,-march=pentium4,-march=i686)
> > >>> endif
> > >>> 
> > >>> ifdef CONFIG_MK6
> > >>
> > >>OK, I forgot what that does. Can you please explain in detail what 
> > >>check_gcc does. 
> > > 
> > > 
> > > Tries to use gcc with the options given and if not falls back to the
> > > second set suggested. So it'll try -march=pentium4 (new gcc) and 
> > > fall back to -march=i686
> > 
> > 
> > Yep.  I introduced check_gcc into 2.4 (backported from 2.5), in fact.
> > 
> > The above change does exactly what Alan describes, and is a patch I was 
> > planning to submit myself :)  I did not want to change compiler options 
> > at the time when I submitted the check_gcc patch, but after many months 
> > of manually patching to get the best compiler flags, it seems solid.
> 
> I'm just worried about having nicey gcc surprises. Alan thinks its ok, and 
> you too so I guess I'll just apply it tomorrow and see what happens

Changed my mind: I already have enough thinks to care about in 2.4.23 and 
I prefer NOT accepting such changes instead of doing them. I might change 
my mind once 2.4.23 is out. 


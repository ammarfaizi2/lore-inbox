Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267645AbSKTHTu>; Wed, 20 Nov 2002 02:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267643AbSKTHTu>; Wed, 20 Nov 2002 02:19:50 -0500
Received: from dp.samba.org ([66.70.73.150]:50387 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265890AbSKTHTs>;
	Wed, 20 Nov 2002 02:19:48 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Doug Ledford <dledford@redhat.com>
Cc: Alexander Viro <viro@math.psu.edu>,
       Linux Scsi Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Why /dev/sdc1 doesn't show up... 
In-reply-to: Your message of "Mon, 18 Nov 2002 19:09:24 CDT."
             <20021119000924.GD6989@redhat.com> 
Date: Wed, 20 Nov 2002 07:58:13 +1100
Message-Id: <20021120072653.E1EC72C060@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021119000924.GD6989@redhat.com> you write:
> On Tue, Nov 19, 2002 at 10:49:21AM +1100, Rusty Russell wrote:
> > In message <Pine.GSO.4.21.0211180403440.23400-100000@steklov.math.psu.edu> 
you 
> > write:
> > > Not really.  For case in question (block devices) there is only one path
> > > and I'd rather keep it that way, thank you very much.
> > 
> > See other posting.  This is a fundamental design decision, and it's
> > not changing.  Sorry.
> 
> Then you'll have to back out the patch to module.c because it's already 
> changed.

Yeah, I just noticed.  To be honest, I was wrong.  And the code
shouldn't be put back until (if ever) I have a solution which solves
the races and *doesn't* break working code.

And meanwhile, there are more important things (like reducing the 400k
overhead of CONFIG_KALLSYMS adds to the kernel).

Sorry for the overzealousness,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

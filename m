Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316952AbSFQSze>; Mon, 17 Jun 2002 14:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316953AbSFQSzd>; Mon, 17 Jun 2002 14:55:33 -0400
Received: from unthought.net ([212.97.129.24]:59057 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S316952AbSFQSzc>;
	Mon, 17 Jun 2002 14:55:32 -0400
Date: Mon, 17 Jun 2002 20:55:33 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Marco Colombo <marco@esi.it>
Cc: Roberto Fichera <kernel@tekno-soft.it>,
       Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
       David Schwartz <davids@webmaster.com>, linux-kernel@vger.kernel.org
Subject: Re: Developing multi-threading applications
Message-ID: <20020617185532.GC7974@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Marco Colombo <marco@esi.it>, Roberto Fichera <kernel@tekno-soft.it>,
	Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
	David Schwartz <davids@webmaster.com>, linux-kernel@vger.kernel.org
References: <5.1.1.6.0.20020617094803.00a96bd0@mail.tekno-soft.it> <Pine.LNX.4.44.0206171755340.1449-100000@Megathlon.ESI>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0206171755340.1449-100000@Megathlon.ESI>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2002 at 06:07:51PM +0200, Marco Colombo wrote:
> On Mon, 17 Jun 2002, Roberto Fichera wrote:
> 
> [...]
> > process to a CPU. But I continue to not hunderstand why
> > I must have only one thread per CPU. There is some URL
> > where can I see some kernel/sched/vm/I-O/other-think graph about
> > this point ?
> 
> To put it simply, because you have only one PC per CPU. It's not
> really an OS thing.
> 
> Every time you're saving the PC (and SP, and all the "thread context")
> you're "emulating" more CPUs on just one. And what you got is just...
> an emulation. A Thread is an execution abstraction, and a CPU is an
> execution actor. Sounds sensible to match the two. Use functions instead
> to group instructions by their (functional) meaning.

It is common to use many threads per processor on some operating
systems. But this is (in my experience) because of the lack of proper
non-blocking APIs on said OS.

You can emulate non-blocking APIs with threads and a blocking API. And
on some systems you simply have to.

On GNU/Linux this is not generally a problem.  And as Marco said, you
really shouldn't have to do that.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:

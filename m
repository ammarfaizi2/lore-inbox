Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262655AbTCIWsT>; Sun, 9 Mar 2003 17:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262656AbTCIWsT>; Sun, 9 Mar 2003 17:48:19 -0500
Received: from mx12.arcor-online.net ([151.189.8.88]:30420 "EHLO
	mx12.arcor-online.net") by vger.kernel.org with ESMTP
	id <S262655AbTCIWsS>; Sun, 9 Mar 2003 17:48:18 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Zack Brown <zbrown@tumblerings.org>, linux-kernel@vger.kernel.org
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Date: Tue, 11 Mar 2003 00:03:18 +0100
X-Mailer: KMail [version 1.3.2]
References: <200303020011.QAA13450@adam.yggdrasil.com> <20030309000514.GB1807@work.bitmover.com> <20030309024522.GA25121@renegade>
In-Reply-To: <20030309024522.GA25121@renegade>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20030309225857.0FAC7101207@mx12.arcor-online.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 09 Mar 03 03:45, Zack Brown wrote:
> OK, so here is my distillation of Larry's post.
>
>   Basic summary: a distributed, replicated, version controlled user level
> file system with no limits on any of the file system events which may
> happened in parallel. All changes must be put correctly back together, no
> matter how much parallelism there has been.
>
>   * Merging.
>
>   * The graph structure.
>
>   * Distributed rename handling. Centralized systems like Subversion don't
>   have as many problems with this because you can only create one file in
>   one directory entry because there is only one directory entry available.
>   In distributed rename handling, there can be an infinite number of
> different files which all want to be src/foo.c. There are also many rename
> corner-cases.
>
>   * Symbolic tags. This is adding a symbolic label on a revision. A
> distributed system must handle the fact that the same symbol can be put on
> multiple revisions. This is a variation of file renaming. One important
> thing to consider is that time can go forward or backward.
>
>   * Security semantics. Where should they go? How can they be integrated
>   into the system? How are hostile users handled when there is no central
>   server to lock down?
>
>   * Time semantics. A distributed system cannot depend on reported time
>   being correct. It can go forward or backward at any rate.
>
> I'd be willing to maintain this as the beginning of a feature list and
> post it regularly to lkml if enough people feel it would be useful and not
> annoying. The goal would be to identify the features/problems that would
> need to be handled by a kernel-ready version control system.
>
> Be well,
> Zack

Hi Zack,

You might want to have a look here, there's lots of good stuff:

   http://arx.fifthvision.net/bin/view/Arx/LinuxKernel
   (Kernel Hackers SCM wish list)

   http://arx.fifthvision.net/bin/view/Arx/GccHackers
   (Gcc Hackers SCM wish list)

Arx is a fork of Tom Lord's Arch, now in version 1.0pre5.

Regards,

Daniel

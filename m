Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316825AbSGVLoa>; Mon, 22 Jul 2002 07:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316835AbSGVLo3>; Mon, 22 Jul 2002 07:44:29 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:53757 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316825AbSGVLo3>; Mon, 22 Jul 2002 07:44:29 -0400
Subject: Re: [PATCH] strict VM overcommit
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Szakacsits Szabolcs <szaka@sienet.hu>
Cc: Adrian Bunk <bunk@fs.tum.de>, Robert Love <rml@tech9.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0207220937570.614-100000@divine.city.tvnet.hu>
References: <Pine.LNX.4.30.0207220937570.614-100000@divine.city.tvnet.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 22 Jul 2002 14:00:09 +0100
Message-Id: <1027342809.31782.28.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-22 at 09:08, Szakacsits Szabolcs wrote:
> > > kill can't kill processes in uninterruptible sleep, etc, etc)? Why the
> > In these cases the kernel infrastructure doesn't support the ability to
> > recover from such a state,
> 
> You again anwered else but ironically you just rebute yourself that
> there are cases when the system knows better then the admin.

And purists consider those flaws

> What the patch claims is no OOM. In the swapoff case potentially there
> are OOM's. This is called bug (the feature not follows the behavior
> what it specified when admin turned it on). Why do you call this bug
> perfectly handled case? What differentiate this case from all other
> when the system knows better not to destroy your data without at least
> a "force" operation for example?

Lets put this bluntly. Your swapdisk is losing sectors left right and
centre. You propose a system where the kernel says "sorry might cause an
OOM" and I lose everything as the disk goes down. Letting the admin set
policy means I can swapoff, maybe lose a program or two to OOM but not
lose the entire system in the process.

Its quite clear that being able to override the kernels assumptions
about what is right are sensible. It always has been


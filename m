Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264528AbSIVUsF>; Sun, 22 Sep 2002 16:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264538AbSIVUrM>; Sun, 22 Sep 2002 16:47:12 -0400
Received: from [195.39.17.254] ([195.39.17.254]:11136 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S264528AbSIVUrI>;
	Sun, 22 Sep 2002 16:47:08 -0400
Date: Tue, 17 Sep 2002 15:31:14 +0000
From: Pavel Machek <pavel@suse.cz>
To: Martin Mares <mj@ucw.cz>
Cc: Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process() elimination, 2.5.35-BK
Message-ID: <20020917153114.A35@toy.ucw.cz>
References: <20020918164553.GB28202@holomorphy.com> <Pine.LNX.4.44.0209181932580.24794-100000@localhost.localdomain> <20020919192758.GA430@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020919192758.GA430@ucw.cz>; from mj@ucw.cz on Thu, Sep 19, 2002 at 09:27:58PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > nevertheless we do lock up for 32 seconds if there are 32K PIDs allocated
> > in a row and last_pid hits that range - regardless of pid_max. (Depending
> > on the cache architecture it could take significantly more.)
> 
> What about randomizing the PID selection a bit? I.e., allocate PIDs
> consecutively as long as they are free; if you hit an already used
> PID, roll dice to find a new position where the search should be
> continued. As long as the allocated fraction of PID space is reasonably
> small, this algorithm should be very quick in average case.

Problem is it may take infinite time if you are unlucky...
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.


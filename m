Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130061AbRBTNBf>; Tue, 20 Feb 2001 08:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130164AbRBTNBQ>; Tue, 20 Feb 2001 08:01:16 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:11269 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S130061AbRBTNBI>; Tue, 20 Feb 2001 08:01:08 -0500
Date: Tue, 20 Feb 2001 07:00:41 -0600
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new setprocuid syscall
Message-ID: <20010220070041.A12011@cadcamlab.org>
In-Reply-To: <Pine.A41.4.31.0102192312330.174604-100000@pandora.inf.elte.hu> <20010219230106.A23699@cadcamlab.org> <3A924CA1.10C913E7@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3A924CA1.10C913E7@evision-ventures.com>; from dalecki@evision-ventures.com on Tue, Feb 20, 2001 at 11:53:21AM +0100
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  [Peter Samuelson]
> > Race -- you need to make sure the task_struct doesn't disappear out
> > from under you.
> > 
> > Anyway, why not use the interface 'chown uid /proc/pid'?  No new
> > syscall, no arch-dependent part, no user-space tool, etc.

[Martin Dalecki]
> Becouse of exactly the same race condition as above maybe?

OK then, what is the right way to make sure a task doesn't disappear?
I assumed 'read_lock (&tasklist_lock)' was enough, from reading other
code.

Peter

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262576AbSKDTKM>; Mon, 4 Nov 2002 14:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262580AbSKDTKL>; Mon, 4 Nov 2002 14:10:11 -0500
Received: from almesberger.net ([63.105.73.239]:12809 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S262576AbSKDTKL>; Mon, 4 Nov 2002 14:10:11 -0500
Date: Mon, 4 Nov 2002 16:16:36 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Anu <avaidya@unity.ncsu.edu>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: an idling kernel
Message-ID: <20021104161636.A1407@almesberger.net>
References: <3DC3C1AA.7060602@zytor.com> <Pine.GSO.4.44.0211021518290.6197-100000@sun.cesr.ncsu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0211021518290.6197-100000@sun.cesr.ncsu.edu>; from avaidya@unity.ncsu.edu on Sat, Nov 02, 2002 at 03:37:04PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anu wrote:
> 	Im ready to be beaten up for asking this question ( I am not sure
> which group to post to -- all this is new to me) but, I was wondering how
> one could figure out if the kernel was in idle mode (or idling).

There's more to is than just processes: if your kernel has runnable
tasklets or pending interrupts, it is not truly idle, even though
there may be no runnable processes.

In umlsim, I have some heuristics that seem to catch most cases, but
may be a bit too paranoid. Look at timer.c:wait_kernel (called from
idle) in http://www.almesberger.net/umlsim/umlsim-4.tar.gz

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/

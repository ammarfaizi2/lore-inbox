Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262143AbSJNTxB>; Mon, 14 Oct 2002 15:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262144AbSJNTxA>; Mon, 14 Oct 2002 15:53:00 -0400
Received: from numenor.qualcomm.com ([129.46.51.58]:36230 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id <S262143AbSJNTw4>; Mon, 14 Oct 2002 15:52:56 -0400
Message-Id: <5.1.0.14.2.20021014125359.0843e4d8@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 14 Oct 2002 12:58:22 -0700
To: Ingo Molnar <mingo@elte.hu>
From: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
Subject: Re: [RFC] Rename _bh to _softirq 
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
In-Reply-To: <Pine.LNX.4.44.0210142119300.26635-100000@localhost.localdo
 main>
References: <5.1.0.14.2.20021014115238.084140f8@mail1.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:21 PM 10/14/2002 +0200, Ingo Molnar wrote:

>On Mon, 14 Oct 2002, Maksim (Max) Krasnyanskiy wrote:
>
> > Old BHs have been almost completely replaced with tasklets and softirqs.
> > Should we then rename _bh to _softirq ?
> > i.e
> >          local_bh_disable()      ->      local_softirq_disable()
> >          spin_lock_bh()          ->      spin_lock_softirq()
> >          bh_lock_sock()          ->      softirq_sock_lock()
> >          etc
>
>i wanted to do this as part of the irqlock cleanups, but generally we dont
>change existing interfaces unless it's really universally agreed upon. Eg.
>we had cli() around for a *long* time although it's an x86 (-mostly)
>instruction name. But yes, i agree, and there are a number of other
>renames that would make perfect sense.

We can keep compatibility defines, just like we have for cli().
i.e.
         #define local_bh_disable local_softirq_disable

Max



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318086AbSGWIx1>; Tue, 23 Jul 2002 04:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318088AbSGWIx0>; Tue, 23 Jul 2002 04:53:26 -0400
Received: from mx2.elte.hu ([157.181.151.9]:9161 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S318086AbSGWIx0>;
	Tue, 23 Jul 2002 04:53:26 -0400
Date: Tue, 23 Jul 2002 10:55:23 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: george anzinger <george@mvista.com>
Cc: Diego Calleja <diegocg@teleline.es>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.27: do_softirq
In-Reply-To: <3D3C8C43.F65E7ED1@mvista.com>
Message-ID: <Pine.LNX.4.44.0207231050130.2980-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 22 Jul 2002, george anzinger wrote:

> > This is the output of readprofile | sort -nr:
> > It shows too much calls to do_softirq ( i don't know what it means but i
> > hope it can help)
> >
> Maybe _local_bh_enable() should check to see if the call is needed
> before it calls....

it does in Linus' latest BK tree, which can also be downloaded from:

  http://redhat.com/~mingo/irqlock-removal-patches/diff-bk-020723-2.5.27.bz2

(patch against 2.5.27-vanilla.) It includes all the irqlock related
patches.

	Ingo


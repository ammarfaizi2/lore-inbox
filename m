Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285449AbRL2Uuo>; Sat, 29 Dec 2001 15:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285506AbRL2Uue>; Sat, 29 Dec 2001 15:50:34 -0500
Received: from w147.z064001233.sjc-ca.dsl.cnc.net ([64.1.233.147]:56966 "EHLO
	funky.gghcwest.COM") by vger.kernel.org with ESMTP
	id <S285449AbRL2UuU>; Sat, 29 Dec 2001 15:50:20 -0500
Date: Sat, 29 Dec 2001 12:49:20 -0800 (PST)
From: "Jeffrey W. Baker" <jwbaker@acm.org>
X-X-Sender: <jwb@windmill.gghcwest.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.17 absurd number of context switches
In-Reply-To: <E16K0OX-00015u-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0112291248290.30167-100000@windmill.gghcwest.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 28 Dec 2001, Alan Cox wrote:

> > Check out those figures for context switches!  30,000 switches per second
> > with only three runnable processes and practically no block I/O seems
> > quite high to me.  You can also see that the system is spending half its
> ..
> > Is this a scheduler worst-case, something to be expected, or something I
> > can work around?
>
> The scheduler is _good_ at the three process case. Run some straces it looks
> more like postgres is doing wacky yield based locks.

As it turns out, Postgres 7.2 is forcing all this context switching, and
it really hasn't got anything to do with the kernel.

-jwb


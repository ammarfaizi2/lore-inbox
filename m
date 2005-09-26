Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932142AbVIZHaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbVIZHaY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 03:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932424AbVIZHaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 03:30:24 -0400
Received: from mailgate.urz.uni-halle.de ([141.48.3.51]:26273 "EHLO
	mailgate.uni-halle.de") by vger.kernel.org with ESMTP
	id S932142AbVIZHaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 03:30:23 -0400
Date: Mon, 26 Sep 2005 09:30:11 +0200 (METDST)
From: Clemens Ladisch <clemens@ladisch.de>
To: Karsten Wiese <annabellesgarden@yahoo.de>
cc: <linux-kernel@vger.kernel.org>, Bob Picco <bob.picco@hp.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 2/2] HPET: make frequency calculations 32 bit safe
In-Reply-To: <200509240146.22715.annabellesgarden@yahoo.de>
Message-ID: <Pine.HPX.4.33n.0509260926110.13755-100000@studcom.urz.uni-halle.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scan-Signature: ddcb1167275539a271faf4605d0b8e77
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karsten Wiese wrote:
> > --- linux-2.6.13.orig/drivers/char/hpet.c       2005-09-22 11:10:01.000000000 +0200
> > +++ linux-2.6.13/drivers/char/hpet.c    2005-09-22 12:08:48.000000000 +0200
> > ...
> > -       unsigned long hp_period;
> > +       unsigned long long hp_tick_freq;
>
> An 'unsigned long' is enough.
> Are we expecting hpets stepping at more than 4GHz?

The HPET specification allows up to 10 GHz.

> They are called 'legacy' in some docs already ;-)

Do these docs mention a non-legacy alternative?

> Here the via8237's hpet runs at ~14MHz.

AFAIK all current implementations still use the good ol' 14.138180MHz
timer.


Regards,
Clemens


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129391AbRBRTh7>; Sun, 18 Feb 2001 14:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129394AbRBRTht>; Sun, 18 Feb 2001 14:37:49 -0500
Received: from ferret.lmh.ox.ac.uk ([163.1.18.131]:55313 "HELO
	ferret.lmh.ox.ac.uk") by vger.kernel.org with SMTP
	id <S129391AbRBRThf>; Sun, 18 Feb 2001 14:37:35 -0500
Date: Sun, 18 Feb 2001 19:37:33 +0000 (GMT)
From: Chris Evans <chris@scary.beasts.org>
To: <kuznet@ms2.inr.ac.ru>
cc: <linux-kernel@vger.kernel.org>, <davem@redhat.com>
Subject: Re: SO_SNDTIMEO: 2.4 kernel bugs
In-Reply-To: <200102181933.WAA27194@ms2.inr.ac.ru>
Message-ID: <Pine.LNX.4.30.0102181935130.31140-100000@ferret.lmh.ox.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 18 Feb 2001 kuznet@ms2.inr.ac.ru wrote:

> Hello!
>
> > So the actual timeout would be 2 * SO_SNDTIMEO.
>
> It will timeout if write of some page blocks for SO_SNDTIMEO.

.. unless that page was partially written, in which case a short write
count is returned (rather than a timeout error), and the loop goes around
again.

> If transmission of any page never takes more than SO_SNDTIMEO it never
> times out.

Which is good, because SO_SNDTIMEO is an inactivity monitor.

Cheers
Chris


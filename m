Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262891AbSITQfH>; Fri, 20 Sep 2002 12:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262894AbSITQfH>; Fri, 20 Sep 2002 12:35:07 -0400
Received: from mx2.elte.hu ([157.181.151.9]:55207 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S262891AbSITQfG>;
	Fri, 20 Sep 2002 12:35:06 -0400
Date: Fri, 20 Sep 2002 18:47:41 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: "Hanumanthu. H" <hanumanthu.hanok@wipro.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE:  [patch] generic-pidhash-2.5.36-D4, BK-curr
In-Reply-To: <Pine.LNX.4.33.0209201838030.2801-100000@ccvsbarc.wipro.com>
Message-ID: <Pine.LNX.4.44.0209201843510.8689-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 20 Sep 2002, Hanumanthu. H wrote:

> First of all, using bitmap is not that good as exposed in this
> mailing list (I think some good guys at IBM already implememted
> bitmap for pids as part of Linux scalability enhancements & [...]

i mentioned that patch in earlier emails, and it is a whole different
thing. The patch built a completely new bitmap *every* time we hit an
already allocated PID, to find the next 'safe range'. The new PID
allocator in 2.5.37 keeps one bitmap and does a single set-bit map
operation in the fastpath and does a fast bitscan forward even in the
worst case.

> remember they discussed pros & cons too) & [...]

(that approach was pretty gross i have to say.)

> [...] atomic operations are not that cheap anyway. [...]

huh?

	Ingo


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284458AbRLEQXN>; Wed, 5 Dec 2001 11:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284449AbRLEQW4>; Wed, 5 Dec 2001 11:22:56 -0500
Received: from mustard.heime.net ([194.234.65.222]:11413 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S283759AbRLEQWB>; Wed, 5 Dec 2001 11:22:01 -0500
Date: Wed, 5 Dec 2001 17:21:47 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: <linux-kernel@vger.kernel.org>
Subject: /proc/sys/vm/(max|min)-readahead effect????
Message-ID: <Pine.LNX.4.30.0112051713200.2297-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all

I've just upgraded to 2.4.16 to get /proc/sys/vm/(max|min)-readahead
available. I've got this idea...

If lots of files (some hundered) are read simultaously, I waste all the
i/o time in seeks. However, if I increase the readahead, it'll read more
data at a time, and end up with seeking a lot less.

The harddrive I'm testing this with, is a cheap 20G IDE drive. It can give
me a peak thoughput of about 28 MB/s (reading).
When running 10 simultanous dd jobs ('dd if=filenr of=/dev/null bs=4m'), I
peaks at some 8,5 MB/s no matter what I set the min/max readahead to!!

Is this correct?

Is there perhaps another way to set the real readahead? In source???

Thanks a lot for all help

roy

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.


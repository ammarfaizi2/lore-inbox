Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284786AbRLXMK0>; Mon, 24 Dec 2001 07:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284775AbRLXMKG>; Mon, 24 Dec 2001 07:10:06 -0500
Received: from mustard.heime.net ([194.234.65.222]:43481 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S284766AbRLXMJ5>; Mon, 24 Dec 2001 07:09:57 -0500
Date: Mon, 24 Dec 2001 13:09:31 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: <linux-kernel@vger.kernel.org>
Subject: Caching problems while reading multiple large files...
Message-ID: <Pine.LNX.4.30.0112232018170.11923-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all

Some time ago, I sent a message regarding what I thought had to be the
RAID subsystem. I'm more convinced that this is the buffer cache messing
up.

scenario:

read 200 large files from disk concurrently (for instance dd of=file01
of=/dev/null, dd of=file02 of=/dev/null &c.).

As this is a 2x120g IDE RAID-0 config, I get pretty good throughtput,
eveny though I'm reading multiple files concurrently (40-50 megs per sec).

But...At the time I've read ~800 megs of data (which is the same amount as
the free memory before I start), it suddenly slows down to a mere 1 meg
per sec.

But... If I try doing another i/o operation, even to the same block
device, it works fine.

Can anyone help me out here?

roy

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.



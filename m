Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284648AbRLEUHg>; Wed, 5 Dec 2001 15:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284645AbRLEUHU>; Wed, 5 Dec 2001 15:07:20 -0500
Received: from mustard.heime.net ([194.234.65.222]:30870 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S284646AbRLEUGh>; Wed, 5 Dec 2001 15:06:37 -0500
Date: Wed, 5 Dec 2001 21:06:04 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: James Stevenson <mail-lists@stev.org>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>, <linux-kernel@vger.kernel.org>
Subject: Re: /proc/sys/vm/(max|min)-readahead effect????
In-Reply-To: <019401c17dc5$2e946130$0801a8c0@Stev.org>
Message-ID: <Pine.LNX.4.30.0112052100470.3740-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> thats still does not mean they are sequential creating
> large files almost always causes them to fragment.

ok...
mkfs /dev/hdb1
dd if=/dev/zero of=some-file bs=x count=x

		What can fragment this file????


after that - wget http://localhost/some-file - watch vmstat, and find it's
pushing data at around 28 MB/s

then - start ten wget's retrieving different files, and watch vmstat,
finding the maximum thoughput I can get is ~ 10 MB/s - almost one third.

If I could tell the kernel, the app (tux) or whatever, to do readahead -
say some 4 megs per file, it'd work like hell! Seeks are reduced to a
minimum and everyone's happy again

> Actually does anyone know of an easy way to find out
> if certin files are fragmented and by how much ?

I beleive there used to be a utility called 'frag' or something, to check
the fragmentation of files

roy
--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.


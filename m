Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319563AbSIHDh1>; Sat, 7 Sep 2002 23:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319564AbSIHDh0>; Sat, 7 Sep 2002 23:37:26 -0400
Received: from CPE00606767ed59.cpe.net.cable.rogers.com ([24.112.38.222]:44040
	"EHLO cpe00606767ed59.cpe.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id <S319563AbSIHDh0>; Sat, 7 Sep 2002 23:37:26 -0400
Date: Sat, 7 Sep 2002 23:43:23 -0400 (EDT)
From: "D. Hugh Redelmeier" <hugh@mimosa.com>
Reply-To: "D. Hugh Redelmeier" <hugh@mimosa.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Marco Colombo <marco@esi.it>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
In-Reply-To: <1029760150.19376.14.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0209072328240.21724-100000@redshift.mimosa.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

| From: Alan Cox <alan@lxorguk.ukuu.org.uk>
| Date: 19 Aug 2002 13:29:10 +0100

| On Mon, 2002-08-19 at 11:47, Marco Colombo wrote:
| > BTW, I know you wrote the amd768-rng driver, I wonder if you have any
| > indication of how good these rng are. What is the typical output bits/
| > random bits ratio in normal applications?
| 
| It seems random. People have subjected both the intel and AMD one to
| statistical test sets. I'm not a cryptographer or a statistician so I
| can't answer usefully

[Note: I am not a cryptographer.]

The Intel (and, I assume, the AMD) hardware random generator cannot be
audited.  There is no way to tell if it is a RNG.  These days, you
don't need to be paranoid to lack trust in such devices.

Governments could easily pressure Intel or AMD in a number of ways.
Perhaps other forces could corrupt the RNG implementation.

I've heard that Intel's RNG "whitens" its output in a way that hides
failure and makes analysis difficult.  This cannot be turned off.
This doesn't add to my confidence.

Adding the putative RNG's output to the pool is a Good Thing.
Depending on it may not be.

Hugh Redelmeier
hugh@mimosa.com  voice: +1 416 482-8253

